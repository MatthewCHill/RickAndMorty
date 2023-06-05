//
//  CharacterDetailViewController.swift
//  RickAndMorty
//
//  Created by Matthew Hill on 5/23/23.
//

import UIKit

class CharacterDetailViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var characterStatusLabel: UILabel!
    @IBOutlet weak var characterSpeciesLabel: UILabel!
    @IBOutlet weak var characterImage: ServiceRequestingImageView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Functions
    func updateView(character: Character) {
        fetchImage(with: character) {            
            self.characterNameLabel.text = character.name
            self.characterStatusLabel.text = character.status
            self.characterSpeciesLabel.text = character.species
        }
    }
    
    func fetchImage(with character: Character, completion: @escaping() -> Void) {
        guard let finalURL = URL(string: character.image) else {return}
        DispatchQueue.main.async {
            self.characterImage.fetchImage(using: finalURL)
        }
        completion()
    }
} // End Of Class

