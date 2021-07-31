import Alamofire
import KeychainSwift

class ProjectDataManager {
    func projectInquire(type: String, vc: HomeViewController){
        let myKey = KeychainSwift().get("jwtToken")
        let headers: HTTPHeaders = ["X-ACCESS-TOKEN" : myKey ?? ""]
        AF.request("\(Constant.BASE_URL)/projects?type=\(type)", method: .get, headers: headers).validate().responseDecodable(of: ProjectResponse.self) { response in
            switch response.result {
            case .success(let response):
                if response.isSuccess {
                    print("연결 성공")
                    vc.didSuccessReq(result: response.result ?? [])
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
    func heartListInquire(vc: HeartViewController) {
        let myKey = KeychainSwift().get("jwtToken")
        let headers: HTTPHeaders = ["X-ACCESS-TOKEN" : myKey ?? ""]
        AF.request("\(Constant.BASE_URL)/projects/heart", method: .get, headers: headers).validate().responseDecodable(of: ProjectResponse.self) { response in
            switch response.result {
            case .success(let response):
                if response.isSuccess {
                    print("연결 성공")
                    vc.didSuccessReq(result: response.result ?? [])
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
    func DetailInquire(vc: HomeDetailViewController, idx: Int) {
        let myKey = KeychainSwift().get("jwtToken")
        let headers: HTTPHeaders = ["X-ACCESS-TOKEN" : myKey ?? ""]
        AF.request("\(Constant.BASE_URL)/projects/\(idx)", method: .get, headers: headers).validate().responseDecodable(of: DetailResponse.self) { response in
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
    func ProjectHeartPost(_ paramaters: HeartInput, vc: HomeDetailViewController) {
        let myKey = KeychainSwift().get("jwtToken")
        let headers: HTTPHeaders = ["X-ACCESS-TOKEN" : myKey ?? ""]
        AF.request("\(Constant.BASE_URL)/projects/heart", method: .post, parameters: paramaters ,encoder: JSONParameterEncoder.default ,headers: headers).validate().responseDecodable(of: HeartPostResponse.self) { response in
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
    func ProjectJoin(_ paramaters: JoinInput, vc: HomeDetailViewController) {
        let myKey = KeychainSwift().get("jwtToken")
        let headers: HTTPHeaders = ["X-ACCESS-TOKEN" : myKey ?? ""]
        AF.request("\(Constant.BASE_URL)/projects/join", method: .post, parameters: paramaters ,encoder: JSONParameterEncoder.default ,headers: headers).validate().responseDecodable(of: JoinResponse.self) { response in
            switch response.result {
            case .success(let response):
                if response.isSuccess {
                    print("참여 성공")
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
