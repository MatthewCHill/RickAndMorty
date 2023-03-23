//
//  RickAndMortyCharacterListService.swift
//  RickAndMorty
//
//  Created by Matthew Hill on 3/23/23.
//

import Foundation

protocol RickAndMortyCharacterListServiceable {
    func fetchCharacterList(with endpoint: RickAndMortyCharacterListEndpoint, completion: @escaping (Result<[Character], NetworkError>) -> Void)
}


struct RickAndMortyCharacterListService: RickAndMortyCharacterListServiceable {
    
    let service = APIService()
    
    func fetchCharacterList(with endpoint: RickAndMortyCharacterListEndpoint, completion: @escaping (Result<[Character], NetworkError>) -> Void) {
        
        guard let finalURL = endpoint.fullURL else {return}
        let request = URLRequest(url: finalURL)
        service.perform(request) { result in
            
            switch result {
                
            case .success(let data):
                do {
                    let topLevel = try JSONDecoder().decode(TopLevelCharacterDict.self, from: data)
                    let characters = topLevel.results
                    completion(.success(characters))
                } catch {
                    completion(.failure(.thrownError(error)))
                    print(error)
                }
            case .failure(let error):
                completion(.failure(.thrownError(error)))
            }
        }
    }
}
