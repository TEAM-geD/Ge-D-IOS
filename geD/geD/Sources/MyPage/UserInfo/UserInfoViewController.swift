//
//  UserInfoViewController.swift
//  geD
//
//  Created by 김민순 on 2021/08/01.
//

import UIKit

class UserInfoViewController: BaseViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var plannerButton: UIButton!
    @IBOutlet weak var developerButton: UIButton!
    @IBOutlet weak var designerButton: UIButton!
    @IBOutlet weak var introduceTextView: UITextView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var doneView: UIView!
    @IBOutlet weak var tableHeightConstraint: NSLayoutConstraint!
    var rowCount = 1
    var selectedSnsCellIdx = 0
    var isDeveloper = false
    var isDesigner = false
    var isPlanner = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dismissKeyboardWhenTappedAround()
        placeholderSetting()
        self.title = "내 정보 수정"
        profileImageView.layer.cornerRadius = 20
        
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
    
    @IBAction func plannerButtonPressed(_ sender: UIButton) {
        isPlanner = !isPlanner
        setJobButtonImage()
    }
    
    @IBAction func developerButtonPressed(_ sender: UIButton) {
        isDeveloper = !isDeveloper
        setJobButtonImage()
    }
    
    @IBAction func designerButtonPressed(_ sender: UIButton) {
        isDesigner = !isDesigner
        setJobButtonImage()
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
