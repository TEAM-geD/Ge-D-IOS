//
//  LoginViewController.swift
//  geD
//
//  Created by 김민순 on 2021/06/07.
//

import UIKit
import KakaoSDKUser
import KeychainSwift

class LoginViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.hidesBackButton = true
    }
    
    @IBAction func kakaoLoginButtonPresed(_ sender: UIButton) {
        UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
            if let error = error {
                print(error)
                print("Login with Kakao account")
                self.loginWithKakaoAcount()
            }
            else {
                print("loginWithKakaoTalk() success.")
//                //do something
                self.showIndicator()
                if let oauthToken = oauthToken {
                    let accessToken = oauthToken.accessToken
                    let input = LoginInput(accessToken: accessToken)
                    LoginDataManager().login(input, viewController: self)
                }
                
                _ = oauthToken
            }
        }
        
        
    }
    
    func loginWithKakaoAcount() {
        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
            if let error = error {
                print(error)
            }
            else {
                print("loginWithKakaoAccount() success.")
                
                //do something
                
                self.showIndicator()
                if let oauthToken = oauthToken {
                    let accessToken = oauthToken.accessToken
                    let input = LoginInput(accessToken: accessToken)
                    LoginDataManager().login(input, viewController: self)
                }

                _ = oauthToken

            }
        }
    }
}
