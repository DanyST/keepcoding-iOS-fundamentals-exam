//
//  LoginViewController.swift
//  SuperHeroes
//
//  Created by Luis Herrera Lillo on 30-09-23.
//

import UIKit

final class LoginViewController: UIViewController {
    // MARK: - Subviews
    private lazy var innerView = LoginView()
    
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
        print("continueButtonDidTapped")
        let viewController = HeroesListViewController()
        navigationController?.setViewControllers([viewController], animated: true)
    }
}
