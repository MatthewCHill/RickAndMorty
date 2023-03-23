//
//  CharacterListViewModel.swift
//  RickAndMorty
//
//  Created by Matthew Hill on 3/23/23.
//

import Foundation

protocol CharacterListViewModelDelegate: AnyObject {
    func charactersFetchedSuccessfully()
}

class CharacterListViewModel {

    // MARK: - Properties
    var characters: [Character] = []
    let service: RickAndMortyCharacterListServiceable
    weak var delegate: CharacterListViewModelDelegate?
    init(delegate: CharacterListViewModelDelegate, serviceInjected: RickAndMortyCharacterListServiceable = RickAndMortyCharacterListService()) {
        self.delegate = delegate
        self.service = serviceInjected
        fetchCharacterList()
    }

    // MARK: - Functions
    
    func fetchCharacterList() {
        service.fetchCharacterList(with: .characterList) { result in
            switch result {
                
            case .success(let characters):
                self.characters.append(contentsOf: characters)
                self.delegate?.charactersFetchedSuccessfully()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
