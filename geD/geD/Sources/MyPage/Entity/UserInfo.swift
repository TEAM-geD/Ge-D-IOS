//
//  UserInfo.swift
//  geD
//
//  Created by 김민순 on 2021/08/09.
//

struct UserInfo: Encodable {
    let userName: String
    let introduce: String
    let profileImageUrl: String?
    let backgroundImageUrl: String?
    let userJob: String
    let isMembers: String
    let snsUrlList: [String]
}
