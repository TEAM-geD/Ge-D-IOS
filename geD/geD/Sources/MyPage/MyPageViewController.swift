//
//  MyPageViewController.swift
//  geD
//
//  Created by 김민순 on 2021/05/31.
//

import UIKit
import KeychainSwift

class MyPageViewController: BaseViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var noUploadProjectView: UIView!
    @IBOutlet weak var profileView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentView.backgroundColor = UIColor(hex: 0x2B2B2B)
        profileImageView.layer.cornerRadius = 20
        noUploadProjectView.layer.cornerRadius = 10
        
        leftBarButtonItemLayout()
        rightBarButtonItemsLayout()
        
    }
    
    func leftBarButtonItemLayout() {
        let myPageBarButtonItem = UIBarButtonItem(image: UIImage(named: "imgMypage")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: nil)

        myPageBarButtonItem.isEnabled = false
        self.navigationItem.leftBarButtonItem = myPageBarButtonItem
    }
    
    func rightBarButtonItemsLayout() {
        let settingBarButtonItem = UIBarButtonItem(image: UIImage(named: "icMypageMore"), style: .plain, target: self, action: nil)
        self.navigationItem.rightBarButtonItem = settingBarButtonItem
    }
    
//    @IBAction func logoutButtonPressed(_ sender: UIButton) {
//        if isLogin() {
//            KeychainSwift().delete("jwtToken")
//        }
//
//        goToLogin()
//    }


}
