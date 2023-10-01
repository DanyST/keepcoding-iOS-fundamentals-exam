//
//  HeroDetailViewController.swift
//  SuperHeroes
//
//  Created by Luis Herrera Lillo on 30-09-23.
//

import UIKit

final class HeroDetailViewController<NetworkModel: NetworkDataModelProtocol>: UIViewController {
    // MARK: - Subviews
    private lazy var innerView = HeroDetailView(hero: hero)        

    // MARK: - Model
    private let hero: Hero
    private let networkModel: NetworkModel
    private var transformations: [Transformation]?
    
    // MARK: - Initialization
    init(hero: Hero, networkModel: NetworkModel = NetworkDataModel()) {
        self.hero = hero
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
        title = hero.name
              
        navigationItem.rightBarButtonItem = innerView.getLoaderIndicatorBarButtonItem()
        fetchTransformations()
    }
    
    @objc
    private func transformationsButtonDidTapped() {
        let transformationsListViewController = TransformationsListViewController(
            hero: hero,
            transformations: transformations ?? []
        )
        let navigation = UINavigationController(rootViewController: transformationsListViewController)
        present(navigation, animated: true)
    }
}

// MARK: - Methods
extension HeroDetailViewController {
    private func fetchTransformations() {
        networkModel.getTransformations(for: hero) { [weak self] result in
            switch result {
            case let .success(transformations):
                self?.transformations = transformations
                self?.configureButtonTransformations(transformations: transformations)
            case let .failure(error):
                print("Error: \(error)")
            }
        }
    }
    
    private func configureButtonTransformations(transformations: [Transformation]) {
        guard !transformations.isEmpty else {
            navigationItem.rightBarButtonItem = nil
            return
        }
        navigationItem.rightBarButtonItem = innerView.getTransformationsBarButtonItem(target: self, action: #selector(transformationsButtonDidTapped))
    }
}
