//
//  MyPageDataManager.swift
//  geD
//
//  Created by 김민순 on 2021/08/09.
//

import Alamofire
import KeychainSwift

class MyPageDataManager {
    func getUserInfo(_ accessToken: String, _ userIdx: String, _ projectStatus: Int, viewController: MyPageViewController) {
        let headers: HTTPHeaders = ["X-ACCESS-TOKEN" : accessToken]
        AF.request("\(Constant.BASE_URL)/users/\(userIdx)?projectStatus=\(projectStatus)", method: .get, headers: headers).validate().responseDecodable(of: MyPageResponse.self) { response in
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
    
}
