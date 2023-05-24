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
    var topLevelDict: TopLevelCharacterDict?
    let service: RickAndMortyCharacterListServiceable
    weak var delegate: CharacterListViewModelDelegate?
    init(delegate: CharacterListViewModelDelegate, serviceInjected: RickAndMortyCharacterListServiceable = RickAndMortyCharacterListService()) {
        self.delegate = delegate
        self.service = serviceInjected
        self.fetchCharacterList()
    }

    // MARK: - Functions
    
    func fetchCharacterList() {
        service.fetchCharacterList(with: .characterList) { result in
            switch result {
                
            case .success(let topLevel):
                self.topLevelDict = topLevel
                self.characters.append(contentsOf: topLevel.results)
                self.delegate?.charactersFetchedSuccessfully()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchNextCharacters(with nextURL: URL) {
        service.fetchNextCharacters(for: nextURL) { result in
            switch result {
                
            case .success(let topLevel):
                self.characters.append(contentsOf: topLevel.results)
                self.topLevelDict = topLevel
                self.delegate?.charactersFetchedSuccessfully()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
