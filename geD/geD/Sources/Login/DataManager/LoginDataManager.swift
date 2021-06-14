//
//  LoginDataManager.swift
//  geD
//
//  Created by 김민순 on 2021/06/14.
//

import Alamofire
import KeychainSwift

class LoginDataManager {
    func login(_ loginInput: LoginInput, viewController: LoginViewController) {
        let headers: HTTPHeaders = ["KAKAO-ACCESS-TOKEN" : loginInput.accessToken, "DEVICE-TOKEN" : loginInput.deviceToken]
        AF.request("\(Constant.BASE_URL)/users/kakao-signin", method: .post, headers: headers).validate().responseDecodable(of: LoginResponse.self) { response in
            switch response.result {
            case .success(let response):
                let message = response.message
                if response.isSuccess {
                    // 로그인 성공
                    print(message)
                    print(response.result.jwt)
                    let keyChain = KeychainSwift()
                    keyChain.set(response.result.jwt, forKey: "jwtToken")
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
