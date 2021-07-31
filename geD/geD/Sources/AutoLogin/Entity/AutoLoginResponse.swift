//
//  AutoLoginResponse.swift
//  geD
//
//  Created by 김민순 on 2021/06/17.
//

struct AutoLoginResponse: Decodable {
    let isSuccess : Bool
    let code : Int
    let message : String
}
