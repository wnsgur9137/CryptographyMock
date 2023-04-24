//
//  CryptoFrameworkViewModel.swift
//  CryptographyMock
//
//  Created by JunHyeok Lee on 2023/04/24.
//

import Foundation
import Combine
import CryptoAES256

final class CryptoFrameworkViewModel {
    @Published var encryptedText: String?
    @Published var decryptedText: String?
    private let cryptoAES: CryptoAES256
    
    init(key: String?, iv: String?) {
        self.cryptoAES = CryptoAES256(key: key, iv: iv)
    }
    
    func encryption(_ text: String, password: String) {
        self.encryptedText = cryptoAES.encryption(text, password: password)
    }
    
    func decryption(_ text: String, password: String) {
        self.decryptedText = cryptoAES.decryption(text, password: password)
    }
}
