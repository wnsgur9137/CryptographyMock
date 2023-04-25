//
//  CryptographyTestView.swift
//  CryptographyMock
//
//  Created by JunHyeok Lee on 2023/04/25.
//

import UIKit

final class CryptographyTestView: UIView {
    
    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "Password"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Constants.Color.label
        label.font = .systemFont(ofSize: 20.0, weight: .bold)
        return label
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = Constants.Color.systemGray6
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = Constants.Color.systemGray.cgColor
        textField.font = .systemFont(ofSize: 20.0, weight: .regular)
        textField.isUserInteractionEnabled = false
        textField.placeholder = "Password"
        return textField
    }()
    
    private let passwordStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8.0
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
    }()
    
    private let encryptTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = Constants.Color.systemGray6
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = Constants.Color.systemGray.cgColor
        textField.font = .systemFont(ofSize: 20.0, weight: .regular)
        textField.placeholder = "encryptText"
        return textField
    }()
    
    private let encryptImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
        stackView.translatesAutoresizingMaskIntoConstraints = false
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
        textField.placeholder = "DecryptText"
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
    
    private let decryptedImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let decryptStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
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

extension CryptographyTestView {
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
    
    func setEncryptImage(url: URL) {
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                self.encryptImageView.image = UIImage(data: data)
            }
        }
    }
    func setDecryptedImage(url: URL) {
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                self.decryptedImageView.image = UIImage(data: data)
            }
        }
    }
    func setDecryptedImage(data: Data) {
        DispatchQueue.main.async {
            self.decryptedImageView.image = UIImage(data: data)
        }
    }
    
    func setPasswordText(text: String) {
        passwordTextField.text = text
    }
    func setEncryptedText(text: String) {
        encryptedTextField.text = text
    }
    func setDecryptedText(text: String) {
        decryptedTextField.text = text
    }
}

// MARK: - Layout
extension CryptographyTestView {
    private func addSubviews() {
        self.addSubview(passwordStackView)
        self.addSubview(encryptStackView)
        self.addSubview(decryptStackView)
        
        passwordStackView.addArrangedSubview(passwordLabel)
        passwordStackView.addArrangedSubview(passwordTextField)
        
        encryptStackView.addArrangedSubview(encryptTextField)
        encryptStackView.addArrangedSubview(encryptButton)
        encryptStackView.addArrangedSubview(encryptedTextField)
        encryptStackView.addArrangedSubview(encryptImageView)
        
        decryptStackView.addArrangedSubview(decryptTextField)
        decryptStackView.addArrangedSubview(decryptButton)
        decryptStackView.addArrangedSubview(decryptedTextField)
        decryptStackView.addArrangedSubview(decryptedImageView)
    }
    
    private func setLayoutConstraints() {
        NSLayoutConstraint.activate([
            passwordLabel.widthAnchor.constraint(equalToConstant: 400.0),
            passwordLabel.heightAnchor.constraint(equalToConstant: 30.0),
            
            passwordTextField.widthAnchor.constraint(equalToConstant: 400.0),
            passwordTextField.heightAnchor.constraint(equalToConstant: 30.0),
            
            passwordStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 50.0),
            passwordStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
        
        NSLayoutConstraint.activate([
            encryptTextField.widthAnchor.constraint(equalToConstant: 400.0),
            encryptTextField.heightAnchor.constraint(equalToConstant: 30.0),
            encryptButton.heightAnchor.constraint(equalToConstant: 30.0),
            encryptedTextField.widthAnchor.constraint(equalToConstant: 400.0),
            encryptedTextField.heightAnchor.constraint(equalToConstant: 30.0),
            
            encryptStackView.topAnchor.constraint(equalTo: passwordStackView.bottomAnchor, constant: 80.0),
            encryptStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            encryptStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            encryptStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
        
        NSLayoutConstraint.activate([
            decryptTextField.widthAnchor.constraint(equalToConstant: 400.0),
            decryptTextField.heightAnchor.constraint(equalToConstant: 30.0),
            decryptButton.heightAnchor.constraint(equalToConstant: 30.0),
            decryptedTextField.widthAnchor.constraint(equalToConstant: 400.0),
            decryptedTextField.heightAnchor.constraint(equalToConstant: 30.0),
            
            decryptStackView.topAnchor.constraint(equalTo: encryptStackView.bottomAnchor, constant: 30.0),
            decryptStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            decryptStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            decryptStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
    }
}
