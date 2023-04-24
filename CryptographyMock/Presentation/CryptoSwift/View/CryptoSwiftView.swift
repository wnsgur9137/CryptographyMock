//
//  CryptoSwiftView.swift
//  CryptographyMock
//
//  Created by JunHyeok Lee on 2023/04/24.
//

import UIKit

final class CryptoSwiftView: UIView {
    private let encryptTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = Constants.Color.systemGray6
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = Constants.Color.systemGray.cgColor
        textField.font = .systemFont(ofSize: 20.0, weight: .regular)
        return textField
    }()
    
    private let encryptButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Encrypto", for: .normal)
        button.setTitleColor(Constants.Color.systemBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20.0, weight: .regular)
        return button
    }()
    
    private let encryptedTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = .systemFont(ofSize: 20.0, weight: .regular)
        textField.textColor = Constants.Color.label
        return textField
    }()
    
    private let encryptStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8.0
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
    }()
    
    private let decryptTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = Constants.Color.systemGray6
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = Constants.Color.systemGray.cgColor
        textField.font = .systemFont(ofSize: 20.0, weight: .regular)
        return textField
    }()
    
    private let decryptButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Decrypto", for: .normal)
        button.setTitleColor(Constants.Color.systemBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20.0, weight: .regular)
        return button
    }()
    
    private let decryptedTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = .systemFont(ofSize: 20.0, weight: .regular)
        textField.textColor = Constants.Color.label
        return textField
    }()
    
    private let decryptStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8.0
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        setLayoutConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CryptoSwiftView {
    func addActionEncryptButton(_ action: UIAction, event: UIControl.Event) {
        encryptButton.addAction(action, for: event)
    }
    func addActionDecryptButton(_ action: UIAction, event: UIControl.Event) {
        decryptButton.addAction(action, for: event)
    }
    
    func getEncryptText() -> String {
        return encryptTextField.text ?? ""
    }
    func getDecryptText() -> String {
        return decryptTextField.text ?? ""
    }
    
    func setEncryptedText(text: String) {
        encryptedTextField.text = text
    }
    func setDecryptedText(text: String) {
        decryptedTextField.text = text
    }
}

// MARK: - Layout
extension CryptoSwiftView {
    private func addSubviews() {
        self.addSubview(encryptStackView)
        self.addSubview(decryptStackView)
        
        encryptStackView.addArrangedSubview(encryptTextField)
        encryptStackView.addArrangedSubview(encryptButton)
        encryptStackView.addArrangedSubview(encryptedTextField)
        
        decryptStackView.addArrangedSubview(decryptTextField)
        decryptStackView.addArrangedSubview(decryptButton)
        decryptStackView.addArrangedSubview(decryptedTextField)
    }
    
    private func setLayoutConstraints() {
        NSLayoutConstraint.activate([
            encryptTextField.heightAnchor.constraint(equalToConstant: 30.0),
            encryptButton.heightAnchor.constraint(equalToConstant: 30.0),
            encryptedTextField.heightAnchor.constraint(equalToConstant: 30.0),
            
            encryptStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 50.0),
            encryptStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            encryptStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            encryptStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
        
        NSLayoutConstraint.activate([
            decryptTextField.heightAnchor.constraint(equalToConstant: 30.0),
            decryptButton.heightAnchor.constraint(equalToConstant: 30.0),
            decryptedTextField.heightAnchor.constraint(equalToConstant: 30.0),
            
            decryptStackView.topAnchor.constraint(equalTo: encryptStackView.bottomAnchor, constant: 30.0),
            decryptStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            decryptStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            decryptStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
    }
}

