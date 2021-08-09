//
//  MyPageResponse.swift
//  geD
//
//  Created by 김민순 on 2021/08/09.
//

struct MyPageResponse: Decodable {
    let isSuccess: Bool
    let code: Int
    let message: String
    
    let result: MyPageResult?
}

struct MyPageResult: Decodable {
    let userName: String
    let userJob: String?
    let userProfileImageUrl: String?
    let introduce: String?
    let userSnsUrlList: [String?]
    
    let myProjectInfoList: [MyProjectInfoList?]
    let myApplyProjectInfoList: [MyProjectInfoList?]
}

struct MyProjectInfoList: Decodable {
    let projectIdx: Int
    let projectThumbnailImageUrl: String
    let projectName: String
    let projectStatus: Int
    let projectJobNameList: [String]
    let userIdx: Int
    let userName: String
    let userJob: String
    let projectTeamInfoList: [ProjectTeamInfoList?]
}

struct ProjectTeamInfoList: Decodable {
    let userIdx: Int
    let userProfileImageUrl: String?
}
