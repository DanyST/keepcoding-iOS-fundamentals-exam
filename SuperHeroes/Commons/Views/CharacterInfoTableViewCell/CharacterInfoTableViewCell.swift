//
//  CharacterInfoTableViewCell.swift
//  SuperHeroes
//
//  Created by Luis Herrera Lillo on 30-09-23.
//

import UIKit

final class CharacterInfoTableViewCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet weak var characterInfoImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    // MARK: - Configuration
    func configure(
        imageUrl: URL,
        name: String,
        description: String
    ) {
        characterInfoImageView.setImage(for: imageUrl)
        nameLabel.text = name
        descriptionLabel.text = description
    }
}

// MARK: - CellIdentifiable
extension CharacterInfoTableViewCell: CellIdentifiable {
    static var identifier = "CharacterInfoTableViewCell"
}

// MARK: - NibLoadable
extension CharacterInfoTableViewCell: NibLoadable {
    static var isNibLoadable = true
}
