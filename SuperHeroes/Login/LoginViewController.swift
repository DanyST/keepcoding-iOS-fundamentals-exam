//
//  LoginViewController.swift
//  SuperHeroes
//
//  Created by Luis Herrera Lillo on 30-09-23.
//

import UIKit

final class LoginViewController: UIViewController {
    private lazy var innerView = LoginView()
    
    override func loadView() {
        view = innerView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        innerView.delegate = self
    }
}

extension LoginViewController: LoginViewDelegate {
    func continueButtonDidTapped() {
        print("continueButtonDidTapped")
    }
}
