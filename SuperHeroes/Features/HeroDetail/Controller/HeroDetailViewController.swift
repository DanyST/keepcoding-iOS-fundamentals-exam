//
//  HeroDetailViewController.swift
//  SuperHeroes
//
//  Created by Luis Herrera Lillo on 30-09-23.
//

import UIKit

final class HeroDetailViewController: UIViewController {
    // MARK: - Subviews
    private lazy var innerView = HeroDetailView(hero: hero)

    // MARK: - Model
    private let hero: Hero
    
    // MARK: - Initialization
    init(hero: Hero) {
        self.hero = hero
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
        title = hero.name
                
        navigationItem.rightBarButtonItem = innerView.getLoaderIndicatorBarButtonItem()
        navigationItem.rightBarButtonItem = innerView.getTransformationsBarButtonItem(target: self, action: #selector(transformationsButtonDidTapped))
    }
}

// MARK: - Methods
extension HeroDetailViewController {
    @objc
    private func transformationsButtonDidTapped() {
        let transformationsListViewController = TransformationsListViewController(hero: hero)
        let navigation = UINavigationController(rootViewController: transformationsListViewController)
        present(navigation, animated: true)
        print("transformationsButtonDidTapped")
    }
}
