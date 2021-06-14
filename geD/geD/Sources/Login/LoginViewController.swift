//
//  LoginViewController.swift
//  geD
//
//  Created by 김민순 on 2021/06/07.
//

import UIKit
import KakaoSDKUser
import NaverThirdPartyLogin
import KeychainSwift

class LoginViewController: BaseViewController {

    let naverLoginInstance = NaverThirdPartyLoginConnection.getSharedInstance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 네이버 로그아웃
        naverLoginInstance?.requestDeleteToken()

        // Do any additional setup after loading the view.
        naverLoginInstance?.delegate = self
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
                    LoginDataManager().kakaoLogin(input, viewController: self)
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
                    LoginDataManager().kakaoLogin(input, viewController: self)
                }

                _ = oauthToken

            }
        }
    }
    
    @IBAction func naverLoginButtonPressed(_ sender: UIButton) {
        naverLoginInstance?.requestThirdPartyLogin()
    }
    
    func getNaverInfo() {
        guard let isValidAccessToken = naverLoginInstance?.isValidAccessTokenExpireTimeNow() else { return }
        
        if !isValidAccessToken {
            return
        }
        
        guard let accessToken = naverLoginInstance?.accessToken else { return }
        
        print("Access Token : \(accessToken)")
        
        let input = LoginInput(accessToken: accessToken)
        LoginDataManager().naverLogin(input, viewController: self)
    }
}

extension LoginViewController: NaverThirdPartyLoginConnectionDelegate {
    func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
        print("네이버 액세스 토큰 가져오기 성공!")
        getNaverInfo()
    }
    
    func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() {
    }
    
    func oauth20ConnectionDidFinishDeleteToken() {
    }
    
    func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: Error!) {
        print(error.localizedDescription)
    }
    
    
}
