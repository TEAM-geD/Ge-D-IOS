//
//  LoginDataManager.swift
//  geD
//
//  Created by 김민순 on 2021/06/14.
//

import Alamofire
import KeychainSwift
import FirebaseMessaging

class LoginDataManager {
    let deviceToken = Messaging.messaging().fcmToken!
    func kakaoLogin(_ accessToken: String, viewController: LoginViewController) {
        let headers: HTTPHeaders = ["KAKAO-ACCESS-TOKEN" : accessToken, "DEVICE-TOKEN" : deviceToken]
        AF.request("\(Constant.BASE_URL)/users/kakao-signin", method: .post, headers: headers).validate().responseDecodable(of: LoginResponse.self) { response in
            switch response.result {
            case .success(let response):
                let message = response.message
                if response.isSuccess {
                    // 로그인 성공
                    print(message)
                    print(response.result!.jwt)
                    let keyChain = KeychainSwift()
                    keyChain.set(response.result!.jwt, forKey: "jwtToken")
                    viewController.goToMain()
                } else {
                    switch response.code {
                    default:
                        print(message)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
                viewController.presentAlert(title: "서버와의 연결이 원할하지 않습니다.")
            }
        }
    }
    
    func naverLogin(_ accessToken: String, viewController: LoginViewController) {
        let headers: HTTPHeaders = ["NAVER-ACCESS-TOKEN" : accessToken, "DEVICE-TOKEN" : deviceToken]
        AF.request("\(Constant.BASE_URL)/users/naver-signin", method: .post, headers: headers).validate().responseDecodable(of: LoginResponse.self) { response in
            switch response.result {
            case .success(let response):
                let message = response.message
                if response.isSuccess {
                    // 로그인 성공
                    print(message)
                    print(response.result!.jwt)
                    let keyChain = KeychainSwift()
                    keyChain.set(response.result!.jwt, forKey: "jwtToken")
                    viewController.goToMain()
                } else {
                    switch response.code {
                    default:
                        print(message)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
                viewController.presentAlert(title: "서버와의 연결이 원할하지 않습니다.")
            }
        }
    }
    
    func appleLogin(_ parameters: LoginInput,_ idToken: String, viewController: LoginViewController) {
        let headers: HTTPHeaders = ["APPLE-ID-TOKEN" : idToken, "DEVICE-TOKEN" : deviceToken]
        AF.request("\(Constant.BASE_URL)/users/apple-signin", method: .post, parameters: parameters, encoder: JSONParameterEncoder.default, headers: headers).validate().responseDecodable(of: LoginResponse.self) { response in
            switch response.result {
            case .success(let response):
                let message = response.message
                if response.isSuccess {
                    // 로그인 성공
                    print(message)
                    print(response.result!.jwt)
                    let keyChain = KeychainSwift()
                    keyChain.set(response.result!.jwt, forKey: "jwtToken")
                    viewController.goToMain()
                } else {
                    switch response.code {
                    default:
                        print(message)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
                viewController.presentAlert(title: "서버와의 연결이 원할하지 않습니다.")
            }
        }
    }
    
}
