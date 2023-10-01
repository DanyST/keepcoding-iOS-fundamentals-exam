//
//  LoginView.swift
//  SuperHeroes
//
//  Created by Luis Herrera Lillo on 30-09-23.
//

import UIKit

final class LoginView: UIView {
    private lazy var backgroundImageView: UIImageView = setupBackgroundImageView()
    private lazy var containerStackView: UIStackView = setupVerticalStackView(spacing: 12)
    private lazy var textFieldsStackView: UIStackView = setupVerticalStackView(spacing: 0)
    lazy var usernameTextField: UITextField = setupUsernameTextField()
    lazy var passwordTextField: UITextField = setupPasswordTextField()
    lazy var continueButton: UIButton = setupContinueButton()
    
    weak var delegate: LoginViewDelegate?
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LoginView {
    private func setupView() {
        backgroundColor = .systemBackground
        setupConstraints()
    }
    
    private func setupVerticalStackView(spacing: CGFloat) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = spacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
    
    private func setupUsernameTextField() -> UITextField {
        let textfield = setupTextfield()
        textfield.placeholder = "Enter username"
        textfield.textContentType = .emailAddress
        textfield.keyboardType = .emailAddress
        return textfield
    }
    
    private func setupPasswordTextField() -> UITextField {
        let textfield = setupTextfield()
        textfield.placeholder = "Enter password"
        textfield.textContentType = .password
        textfield.isSecureTextEntry = true
        return textfield
    }
    
    private func setupTextfield() -> UITextField {
        let textfield = UITextField()
        textfield.font = UIFont.systemFont(ofSize: 16.0, weight: .regular)
        textfield.layer.masksToBounds = true
        textfield.backgroundColor = .systemGray5
        textfield.layer.borderWidth = 1
        textfield.layer.borderColor = UIColor.gray.cgColor
        textfield.autocapitalizationType = .none
        textfield.setLeftPaddingPoints(10)
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }
    
    private func setupContinueButton() -> UIButton {
        let button = UIButton(configuration: .filled())
        button.configuration?.baseBackgroundColor = .systemIndigo
        button.configuration?.attributedTitle = AttributedString(
            "Sign In",
            attributes: .init([
                .font: UIFont.systemFont(ofSize: 18.0, weight: .semibold),
            ])
        )
        button.addAction(UIAction(handler: { [weak self] _ in
            self?.delegate?.continueButtonDidTapped()
        }), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    private func setupBackgroundImageView() -> UIImageView {
        let image = UIImage(named: "background")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }
}

extension LoginView {
    private func setupConstraints() {
        setupBackgroundImageConstraints()
        setupContainerStackViewConstraints()
        setupStackViewTextFieldsConstraints()
        setupUsernameTextFieldConstraints()
        setupPasswordTextFieldConstraints()
        setupContinueButtonConstraints()
    }
    
    private func setupBackgroundImageConstraints() {
        addSubview(backgroundImageView)
        NSLayoutConstraint.activate([
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    private func setupContainerStackViewConstraints() {
        addSubview(containerStackView)
        NSLayoutConstraint.activate([
            containerStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12.0),
            containerStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12.0),
            containerStackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    private func setupStackViewTextFieldsConstraints() {
        containerStackView.addArrangedSubview(textFieldsStackView)
    }
    
    private func setupUsernameTextFieldConstraints() {
        textFieldsStackView.addArrangedSubview(usernameTextField)
        NSLayoutConstraint.activate([
            usernameTextField.heightAnchor.constraint(equalToConstant: 60.0)
        ])
    }
    
    private func setupPasswordTextFieldConstraints() {
        textFieldsStackView.addArrangedSubview(passwordTextField)
        NSLayoutConstraint.activate([
            passwordTextField.heightAnchor.constraint(equalTo: usernameTextField.heightAnchor)
        ])
    }
    
    private func setupContinueButtonConstraints() {
        containerStackView.addArrangedSubview(continueButton)
        NSLayoutConstraint.activate([
            continueButton.heightAnchor.constraint(equalToConstant: 60.0)
        ])
    }
}
