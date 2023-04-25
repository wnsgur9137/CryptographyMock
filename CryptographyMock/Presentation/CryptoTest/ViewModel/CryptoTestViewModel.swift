//
//  CryptoTestViewModel.swift
//  CryptographyMock
//
//  Created by JunHyeok Lee on 2023/04/25.
//

import Foundation
import CryptoSwift
import Combine

final class CryptoTestViewModel {
    @Published var encryptedText: String?
    @Published var decryptedText: String?
    private let aes256Test: AES256Test = AES256Test()
    
    init() {
        
    }
    
    func encryption(_ text: String, password: String) {
        encryptedText = AES256Util.encrypt(string: text, password: password)
    }
    
    func decryption(_ text: String, password: String) {
//        decryptedText = AES256Util.decrypt(encoded: text, password: password)
        
        let key = Data(base64Encoded: password)?.bytes
//        let iv: Array<UInt8> = Array("0123456789012345".utf8)
        let data = Data(base64Encoded: text)?.bytes
        do {
            let decryptedText = try AES(key: key!, blockMode: ECB(), padding: .pkcs5).decrypt(data!)
            self.decryptedText = String(bytes: decryptedText, encoding: .utf8)
        } catch(let error) {
            print("Decrypt Fail: \(error)")
        }
    }
}

//extension CryptoTestViewModel {
//    func decryption(_ text: String, password: String) {
//        let data = Data(base64Encoded: text, options: .ignoreUnknownCharacters)
//        if let key = Data(base64Encoded: password, options: .ignoreUnknownCharacters) {
//            if let iv = "0123456789012345".data(using: .utf8) {
//                decryptedText = aes256Test.decryptAES256(key: key, iv: iv, data: data)
//                print("🚨decryptedText: \(decryptedText)")
//            }
//        }
//    }
//}
