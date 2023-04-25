//
//  CryptoTestViewController.swift
//  CryptographyMock
//
//  Created by JunHyeok Lee on 2023/04/25.
//

import UIKit
import Combine

final class CryptoTestViewController: UIViewController {
    // default key 32
//    private let defaultKey: String = "qwerasdfzxcv1234qwerasdfzxcv1234"
    private let defaultKey: String = "asdf1111111111111111111111111111"
    private let viewModel: CryptoTestViewModel
    private var cancellables: Set<AnyCancellable> = []
    
    private let cryptoSwiftView: CryptoTestView = {
        let view = CryptoTestView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.viewModel = CryptoTestViewModel()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "CryptoTest"
        
        configurePasswordTextField()
        
        addActionEncryptedButton()
        addActionDecryptedButton()
        
        bindAll()
        
        addSubviews()
        setLayoutConstraints()
    }
    
    private func configurePasswordTextField() {
        self.cryptoSwiftView.setPasswordText(text: self.defaultKey)
    }
}

// MARK: - Action
extension CryptoTestViewController {
    private func addActionEncryptedButton() {
        cryptoSwiftView.addActionEncryptButton(UIAction(handler: { [weak self] _ in
            guard let defaultKey = self?.defaultKey,
                  let encryptText = self?.cryptoSwiftView.getEncryptText() else { return }
            self?.viewModel.encryption(encryptText, password: defaultKey)
            guard let imageURL = URL(string: encryptText) else { return }
            self?.cryptoSwiftView.setEncryptImage(url: imageURL)
        }), event: .touchUpInside)
    }
    
    private func addActionDecryptedButton() {
        cryptoSwiftView.addActionDecryptButton(UIAction(handler: { [weak self] _ in
            guard let defaultKey = self?.defaultKey,
                  let decryptText = self?.cryptoSwiftView.getDecryptText() else { return }
            self?.viewModel.decryption(decryptText, password: defaultKey)
        }), event: .touchUpInside)
    }
}

// MARK: - Binding
extension CryptoTestViewController {
    private func bindAll() {
        bindEncryptedText()
        bindDecryptedText()
        bindDecryptedImageData()
    }
    
    private func bindEncryptedText() {
        self.viewModel.$encryptedText
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] encryptedText in
                guard let encryptedText = encryptedText else { return }
                self?.cryptoSwiftView.setEncryptedText(text: encryptedText)
            })
            .store(in: &cancellables)
    }
    
    private func bindDecryptedText() {
        self.viewModel.$decryptedText
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] decryptedText in
                guard let decryptedText = decryptedText else { return }
                self?.cryptoSwiftView.setDecryptedText(text: decryptedText)
                
                if let imageData = Data(base64Encoded: decryptedText, options: .ignoreUnknownCharacters) {
                    let decodedImage = UIImage(data: imageData)
                }
            })
            .store(in: &cancellables)
    }
    
    private func bindDecryptedImageData() {
        self.viewModel.$decryptedImageData
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] decryptedImageData in
                print("🔔1")
                guard let imageData = decryptedImageData else { return }
                print("🔔2")
                print("🚨imageData: \(imageData)")
                self?.cryptoSwiftView.decryptedImageView.image = UIImage(data: imageData)
            })
            .store(in: &cancellables)
    }
}

// MARK: - Layout
extension CryptoTestViewController {
    private func addSubviews() {
        self.view.addSubview(cryptoSwiftView)
    }
    
    private func setLayoutConstraints() {
        NSLayoutConstraint.activate([
            cryptoSwiftView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            cryptoSwiftView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            cryptoSwiftView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            cryptoSwiftView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
