//
//  CryptographyTestViewModel.swift
//  CryptographyMock
//
//  Created by JunHyeok Lee on 2023/04/25.
//

import Foundation
import Combine

final class CryptographyTestViewModel {
    
    @Published var encryptedText: String?
    @Published var decryptedText: String?
    @Published var decryptedData: Data?
    
    init() {
        
    }
    
    func encryption(_ text: String, password: String) {
        encryptedText = AES256CBC.encryptString(text, password: password)
    }
    
    func decryption(_ text: String, password: String) {
        let decryptedText = AES256CBC.decryptString(text, password: password)
//        self.decryptedText = decryptedText != "" ? decryptedText : "변환 실패"
        
        guard let decryptedData = AES256CBC.decryptData(text, password: password) else { return }
        print("✏️0")
        self.decryptedData = decryptedData
    }
}
