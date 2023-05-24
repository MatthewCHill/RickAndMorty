//
//  CharacterDetailViewModel.swift
//  RickAndMorty
//
//  Created by Matthew Hill on 5/23/23.
//

import Foundation

protocol CharacterDetailViewModelDelegate: AnyObject {
    func characterRecieved()
}

class CharacterDetailViewModel {
    
    // MARK: - Properties
    var character: Character?
    weak var delegate: CharacterDetailViewModelDelegate?
    
    init(delegate: CharacterDetailViewModelDelegate) {
        self.delegate = delegate
    }
}
