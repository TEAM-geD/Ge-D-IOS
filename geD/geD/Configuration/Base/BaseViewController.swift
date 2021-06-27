//
//  BaseViewController.swift
//  geD
//
//  Created by 김민순 on 2021/05/24.
//

import UIKit
import KeychainSwift

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // View Background Color
        view.backgroundColor = UIColor(hex: 0x2B2B2B)
        
        // Navigation Bar
        if self.navigationController?.isNavigationBarHidden == false {
            navigationBarLayout()
        }
        
        // Navigation Back Button
        let backButtonImage = UIImage(named: "icBack")?.withAlignmentRectInsets(UIEdgeInsets(top: 0, left: -12, bottom: 0, right: 12))
        self.navigationController?.navigationBar.backIndicatorImage = backButtonImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backButtonImage
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    func navigationBarLayout() {
        self.navigationController?.navigationBar.isTransparent = true
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationItem.backBarButtonItem?.tintColor = .white
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.titleTextAttributes = [
            .font : UIFont.systemFont(ofSize: 16, weight: .semibold),
            .foregroundColor : UIColor.black
        ]
    }
    
    func isLogin() -> Bool {
        let keyChain = KeychainSwift()
        if keyChain.get("jwtToken") != nil {
            return true
        } else {
            return false
        }
    }
    
    func goToMain() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainTabBarController = storyboard.instantiateViewController(identifier: Constant.mainTabBarControllerIdentifier)
        
        changeRootViewController(mainTabBarController)
    }
    
    func goToLogin() {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let loginViewController = storyboard.instantiateViewController(identifier: Constant.loginNavigationControllerIdentifier)
        
        changeRootViewController(loginViewController)
    }
}
