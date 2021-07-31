import Alamofire
import KeychainSwift

class ReferenceDataManager {
    func referenceInquire(type: Int, vc: ReferenceViewController){
        let myKey = KeychainSwift().get("jwtToken")
        let headers: HTTPHeaders = ["X-ACCESS-TOKEN" : myKey ?? ""]
        AF.request("\(Constant.BASE_URL)/references?type=\(type)", method: .get, headers: headers).validate().responseDecodable(of: ReferenceResponse.self) { response in
            switch response.result {
            case .success(let response):
                if response.isSuccess {
                    vc.didSuccessReq(result: response.result)
                    print("연결 성공")
                } else {
                    switch response.code {
                    case 2000:
                        print(response.message)
                    case 2001:
                        print(response.message)
                    case 2023:
                        print(response.message)
                    default:
                        print(response.message)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
                print("연결 실패")
            }
        }
    }
    
    func referenceDetailInquire(idx: Int, vc: ReferenceDetailViewController){
        let myKey = KeychainSwift().get("jwtToken")
        let headers: HTTPHeaders = ["X-ACCESS-TOKEN" : myKey ?? ""]
        AF.request("\(Constant.BASE_URL)/references/\(idx)", method: .get, headers: headers).validate().responseDecodable(of: ReferenceDetailResponse.self) { response in
            switch response.result {
            case .success(let response):
                if response.isSuccess {
                    print("디테일 연결 성공")
                    vc.didSuccessReq(result: response.result)
                } else {
                    switch response.code {
                    case 2000:
                        print(response.message)
                    case 2001:
                        print(response.message)
                    case 2023:
                        print(response.message)
                    default:
                        print(response.message)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
                print("연결 실패")
            }
        }
    }
    func referenceHeartInquire(vc: ReferenceHeartViewController){
        let myKey = KeychainSwift().get("jwtToken")
        let headers: HTTPHeaders = ["X-ACCESS-TOKEN" : myKey ?? ""]
        AF.request("\(Constant.BASE_URL)/references/heart", method: .get, headers: headers).validate().responseDecodable(of: ReferenceHeartResponse.self) { response in
            switch response.result {
            case .success(let response):
                if response.isSuccess {
                    print("레퍼런스 찜 조회 연결 성공")
                } else {
                    switch response.code {
                    case 2000:
                        print(response.message)
                    case 2001:
                        print(response.message)
                    case 2023:
                        print(response.message)
                    default:
                        print(response.message)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
                print("연결 실패")
            }
        }
    }
    func ReferenceHeartPost(_ paramaters: ReferenceHeartInput, vc: ReferenceDetailViewController) {
        let myKey = KeychainSwift().get("jwtToken")
        let headers: HTTPHeaders = ["X-ACCESS-TOKEN" : myKey ?? ""]
        AF.request("\(Constant.BASE_URL)/references/heart", method: .post, parameters: paramaters ,encoder: JSONParameterEncoder.default ,headers: headers).validate().responseDecodable(of: HeartPostResponse.self) { response in
            switch response.result {
            case .success(let response):
                if response.isSuccess {
                    print("찜하기 성공")
                } else {
                    switch response.code {
                    case 2000:
                        print(response.message)
                    case 2001:
                        print(response.message)
                    case 2023:
                        print(response.message)
                    default:
                        print(response.message)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
                print("연결 실패")
            }
        }
    }
}
