//
//  MyPageViewController.swift
//  geD
//
//  Created by 김민순 on 2021/05/31.
//

import UIKit
import KeychainSwift
import Kingfisher

class MyPageViewController: BaseViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userJobLabel: UILabel!
    @IBOutlet weak var userIntroduceLabel: UILabel!
    @IBOutlet weak var noUploadProjectView: UIView!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var myProjectLabel: UILabel!
    @IBOutlet weak var myNoProjectView: UIView!
    @IBOutlet weak var projectSegmented: CustomSegmentedControl!
    @IBOutlet weak var contentViewHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showIndicator()
        
        if let accessToken = KeychainSwift().get("jwtToken"), let userIdx = KeychainSwift().get("userIdx") {
            UserInfoDataManager().getUserInfo(accessToken, userIdx, viewController: self)
        } else {
            dismissIndicator()
        }
        
        userNameLabel.isUserInteractionEnabled = true
        userNameLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.moveUserInfoPage)))
        
        contentView.backgroundColor = UIColor(hex: 0x2B2B2B)
        profileImageView.layer.cornerRadius = 20
        noUploadProjectView.layer.cornerRadius = 10
        myNoProjectView.layer.cornerRadius = 10
        
        leftBarButtonItemLayout()
        rightBarButtonItemsLayout()
        
        projectSegmented.setButtonTitles(buttonTitles: ["전체","모집중","진행중","마감"])
        
        projectSegmented.backgroundColor = .clear
    }
    
    func updateUI(_ userInfo: UserInfoResult) {
        DispatchQueue.main.async {
            self.userNameLabel.text = userInfo.userName
            if let introduce = userInfo.introduce {
                self.userIntroduceLabel.text = introduce
            }
            if let profileImageUrl = userInfo.profileImageUrl {
                let downsamplingProcessor = DownsamplingImageProcessor(size: CGSize(width: 86, height: 86))
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
                self.userJobLabel.text = userJob
            }
        }
    }
    
    func leftBarButtonItemLayout() {
        let myPageBarButtonItem = UIBarButtonItem(image: UIImage(named: "imgMypage")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: nil)

        myPageBarButtonItem.isEnabled = false
        self.navigationItem.leftBarButtonItem = myPageBarButtonItem
    }
    
    func rightBarButtonItemsLayout() {
        let settingBarButtonItem = UIBarButtonItem(image: UIImage(named: "icMypageMore"), style: .plain, target: self, action: #selector(pressedSetting))
        self.navigationItem.rightBarButtonItem = settingBarButtonItem
    }
    
    @objc func pressedSetting() {
        let storyboard = UIStoryboard(name: "MyPage", bundle: nil)
        let settingViewController = storyboard.instantiateViewController(identifier: "SettingViewController")
        self.navigationController?.pushViewController(settingViewController, animated: true)
    }
    
    @objc func moveUserInfoPage() {
        if isLogin() {
            let storyBoard = UIStoryboard(name: "MyPage", bundle: nil)
            let infoVC = storyBoard.instantiateViewController(withIdentifier: Constant.userInfoViewControllerIdentifier)
            self.navigationController?.pushViewController(infoVC, animated: true)
        } else {
            goToLogin()
        }
    }
}
