//
//  UserInfoResponse.swift
//  geD
//
//  Created by 김민순 on 2021/07/31.
//

struct UserInfoResponse: Decodable {
    let isSuccess: Bool
    let code: Int
    let message: String
    
    let result: UserInfoResult?
}

struct UserInfoResult: Decodable {
    let userIdx: Int
    let userName: String
    let introduce: String?
    let profileImageUrl: String?
    let backgroundImageUrl: String?
    let userJob: String?
    let isMembers: String?
    let snsUrlList: [String]?
}
