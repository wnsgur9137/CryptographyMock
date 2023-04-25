//
//  CryptographyTestViewController.swift
//  CryptographyMock
//
//  Created by JunHyeok Lee on 2023/04/25.
//

import UIKit
import Combine

final class CryptographyTestViewController: UIViewController {
    
    // default key 32
    private let defaultKey: String = "asdf1111111111111111111111111111"

    // https://placeimg.com/62/32/any
    private let viewModel: CryptographyTestViewModel
    private var cancellables: Set<AnyCancellable> = []
    
    private let cryptographyView: CryptographyTestView = {
        let view = CryptographyTestView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.viewModel = CryptographyTestViewModel()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Custom"
        
        configurePasswordTextField()
        
        addActionEncryptedButton()
        addActionDecryptedButton()
        
        bindAll()
        
        addSubviews()
        setLayoutConstraints()
    }
    
    private func configurePasswordTextField() {
        cryptographyView.setPasswordText(text: self.defaultKey)
    }
}

// MARK: - Action
extension CryptographyTestViewController {
    private func addActionEncryptedButton() {
        cryptographyView.addActionEncryptButton(UIAction(handler: { [weak self] _ in
            guard let defaultKey = self?.defaultKey,
                  let encryptText = self?.cryptographyView.getEncryptText() else { return }
            self?.viewModel.encryption(encryptText, password: defaultKey)
            guard let imageURL = URL(string: encryptText) else { return }
            self?.cryptographyView.setEncryptImage(url: imageURL)
        }), event: .touchUpInside)
    }
    
    private func addActionDecryptedButton() {
        cryptographyView.addActionDecryptButton(UIAction(handler: { [weak self] _ in
            guard let defaultKey = self?.defaultKey,
                  let decryptText = self?.cryptographyView.getDecryptText() else { return }
            self?.viewModel.decryption(decryptText, password: defaultKey)
        }), event: .touchUpInside)
    }
}

// MARK: - Binding
extension CryptographyTestViewController {
    private func bindAll() {
        bindEncryptedText()
        bindDecryptedText()
        bindDecryptedData()
    }
    
    private func bindEncryptedText() {
        viewModel.$encryptedText
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] encryptedText in
                guard let encryptedText = encryptedText else { return }
                self?.cryptographyView.setEncryptedText(text: encryptedText)
            })
            .store(in: &cancellables)
    }
    
    private func bindDecryptedText() {
        viewModel.$decryptedText
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] decryptedText in
                guard let decryptedText = decryptedText else { return }
                self?.cryptographyView.setDecryptedText(text: decryptedText)
                guard let imageURL = URL(string: decryptedText) else { return }
                self?.cryptographyView.setDecryptedImage(url: imageURL)
            })
            .store(in: &cancellables)
    }
    
    private func bindDecryptedData() {
        viewModel.$decryptedData
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] encryptedData in
                print("✏️1")
                guard let encryptedData = encryptedData else { return }
                print("✏️2")
                print("encryptedData: \(encryptedData)")
                self?.cryptographyView.setDecryptedImage(data: encryptedData)
                print("✏️3")
            })
            .store(in: &cancellables)
    }
}

// MARK: - Layout
extension CryptographyTestViewController {
    private func addSubviews() {
        self.view.addSubview(cryptographyView)
    }
    
    private func setLayoutConstraints() {
        NSLayoutConstraint.activate([
            cryptographyView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            cryptographyView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            cryptographyView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            cryptographyView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
