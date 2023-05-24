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
    func updateView(character: Character, image: UIImage?) {
        loadViewIfNeeded()
        if let image {
            characterImage.image = image
        }
        characterNameLabel.text = character.name
        characterStatusLabel.text = character.status
        characterSpeciesLabel.text = character.species
    }
} // End Of Class

