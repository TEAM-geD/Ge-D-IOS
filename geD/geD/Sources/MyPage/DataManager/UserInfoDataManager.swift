//
//  UserInfoDataManager.swift
//  geD
//
//  Created by 김민순 on 2021/07/31.
//

import Alamofire
import KeychainSwift

class UserInfoDataManager {
    func getUserInfo(_ accessToken: String, _ userIdx: String, viewController: UserInfoViewController) {
        let headers: HTTPHeaders = ["X-ACCESS-TOKEN" : accessToken]
        AF.request("\(Constant.BASE_URL)/users/\(userIdx)/info", method: .get, headers: headers).validate().responseDecodable(of: UserInfoResponse.self) { response in
            switch response.result {
            case .success(let response):
                let message = response.message
                if response.isSuccess {
                    viewController.dismissIndicator()
                    viewController.updateUI(response.result!)
                } else {
                    viewController.dismissIndicator()
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
    
    func ModifyUserInfo(_ accessToken: String, _ userIdx: String, _ parameters: UserInfo, viewController: UserInfoViewController) {
        let headers: HTTPHeaders = ["X-ACCESS-TOKEN" : accessToken]
        AF.request("\(Constant.BASE_URL)/users/\(userIdx)/info", method: .patch, parameters: parameters, headers: headers).validate().responseDecodable(of: UserInfoResponse.self) { response in
            switch response.result {
            case .success(let response):
                let message = response.message
                if response.isSuccess {
                    viewController.dismissIndicator()
                    viewController.updateUI(response.result!)
                } else {
                    viewController.dismissIndicator()
                    switch response.code {
                    default:
                        viewController.presentAlert(title: message)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
                viewController.presentAlert(title: "서버와의 연결이 원할하지 않습니다.")
            }
        }
    }
}

