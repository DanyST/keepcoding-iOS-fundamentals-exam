//
//  HeroesListViewController.swift
//  SuperHeroes
//
//  Created by Luis Herrera Lillo on 30-09-23.
//

import UIKit

final class HeroesListViewController<NetworkModel: NetworkDataModelProtocol>: UIViewController {
    // MARK: - Child Controllers
    private lazy var genericTableViewController = setupGenericTableViewController()
    
    // MARK: - Model
    private let networkModel: NetworkModel
    
    init(networkModel: NetworkModel = NetworkDataModel()) {
        self.networkModel = networkModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchHeroesList()
    }
}

// MARK: - Setup setupUI
extension HeroesListViewController {
    private func setupUI() {
        title = "Heroes"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
        self.add(genericTableViewController)
    }
}

// MARK: Fetch Heroes List
extension HeroesListViewController {
    private func fetchHeroesList() {
        networkModel.getHeroes { [weak self] result in
            switch result {
            case let .success(heroesList):
                self?.genericTableViewController.setItems(heroesList)
            case let .failure(error):
                print("Error: \(error)")
            }
        }
    }
}

// MARK: - Setup GenericTableViewController
extension HeroesListViewController {
    private func setupGenericTableViewController() -> GenericTableViewController<Hero, CharacterInfoTableViewCell> {
        let genericTableViewController = GenericTableViewController(
            items: [],
            configureCellAction: { [weak self] cell, hero in
                self?.configureCell(cell: cell, hero: hero)
            },
            didSelectItemAction: { [weak self] hero in
                self?.didSelectItem(hero: hero)
            }
        )
        return genericTableViewController
    }
    
    private func configureCell(cell: CharacterInfoTableViewCell, hero: Hero) {
        cell.configure(
            imageUrl: hero.photo,
            name: hero.name,
            description: hero.description
        )
    }
    
    private func didSelectItem(hero: Hero) {
        let heroDetailViewController = HeroDetailViewController(hero: hero)
        navigationController?.show(heroDetailViewController, sender: nil)
    }
}
