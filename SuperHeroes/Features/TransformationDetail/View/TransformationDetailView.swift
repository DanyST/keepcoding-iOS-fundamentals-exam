//
//  TransformationDetailView.swift
//  SuperHeroes
//
//  Created by Luis Herrera Lillo on 01-10-23.
//

import UIKit

final class TransformationDetailView: UIView {
    // MARK: - Subviews
    lazy var characterInfoView = setupCharacterInfoDetailRepresentable()
    
    // MARK: - Model
    private let transformation: Transformation
    
    // MARK: - Initialization
    init(transformation: Transformation) {
        self.transformation = transformation
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup Subviews
extension TransformationDetailView {
    private func setupView() {
        backgroundColor = .systemBackground
        setupConstraints()
    }
    
    private func setupCharacterInfoDetailRepresentable() -> CharacterInfoView<Transformation> {
        let characterInfoView = CharacterInfoView(characterInfo: transformation)
        return characterInfoView
    }
}

// MARK: - Setup Constraints
extension TransformationDetailView {
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
