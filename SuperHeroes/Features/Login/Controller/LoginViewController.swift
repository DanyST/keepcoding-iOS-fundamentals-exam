//
//  LoginViewController.swift
//  SuperHeroes
//
//  Created by Luis Herrera Lillo on 30-09-23.
//

import UIKit

final class LoginViewController<NetworkModel: NetworkDataModelProtocol>: UIViewController {
    // MARK: - Subviews
    private lazy var innerView = LoginView()
    
    // MARK: - Properties
    private let networkModel: NetworkModel
    
    init(networkModel: NetworkModel = NetworkDataModel()) {
        self.networkModel = networkModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    override func loadView() {
        view = innerView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        innerView.delegate = self
        innerView.usernameTextField.becomeFirstResponder()
    }
}

// MARK: - Navigation
extension LoginViewController {
    private func navigateToHome() {
        let viewController = HeroesListViewController()
        navigationController?.setViewControllers([viewController], animated: true)
    }
}

// MARK: - LoginViewDelegate
extension LoginViewController: LoginViewDelegate {
    func continueButtonDidTapped() {
        guard
            let userName = innerView.usernameTextField.text,
            !userName.isEmpty,
            let password = innerView.passwordTextField.text,
            !password.isEmpty
        else {
            showAlert(title: "Login Error", message: "Please enter your username and/or password.")
            return
        }
        
        innerView.enableLoadingButton()
        innerView.disableInteractiveViews()
        
        networkModel.login(
            user: userName,
            password: password
        ) { [weak self] result in
            self?.innerView.disableLoadingButton()
            self?.innerView.enableInteractiveViews()
            
            switch result {
            case .success(_):
                self?.navigateToHome()
            case let .failure(error):
                self?.showAlert(
                    title: "Login Error",
                    message: "Invalid username and/or password. Please check your credentials and try again"
                )
                print("Error: \(error)")
            }
        }
    }
}
