//
//  CryptoSwiftViewModel.swift
//  CryptographyMock
//
//  Created by JunHyeok Lee on 2023/04/24.
//

import Foundation
import CryptoSwift
import Combine

final class CryptoSwiftViewModel {
    @Published var encryptedText: String?
    @Published var decryptedText: String?
    
    init() {
        
    }
    
    func encryption(_ text: String, password: String) {
        encryptedText = AES256Util.encrypt(string: text, password: password)
    }
    
    func decryption(_ text: String, password: String) {
        decryptedText = AES256Util.decrypt(encoded: text, password: password)
    }
}
