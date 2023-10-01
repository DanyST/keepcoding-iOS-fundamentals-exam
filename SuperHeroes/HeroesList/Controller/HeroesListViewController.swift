//
//  HeroesListViewController.swift
//  SuperHeroes
//
//  Created by Luis Herrera Lillo on 30-09-23.
//

import UIKit

final class HeroesListViewController: UIViewController {
    // MARK: - Child Controllers
    private lazy var genericTableViewController = setupGenericTableViewController()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
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

// MARK: - Setup GenericTableViewController
extension HeroesListViewController {
    private func setupGenericTableViewController() -> GenericTableViewController<Hero, CharacterInfoTableViewCell> {
        let genericTableViewController = GenericTableViewController(
            items: [Hero(id: "", name: "Maestro Roshi", description: "Es un maestro de artes marciales que tiene una escuela, donde entrenará a Goku y Krilin para los Torneos de Artes Marciales. Aún en los primeros episodios había un toque de tradición y disciplina, muy bien representada por el maestro. Pero Muten Roshi es un anciano extremadamente pervertido con las chicas jóvenes, una actitud que se utilizaba en escenas divertidas en los años 80. En su faceta de experto en artes marciales, fue quien le enseñó a Goku técnicas como el Kame Hame Ha", photo: URL(string: "https://cdn.alfabetajuega.com/alfabetajuega/2020/06/Roshi.jpg?width=300")!, favorite: false)],
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
        cell.configure(imageUrl: hero.photo, name: hero.name, description: hero.description)
    }
    
    private func didSelectItem(hero: Hero) {
        print("Hero \(hero.name) did selected")
    }
}
