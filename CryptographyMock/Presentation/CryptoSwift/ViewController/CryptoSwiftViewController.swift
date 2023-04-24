//
//  CryptoSwiftViewController.swift
//  CryptographyMock
//
//  Created by JunHyeok Lee on 2023/04/24.
//

import UIKit
import Combine

final class CryptoSwiftViewController: UIViewController {
    // default key 32
    private let defaultKey: String = "qwerasdfzxcv1234qwerasdfzxcv1234"
    private let viewModel: CryptoSwiftViewModel
    private var cancellables: Set<AnyCancellable> = []
    
    private let cryptoSwiftView: CryptoSwiftView = {
        let view = CryptoSwiftView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.viewModel = CryptoSwiftViewModel()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "CryptoSwift"
        
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
extension CryptoSwiftViewController {
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
extension CryptoSwiftViewController {
    private func bindAll() {
        bindEncryptedText()
        bindDecryptedText()
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
                guard let imageURL = URL(string: decryptedText) else { return }
                self?.cryptoSwiftView.setDecryptedImage(url: imageURL)
            })
            .store(in: &cancellables)
    }
}

// MARK: - Layout
extension CryptoSwiftViewController {
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
