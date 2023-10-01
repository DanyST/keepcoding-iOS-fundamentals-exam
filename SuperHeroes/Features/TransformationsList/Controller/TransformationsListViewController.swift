//
//  TransformationsListViewController.swift
//  SuperHeroes
//
//  Created by Luis Herrera Lillo on 01-10-23.
//

import UIKit

final class TransformationsListViewController<NetworkModel: NetworkDataModelProtocol>: UIViewController {
    // MARK: - Child Controllers
    private lazy var genericTableViewController = setupGenericTableViewController()
    
    // MARK: - Model
    private var transformations: [Transformation]?
    private let hero: Hero
    private let networkModel: NetworkModel
    
    // MARK: - Initialization
    init(
        hero: Hero,
        networkModel: NetworkModel = NetworkDataModel()
    ) {
        self.hero = hero
        self.networkModel = networkModel
        super.init(nibName: nil, bundle: nil)
    }
    
    convenience init(
        hero: Hero,
        networkModel: NetworkModel = NetworkDataModel(),
        transformations: [Transformation]
    ) {
        self.init(hero: hero, networkModel: networkModel)
        self.transformations = transformations
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchTransformationsIfNil()
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

extension TransformationsListViewController {
    private func fetchTransformationsIfNil() {
        guard transformations == nil else {
            return
        }
        networkModel.getTransformations(for: hero) { [weak self] result in
            switch result {
            case let .success(transformations):
                self?.transformations = transformations
                self?.genericTableViewController.setItems(transformations)
            case let .failure(error):
                print("Error: \(error)")
            }
        }
    }
}

// MARK: - Setup GenericTableViewController
extension TransformationsListViewController {
    private func setupGenericTableViewController() -> GenericTableViewController<Transformation, CharacterInfoTableViewCell> {
        let genericTableViewController = GenericTableViewController(
            items: transformations ?? [],
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
