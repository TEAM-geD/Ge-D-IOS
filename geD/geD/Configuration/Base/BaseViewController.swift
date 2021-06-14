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
        
        // MARK: 아래 예시들처럼 상황에 맞게 활용하시면 됩니다.
        // Navigation Bar
//        self.navigationController?.navigationBar.titleTextAttributes = [
//            .font : UIFont.NotoSans(.medium, size: 16),
//        ]
        // Background Color
//        self.view.backgroundColor = .white
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
        let loginViewController = storyboard.instantiateViewController(identifier: Constant.loginViewControllerIdentifier)
        
        changeRootViewController(loginViewController)
    }
}
