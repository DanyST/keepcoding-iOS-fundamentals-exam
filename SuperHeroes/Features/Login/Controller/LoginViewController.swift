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
    let networkModel: NetworkModel
    
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
    }
}

// MARK: - LoginViewDelegate
extension LoginViewController: LoginViewDelegate {
    func continueButtonDidTapped() {
        guard
            let userName = innerView.usernameTextField.text,
            let password = innerView.passwordTextField.text
        else {
            print("No data")
            return
        }
        
        networkModel.login(
            user: userName,
            password: password
        ) { [weak self] result in
            switch result {
            case .success(_):
                let viewController = HeroesListViewController()
                self?.navigationController?.setViewControllers([viewController], animated: true)
            case let .failure(error):
                print("Error: \(error)")
            }
        }
    }
}