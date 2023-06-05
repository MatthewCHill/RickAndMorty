//
//  CharacterTableViewCell.swift
//  RickAndMorty
//
//  Created by Matthew Hill on 3/7/23.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {

 // MARK: - Outlets
    
    @IBOutlet weak var characterImageView: ServiceRequestingImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    
    // MARK: - Functions
    
    func configure(with character: Character) {
        
        characterNameLabel.text = character.name
        fetchImage(with: character)
    }
    
    func fetchImage(with character: Character) {
        guard let finalURL = URL(string: character.image) else {return}
        characterImageView.fetchImage(using: finalURL)
    }
}
