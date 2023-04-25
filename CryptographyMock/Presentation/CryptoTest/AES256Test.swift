//
//  AES256Test.swift
//  CryptographyMock
//
//  Created by JunHyeok Lee on 2023/04/25.
//

import CryptoSwift
import Foundation

final class AES256Test {
    func decryptAES256(key: Data, iv: Data, data: Data?) -> String {
        if let validData = data {
            let bytes = validData.bytes
            let keyDecodes: Array<UInt8> = Array(key)
            let ivDecodes: Array<UInt8> = Array(iv)
            
            do {
                print("00000000000000")
                let aesObject = try AES(key: keyDecodes, blockMode: CBC(iv: ivDecodes), padding: .pkcs5)
                print("aesObject: \(aesObject)")
                let decode = try aesObject.decrypt(bytes)
                print("decode: \(decode)")
                let base64Data = Data(bytes: decode, count: decode.count)
                print("base64Data: \(base64Data)")
                
                let decryptedData = String(decoding: base64Data, as: UTF8.self)
                
                return decryptedData
            } catch(let error) {
                return "123"
            }
        } else {
            return "456"
        }
    }
}
