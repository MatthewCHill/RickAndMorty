//
//  CharacterTableViewCell.swift
//  RickAndMorty
//
//  Created by Matthew Hill on 3/7/23.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {

 // MARK: - Outlets
    
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    
    // MARK: - Functions
    
    func fetchCharacterImage(forCharacter character: Character) {
        characterNameLabel.text = character.name
        NetworkService.fetchCharacterImage(for: character) { [weak self] result in
            switch result {
                
            case .success(let image):
                DispatchQueue.main.async {
                    self?.characterImageView.image = image
                }
            case .failure(let error):
                print(error.errorDescription ?? "Unknown Error")
            }
        }
        
    }
}
