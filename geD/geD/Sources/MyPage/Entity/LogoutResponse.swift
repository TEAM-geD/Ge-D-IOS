//
//  LogoutResponse.swift
//  geD
//
//  Created by 김민순 on 2021/07/31.
//

struct LogoutResponse: Decodable {
    
    let isSuccess: Bool
    let code: Int
    let message: String
    
}
