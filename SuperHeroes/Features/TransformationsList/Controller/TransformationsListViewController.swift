//
//  TransformationsListViewController.swift
//  SuperHeroes
//
//  Created by Luis Herrera Lillo on 01-10-23.
//

import UIKit

final class TransformationsListViewController: UIViewController {
    // MARK: - Child Controllers
    private lazy var genericTableViewController = setupGenericTableViewController()
    
    // MARK: - Model
    private var transformations: [Transformation]?
    private let hero: Hero
    
    // MARK: - Initialization
    init(hero: Hero) {
        self.hero = hero
        super.init(nibName: nil, bundle: nil)
    }
    
    convenience init(hero: Hero, transformations: [Transformation]) {
        self.init(hero: hero)
        self.transformations = transformations
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK: - Setup setupUI
extension TransformationsListViewController {
    private func setupUI() {
        title = "Transformations"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
        self.add(genericTableViewController)
    }
}

// MARK: - Setup GenericTableViewController
extension TransformationsListViewController {
    private func setupGenericTableViewController() -> GenericTableViewController<Transformation, CharacterInfoTableViewCell> {
        let genericTableViewController = GenericTableViewController(
            items: [
                Transformation(
                    id: "",
                    photo: URL(string: "https://areajugones.sport.es/wp-content/uploads/2021/05/ozarru.jpg.webp")!,
                    description: "Cómo todos los Saiyans con cola, Goku es capaz de convertirse en un mono gigante si mira fijamente a la luna llena. Así es como Goku cuando era un infante liberaba todo su potencial a cambio de perder todo el raciocinio y transformarse en una auténtica bestia. Es por ello que sus amigos optan por cortarle la cola para que no ocurran desgracias, ya que Goku mató a su propio abuelo adoptivo Son Gohan estando en este estado. Después de beber el Agua Ultra Divina, Goku liberó todo su potencial sin necesidad de volver a convertirse en Oozaru",
                    name: "1. Oozaru – Gran Mono")
            ],
            configureCellAction: { [weak self] cell, transformation in
                self?.configureCell(cell: cell, transformation: transformation)
            },
            didSelectItemAction: { [weak self] transformation in
                self?.didSelectItem(transformation: transformation)
            }
        )
        return genericTableViewController
    }
    
    private func configureCell(cell: CharacterInfoTableViewCell, transformation: Transformation) {
        cell.configure(
            imageUrl: transformation.photo,
            name: transformation.name,
            description: transformation.description
        )
    }
    
    private func didSelectItem(transformation: Transformation) {
        let transformationDetailViewController = TransformationDetailViewController(transformation: transformation)
        navigationController?.show(transformationDetailViewController, sender: nil)
    }
}
