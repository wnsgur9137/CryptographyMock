//
//  CryptographyViewModel.swift
//  CryptographyMock
//
//  Created by JunHyeok Lee on 2023/04/21.
//

import Foundation
import Combine

final class CryptographyViewModel {
    
    @Published var encryptedText: String?
    @Published var decryptedText: String?
    
    init() {
        
    }
    
    func encryption(_ text: String, password: String) {
        encryptedText = AES256CBC.encryptString(text, password: password)
    }
    
    func decryption(_ text: String, password: String) {
        let decryptedText = AES256CBC.decryptString(text, password: password)
        self.decryptedText = decryptedText != "" ? decryptedText : "변환 실패"
    }
}
