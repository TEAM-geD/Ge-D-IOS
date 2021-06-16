//
//  MyPageViewController.swift
//  geD
//
//  Created by 김민순 on 2021/05/31.
//

import UIKit
import KeychainSwift

class MyPageViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logoutButtonPressed(_ sender: UIButton) {
        if isLogin() {
            KeychainSwift().delete("jwtToken")
        }
        
        goToLogin()
    }


}
