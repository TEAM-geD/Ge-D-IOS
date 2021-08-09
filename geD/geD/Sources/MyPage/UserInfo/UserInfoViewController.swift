//
//  UserInfoViewController.swift
//  geD
//
//  Created by 김민순 on 2021/08/01.
//

import UIKit
import Kingfisher
import KeychainSwift

class UserInfoViewController: BaseViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userProfileNameLabel: UILabel!
    @IBOutlet weak var plannerButton: UIButton!
    @IBOutlet weak var developerButton: UIButton!
    @IBOutlet weak var designerButton: UIButton!
    @IBOutlet weak var introduceTextView: UITextView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var membersOpenSwitch: UISwitch!
    @IBOutlet weak var doneView: UIView!
    @IBOutlet weak var tableHeightConstraint: NSLayoutConstraint!
    var rowCount = 1
    var selectedSnsCellIdx = 0
    var imageType = 0
    var isDeveloper = false
    var isDesigner = false
    var isPlanner = false
    
    let jwtToken = KeychainSwift().get("jwtToken")!
    let userIdx = KeychainSwift().get("userIdx")!
    let dataManager = UserInfoDataManager()
    
    let profileImagePickerController = UIImagePickerController()
    let coverImagePickerController = UIImagePickerController()
    let alertController = UIAlertController(title: "사진 선택", message: "아래 방법으로 이미지를 선택해주세요", preferredStyle: .actionSheet)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showIndicator()
        
        dataManager.getUserInfo(jwtToken, userIdx, viewController: self)
        
        dismissKeyboardWhenTappedAround()
        placeholderSetting()
        self.title = "내 정보 수정"
        profileImageView.layer.cornerRadius = 20
        self.profileImagePickerController.delegate = self
        self.coverImagePickerController.delegate = self
        enrollAlertEvent()
        
        // Set Job Button Image
        setJobButtonImage()
        
        introduceTextView.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        contentView.snp.makeConstraints { make in
            make.bottom.equalTo(doneView.snp.bottom)
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: Constant.snsTableViewCellIdentifier, bundle: nil), forCellReuseIdentifier: Constant.snsTableViewCellIdentifier)
        tableView.separatorStyle = .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func updateUI(_ userInfo: UserInfoResult) {
        DispatchQueue.main.async {
            self.userProfileNameLabel.text = userInfo.userName
            self.userNameLabel.text = userInfo.userName
            if let introduce = userInfo.introduce {
                self.introduceTextView.text = introduce
            }
            if let backgroundImageUrl = userInfo.backgroundImageUrl {
                let downsamplingProcessor = DownsamplingImageProcessor(size: self.coverImageView.bounds.size)
                self.coverImageView.kf.setImage(
                    with: URL(string: backgroundImageUrl),
                    options: [
                        .processor(downsamplingProcessor),
                        .scaleFactor(UIScreen.main.scale),
                        .cacheOriginalImage
                    ]
                )
            }
            if let profileImageUrl = userInfo.profileImageUrl {
                let downsamplingProcessor = DownsamplingImageProcessor(size: self.profileImageView.bounds.size)
                let roundCornerProcessor = RoundCornerImageProcessor(cornerRadius: 20)
                self.profileImageView.kf.setImage(
                    with: URL(string: profileImageUrl),
                    options: [
                        .processor(downsamplingProcessor |> roundCornerProcessor),
                        .scaleFactor(UIScreen.main.scale),
                        .cacheOriginalImage
                    ]
                )
            }
            if let userJob = userInfo.userJob {
                switch userJob {
                case "기획자":
                    self.isPlanner = true
                case "개발자":
                    self.isDeveloper = true
                case "디자이너":
                    self.isDesigner = true
                default:
                    self.setJobButtonImage()
                }
            }
            
            if let members = userInfo.isMembers {
                if members == "Y" {
                    self.membersOpenSwitch.isOn = true
                } else {
                    self.membersOpenSwitch.isOn = false
                }
            }
        }
    }
    
    @objc func keyboardWillShow(notification:NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        var contentInset:UIEdgeInsets = self.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height + 50
        scrollView.contentInset = contentInset
    }
    
    @objc func keyboardWillHide(notification:NSNotification) {
        let contentInset: UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
    }
    
    func setJobButtonImage() {
        if isPlanner {
            plannerButton.setImage(UIImage(named: "icProjectwritePlanner"), for: .normal)
        } else {
            plannerButton.setImage(UIImage(named: "icProjectwritePlannerGray"), for: .normal)
        }
        if isDeveloper {
            developerButton.setImage(UIImage(named: "icProjectwriteDeveloper"), for: .normal)
        } else {
            developerButton.setImage(UIImage(named: "icProjectwriteDeveloperGray"), for: .normal)
        }
        if isDesigner {
            designerButton.setImage(UIImage(named: "icProjectwriteDesigner"), for: .normal)
        } else {
            designerButton.setImage(UIImage(named: "icProjectwriteDesignerGray"), for: .normal)
        }
    }
    
    @IBAction func pressProfileImageButton(_ sender: UIButton) {
        imageType = 0
        self.alertController.title = "프로필 이미지 선택"
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func pressCoverImageButton(_ sender: UIButton) {
        self.alertController.title = "커버 이미지 선택"
        imageType = 1
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func plannerButtonPressed(_ sender: UIButton) {
        isPlanner = !isPlanner
        isDesigner = false
        isDeveloper = false
        setJobButtonImage()
    }
    
    @IBAction func developerButtonPressed(_ sender: UIButton) {
        isDeveloper = !isDeveloper
        isDesigner = false
        isPlanner = false
        setJobButtonImage()
    }
    
    @IBAction func designerButtonPressed(_ sender: UIButton) {
        isDesigner = !isDesigner
        isPlanner = false
        isDeveloper = false
        setJobButtonImage()
    }
    
    func enrollAlertEvent() {
        let photoLibraryAlertAction = UIAlertAction(title: "앨범에서 이미지 고르기", style: .default) {
            (action) in
            self.openAlbum(type: self.imageType)
        }
        let cameraAlertAction = UIAlertAction(title: "카메라", style: .default) {(action) in
            self.openCamera(type: self.imageType)
        }
        let cancelAlertAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        self.alertController.addAction(photoLibraryAlertAction)
        self.alertController.addAction(cameraAlertAction)
        self.alertController.addAction(cancelAlertAction)
        guard let alertControllerPopoverPresentationController
                = alertController.popoverPresentationController
        else {return}
        prepareForPopoverPresentation(alertControllerPopoverPresentationController)
    }
    
    func openAlbum(type: Int) {
        if type == 0 {
            self.profileImagePickerController.sourceType = .photoLibrary
            self.profileImagePickerController.allowsEditing = true
            present(self.profileImagePickerController, animated: false, completion: nil)
        } else {
            self.coverImagePickerController.sourceType = .photoLibrary
            present(self.coverImagePickerController, animated: false, completion: nil)
        }
    }
    
    func openCamera(type: Int) {
        if (UIImagePickerController.isSourceTypeAvailable(.camera)) {
            if type == 0 {
                self.profileImagePickerController.sourceType = .camera
                self.profileImagePickerController.allowsEditing = true
                present(self.profileImagePickerController, animated: false, completion: nil)
            } else {
                self.coverImagePickerController.sourceType = .camera
                present(self.coverImagePickerController, animated: false, completion: nil)
            }
        }
        else {
            print ("Camera's not available as for now.")
        }
    }
    
    @IBAction func pressDoneButton(_ sender: UIButton) {
        let cells = tableView.visibleCells as! [SnsTableViewCell]
        var snsUrlList: [String] = []
        
        if (isPlanner || isDeveloper || isDesigner) == false {
            self.presentAlert(title: "직군을 선택해주세요")
        } else if self.introduceTextView.text.count == 0 {
            self.presentAlert(title: "소개를 입력해주세요")
        } else {
            for cell in cells {
                if cell.urlTextField.text == "" {
                    presentAlert(title: "포트폴리오를 입력해주세요")
                    
                    return
                } else {
                    snsUrlList.append(cell.urlTextField.text!)
                }
                
            }
            
            var userJob = ""
            
            if isPlanner {
                userJob = "기획자"
            } else if isDeveloper {
                userJob = "개발자"
            } else {
                userJob = "디자이너"
            }
            
            var isMembers = ""
            
            if self.membersOpenSwitch.isOn {
                isMembers = "Y"
            } else {
                isMembers = "N"
            }
            
//            let userInfo = UserInfo(userName: userNameLabel.text!, introduce: introduceTextView.text, userJob: userJob, isMembers: isMembers, snsUrlList: snsUrlList)
            
//            showIndicator()
//            self.dataManager.ModifyUserInfo(self.jwtToken, self.userIdx, userInfo, viewController: self)
        }
        
    }
    
    func done() {
        
    }
}

extension UserInfoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.snsTableViewCellIdentifier, for: indexPath) as! SnsTableViewCell
        
        let touchButton = UIButton()
        touchButton.tag = indexPath.row
        touchButton.addTarget(self, action: #selector(pressSelectButton), for: .touchUpInside)
        cell.addSubview(touchButton)
        touchButton.snp.makeConstraints { make in
            make.edges.equalTo(cell.snsView.snp.edges)
        }
        
        if indexPath.row == 0 {
            let addButton = UIButton()
            addButton.setImage(UIImage(named: "icMyprofileAdd"), for: .normal)
            addButton.contentMode = .scaleAspectFill
            addButton.addTarget(self, action: #selector(pressAddButton), for: .touchUpInside)
            cell.addSubview(addButton)
            addButton.snp.makeConstraints { make in
                make.width.equalTo(30)
                make.height.equalTo(30)
                make.trailing.equalToSuperview().inset(20)
                make.centerY.equalToSuperview()
            }
            
        }
        
        return cell
    }
    
    @objc func pressAddButton() {
        if rowCount <= 6 {
            rowCount += 1
            self.tableHeightConstraint.constant = CGFloat(47 * rowCount)
            tableView.reloadData()
        } else {
            presentAlert(title: "포트폴리오는 최대 7개까지 등록할 수 있습니다.")
        }
    }
    
    @objc func pressSelectButton(_ sender: UIButton) {
        selectedSnsCellIdx = sender.tag
        let bottomVC = BottomSheetViewController()
        bottomVC.delegate = self
        bottomVC.modalPresentationStyle = .overFullScreen
        self.present(bottomVC, animated: true, completion: nil)
    }
    
}

