//
//  AES256Test.swift
//  CryptographyMock
//
//  Created by JunHyeok Lee on 2023/04/25.
//

import Foundation
import CryptoSwift
 
//라이브러리 : https://github.com/krzyzanowskim/CryptoSwift
//pod 'CryptoSwift', '~> 1.3.8'
class AES256Test {
    //키값 32바이트: AES256(24bytes: AES192, 16bytes: AES128)
//    private static let SECRET_KEY = "01234567890123450123456789012345"
    private static let IV = "123456789abcdefg"
 
    static func encrypt(string: String, password: String) -> String {
        guard !string.isEmpty else { return "" }
        return try! getAESObject(password: password).encrypt(string.bytes).toBase64() ?? ""
    }
 
    static func decrypt(encoded: String, password: String) -> String {
        let datas = Data(base64Encoded: encoded)
        guard datas != nil else {
            return ""
        }
        let bytes = datas!.bytes
        let decode = try! getAESObject(password: password).decrypt(bytes)
        return String(bytes: decode, encoding: .utf8) ?? ""
    }
    
    static func decryptImageData(encoded: String, password: String) -> Data? {
        let datas = Data(base64Encoded: encoded)
        guard datas != nil else { return nil }
        let bytes = datas!.bytes
        let decode = try! getAESObject(password: password).decrypt(bytes)
        return Data(decode)
    }
 
    private static func getAESObject(password: String) -> AES{
        let keyDecodes : Array<UInt8> = Array(password.utf8)
        let ivDecodes : Array<UInt8> = Array(IV.utf8)
        let aesObject = try! AES(key: keyDecodes, blockMode: CBC(iv: ivDecodes), padding: .pkcs5)
 
        return aesObject
    }
}
