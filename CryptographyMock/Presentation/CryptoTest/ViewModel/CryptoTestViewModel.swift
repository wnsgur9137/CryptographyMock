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
    @Published var decryptedImageData: Data?
    
    init() {
        
    }
    
    func encryption(_ text: String, password: String) {
        encryptedText = AES256Test.encrypt(string: text, password: password)
    }
    
    func decryption(_ text: String, password: String) {
        decryptedText = AES256Test.decrypt(encoded: text, password: password)
        
        decryptedImageData = AES256Test.decryptImageData(encoded: text, password: password)
    }
}
