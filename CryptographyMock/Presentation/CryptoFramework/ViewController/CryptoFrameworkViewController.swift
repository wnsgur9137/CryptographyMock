//
//  CryptoFrameworkViewController.swift
//  CryptographyMock
//
//  Created by JunHyeok Lee on 2023/04/24.
//

import UIKit
import Combine

final class CryptoFrameworkViewController: UIViewController {
    // default key 32
    private let defaultKey: String = "qwerasdfzxcv1234qwerasdfzxcv1234"
    // https://placeimg.com/62/32/any
    private let viewModel: CryptographyViewModel
    private var cancellables: Set<AnyCancellable> = []
    
    private let cryptoFrameworkView: CryptoFrameworkView = {
        let view = CryptoFrameworkView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.viewModel = CryptographyViewModel()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "CryptoFramework"
        
        configurePasswordTextField()
        
        addActionEncryptedButton()
        addActionDecryptedButton()
        
        bindAll()
        
        addSubviews()
        setLayoutConstraints()
    }
    
    private func configurePasswordTextField() {
        cryptoFrameworkView.setPasswordText(text: self.defaultKey)
    }
}

// MARK: - Action
extension CryptoFrameworkViewController {
    private func addActionEncryptedButton() {
        cryptoFrameworkView.addActionEncryptButton(UIAction(handler: { [weak self] _ in
            guard let defaultKey = self?.defaultKey,
                  let encryptText = self?.cryptoFrameworkView.getEncryptText() else { return }
            self?.viewModel.encryption(encryptText, password: defaultKey)
            guard let imageURL = URL(string: encryptText) else { return }
            self?.cryptoFrameworkView.setEncryptImage(url: imageURL)
        }), event: .touchUpInside)
    }
    
    private func addActionDecryptedButton() {
        cryptoFrameworkView.addActionDecryptButton(UIAction(handler: { [weak self] _ in
            guard let defaultKey = self?.defaultKey,
                  let decryptText = self?.cryptoFrameworkView.getDecryptText() else { return }
            self?.viewModel.decryption(decryptText, password: defaultKey)
        }), event: .touchUpInside)
    }
}

// MARK: - Binding
extension CryptoFrameworkViewController {
    private func bindAll() {
        bindEncryptedText()
        bindDecryptedText()
    }
    
    private func bindEncryptedText() {
        viewModel.$encryptedText
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] encryptedText in
                guard let encryptedText = encryptedText else { return }
                self?.cryptoFrameworkView.setEncryptedText(text: encryptedText)
            })
            .store(in: &cancellables)
    }
    
    private func bindDecryptedText() {
        viewModel.$decryptedText
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] decryptedText in
                guard let decryptedText = decryptedText else { return }
                self?.cryptoFrameworkView.setDecryptedText(text: decryptedText)
                guard let imageURL = URL(string: decryptedText) else { return }
                self?.cryptoFrameworkView.setDecryptedImage(url: imageURL)
            })
            .store(in: &cancellables)
    }
}

// MARK: - Layout
extension CryptoFrameworkViewController {
    private func addSubviews() {
        self.view.addSubview(cryptoFrameworkView)
    }
    
    private func setLayoutConstraints() {
        NSLayoutConstraint.activate([
            cryptoFrameworkView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            cryptoFrameworkView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            cryptoFrameworkView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            cryptoFrameworkView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
