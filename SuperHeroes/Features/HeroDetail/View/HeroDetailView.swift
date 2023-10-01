//
//  HeroDetailView.swift
//  SuperHeroes
//
//  Created by Luis Herrera Lillo on 30-09-23.
//

import UIKit

final class HeroDetailView: UIView {
    // MARK: - Subviews
    lazy var characterInfoView = setupCharacterInfoDetailRepresentable()
    
    // MARK: - Model
    private let hero: Hero
    
    // MARK: - Initialization
    init(hero: Hero) {
        self.hero = hero
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Methods
extension HeroDetailView {
    func getLoaderIndicatorBarButtonItem() -> UIBarButtonItem {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.startAnimating()
        let activityBarButtonItem = UIBarButtonItem(customView: activityIndicator)
        return activityBarButtonItem
    }
    
    func getTransformationsBarButtonItem(target: Any, action: Selector?) -> UIBarButtonItem {
        let transformationsBarButtonItem = UIBarButtonItem(
            title: "Transformations",
            style: .plain,
            target: target,
            action: action
        )
        return transformationsBarButtonItem
    }
}

// MARK: - Setup Subviews
extension HeroDetailView {
    private func setupView() {
        backgroundColor = .systemBackground
        setupConstraints()
    }
    
    private func setupLabel(font: UIFont) -> UILabel {
        let label = UILabel()
        label.font = font
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    private func setupCharacterInfoDetailRepresentable() -> CharacterInfoView<Hero> {
        let characterInfoView = CharacterInfoView(characterInfo: hero)
        return characterInfoView
    }
}

// MARK: - Setup Constraints
extension HeroDetailView {
    private func setupConstraints() {
        setupCharacterInfoDetailRepresentableConstraints()
    }
    
    private func setupCharacterInfoDetailRepresentableConstraints() {
        addSubview(characterInfoView)
        NSLayoutConstraint.activate([
            characterInfoView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            characterInfoView.trailingAnchor.constraint(equalTo: trailingAnchor),
            characterInfoView.leadingAnchor.constraint(equalTo: leadingAnchor),
            characterInfoView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
