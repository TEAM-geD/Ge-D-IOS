//
//  LoginResponse.swift
//  geD
//
//  Created by 김민순 on 2021/06/14.
//

struct LoginResponse: Decodable {
    
    let isSuccess: Bool
    let code: Int
    let message: String
    
    let result: LoginResult?
}

struct LoginResult: Decodable {
    let userIdx: Int
    let jwt: String
}