extension UserInfoViewController: SnsDelegate {
    func selectSns(snsName: String, snsImageName: String) {
        let indexPath: IndexPath = IndexPath(row: self.selectedSnsCellIdx, section: 0)
        
        let cell = tableView.cellForRow(at: indexPath) as! SnsTableViewCell
        cell.snsName = snsName
        cell.snsIconButton.setImage(UIImage(named: snsImageName), for: .normal)
        cell.snsIconButton.setTitle("", for: .normal)
        tableView.reloadData()
    }
}

extension UserInfoViewController: UITextViewDelegate {
    func placeholderSetting() {
        introduceTextView.delegate = self
        introduceTextView.text = "간단한 소개를 입력해주세요."
        introduceTextView.textColor = .lightGray
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray {
            textView.text = nil
            textView.textColor = .white
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "간단한 소개를 입력해주세요."
            textView.textColor = .lightGray
        }
    }
}

extension UserInfoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if picker == profileImagePickerController {
            if let image =
                info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
                profileImageView.image = image
            } else {
                print("error")
            }
        } else {
            if let image =
                info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                coverImageView.image = image
            } else {
                print("error")
            }
        }
        
        
        dismiss(animated: true, completion: nil)
    }
}

extension UserInfoViewController: UIPopoverPresentationControllerDelegate {
    func prepareForPopoverPresentation(_ popoverPresentationController: UIPopoverPresentationController) {
        if let popoverPresentationController = self.alertController.popoverPresentationController {
            popoverPresentationController.sourceView = self.view
            popoverPresentationController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverPresentationController.permittedArrowDirections = []
        }
    }
}
