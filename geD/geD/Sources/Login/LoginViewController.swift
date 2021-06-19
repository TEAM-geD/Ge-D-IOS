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
                    LoginDataManager().kakaoLogin(accessToken, viewController: self)
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
                    LoginDataManager().kakaoLogin(accessToken, viewController: self)
                }

                _ = oauthToken

            }
        }
    }
    
    @IBAction func naverLoginButtonPressed(_ sender: UIButton) {
        naverLoginInstance?.resetToken()
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
        
        LoginDataManager().naverLogin(accessToken, viewController: self)
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
            print("ID Token: \(tokeStr ?? "")")
            
            let email = credential.email
            
            let fullName = credential.fullName
            var fullNameStr: String?
            if let familyName = fullName?.familyName, let givenName = fullName?.givenName {
                fullNameStr = familyName + givenName
            }
            print(fullNameStr ?? "")
            
            let input = LoginInput(userName: fullNameStr, userEmail: email)
            
            showIndicator()
            LoginDataManager().appleLogin(input, tokeStr!, viewController: self)
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print(error.localizedDescription)
    }
}
