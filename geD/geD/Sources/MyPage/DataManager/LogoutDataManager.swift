//
//  LoginDataManager.swift
//  geD
//
//  Created by 김민순 on 2021/07/30.
//

import Alamofire
import KeychainSwift

class LogoutDataManager {
    let jwtToken = KeychainSwift().get("jwtToken")!
    let userIdx = KeychainSwift().get("userIdx")!
    func logout(viewController: TermsViewController) {
        let headers: HTTPHeaders = ["X-ACCESS-TOKEN" : jwtToken]
        AF.request("\(Constant.BASE_URL)/users/\(userIdx)/status", method: .patch, headers: headers).validate().responseDecodable(of: LogoutResponse.self) { response in
            switch response.result {
            case .success(let response):
                let message = response.message
                if response.isSuccess {
                    // 로그아웃 성공
                    print(message)
                    KeychainSwift().delete("jwtToken")
                    KeychainSwift().delete("userIdx")
                    viewController.goToLogin()
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
