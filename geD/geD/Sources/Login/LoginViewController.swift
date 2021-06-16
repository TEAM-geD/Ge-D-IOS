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
import AuthenticationServices

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
        
        showIndicator()
        
        let input = LoginInput(accessToken: accessToken)
        LoginDataManager().naverLogin(input, viewController: self)
    }
    
    @IBAction func appleLoginButtonPressed(_ sender: UIButton) {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self as? ASAuthorizationControllerPresentationContextProviding
        controller.performRequests()
    }
}

//MARK: - Naver Login
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


//MARK: - Apple Login

extension LoginViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let credential = authorization.credential as? ASAuthorizationAppleIDCredential {
            
            let idToken = credential.identityToken!
            let tokeStr = String(data: idToken, encoding: .utf8)
            print(tokeStr!)
            
            guard let code = credential.authorizationCode else { return }
            let codeStr = String(data: code, encoding: .utf8)
            print(codeStr!)
            
            let user = credential.user
            print("User ID : \(user)")
            
            let email = credential.email
            print("User Email : \(email ?? "")")
            
            let fullName = credential.fullName
            print("User Name : \(fullName?.givenName ?? "") + \(fullName?.familyName ?? "")")
            
            showIndicator()
            goToMain()
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print(error.localizedDescription)
    }
}
