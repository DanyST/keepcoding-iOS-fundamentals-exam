//
//  CharacterInfoView.swift
//  SuperHeroes
//
//  Created by Luis Herrera Lillo on 01-10-23.
//

import UIKit

final class CharacterInfoView<T: CharacterInfoDetailRepresentable>: UIView {
    // MARK: - Subviews
    private lazy var labelsStackView: UIStackView = setupVerticalStackView(spacing: 20.0)
    lazy var imageView: UIImageView = setupImageView()
    lazy var nameLabel: UILabel = setupNameLabel()
    lazy var descriptionLabel: UITextView = setupDescriptionLabel()
    
    // MARK: - Model
    private let characterInfo: T
    
    // MARK: - Initialization
    init(characterInfo: T) {
        self.characterInfo = characterInfo
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup Subviews
extension CharacterInfoView {
    private func setupView() {
        backgroundColor = .systemBackground
        translatesAutoresizingMaskIntoConstraints = false
        setupConstraints()
    }
    
    private func setupVerticalStackView(spacing: CGFloat) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = spacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
    
    private func setupImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.setImage(for: characterInfo.photo)
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }
    
    private func setupNameLabel() -> UILabel {
        let label = setupLabel(font: UIFont.systemFont(ofSize: 18.0, weight: .bold))
        label.text = characterInfo.name
        return label
    }
    
    private func setupDescriptionLabel() -> UITextView {
        let textView = UITextView()
        textView.text = characterInfo.description
        textView.isEditable = false
        textView.isSelectable = false
        textView.textContainer.lineFragmentPadding = 0
        textView.textContainerInset = .zero
        textView.font = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        return textView
    }
    
    private func setupLabel(font: UIFont) -> UILabel {
        let label = UILabel()
        label.font = font
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}

// MARK: - Setup Constraints
extension CharacterInfoView {
    private func setupConstraints() {
        setupImageViewConstraints()
        setupLabelsStackViewConstraints()
        setupNameLabelConstraints()
        setupDescriptionLabelConstraints()
    }
    
    private func setupImageViewConstraints() {
        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            imageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6)
        ])
    }
    
    private func setupLabelsStackViewConstraints() {
        addSubview(labelsStackView)
        NSLayoutConstraint.activate([
            labelsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12.0),
            labelsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12.0),
            labelsStackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 12),
            labelsStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func setupNameLabelConstraints() {
        labelsStackView.addArrangedSubview(nameLabel)
    }
    
    private func setupDescriptionLabelConstraints() {
        labelsStackView.addArrangedSubview(descriptionLabel)
    }
}
