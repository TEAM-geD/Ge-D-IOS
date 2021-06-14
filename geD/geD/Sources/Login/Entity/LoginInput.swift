//
//  LoginInput.swift
//  geD
//
//  Created by 김민순 on 2021/06/14.
//
import FirebaseMessaging

struct LoginInput: Encodable {
    var accessToken: String
    let deviceToken: String = Messaging.messaging().fcmToken!
}
