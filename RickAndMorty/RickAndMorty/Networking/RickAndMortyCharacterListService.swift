//
//  RickAndMortyCharacterListService.swift
//  RickAndMorty
//
//  Created by Matthew Hill on 3/23/23.
//

import UIKit

protocol RickAndMortyCharacterListServiceable {
    func fetchCharacterList(with endpoint: RickAndMortyCharacterListEndpoint, completion: @escaping (Result<TopLevelCharacterDict, NetworkError>) -> Void)
    func fetchNextCharacters(for url: URL, completion: @escaping (Result<TopLevelCharacterDict, NetworkError>) -> Void)
    func fetchCharacterImage(for character: Character, completion: @escaping (Result<UIImage, NetworkError>) -> Void)
}


struct RickAndMortyCharacterListService: RickAndMortyCharacterListServiceable {
    
    let service = APIService()
    
    func fetchCharacterList(with endpoint: RickAndMortyCharacterListEndpoint, completion: @escaping (Result<TopLevelCharacterDict, NetworkError>) -> Void) {
        
        guard let finalURL = endpoint.fullURL else {return}
        let request = URLRequest(url: finalURL)
        service.perform(request) { result in
            
            switch result {
                
            case .success(let data):
                do {
                    let topLevel = try JSONDecoder().decode(TopLevelCharacterDict.self, from: data)
                    let topLevelDict = topLevel
                    completion(.success(topLevelDict))
                } catch {
                    completion(.failure(.thrownError(error)))
                    print(error)
                }
            case .failure(let error):
                completion(.failure(.thrownError(error)))
            }
        }
    }
    
    func fetchNextCharacters(for url: URL, completion: @escaping (Result<TopLevelCharacterDict, NetworkError>) -> Void) {
        let request = URLRequest(url: url)
        service.perform(request) { result in
            switch result {
            case .success(let data):
                do {
                    let topLevel = try JSONDecoder().decode(TopLevelCharacterDict.self, from: data)
                    completion(.success(topLevel))
                } catch {
                    print(error.localizedDescription)
                    completion(.failure(.unableToDecode))
                }
            case .failure(let error):
                print(error.errorDescription)
                completion(.failure(.thrownError(error)))
            }
        }
    }
    
    func fetchCharacterImage(for character: Character, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
        guard let finalURL = URL(string: character.image) else {completion(.failure(.invalidURL)); return}
        
        URLSession.shared.dataTask(with: finalURL) { data, response, error in
            if let error = error {
                completion(.failure(.thrownError(error)))
                return
            }
            if let response = response as? HTTPURLResponse {
                print("Status Code: \(response.statusCode)")
            }
            guard let data = data else {completion(.failure(.noData)); return}
            guard let image = UIImage(data: data) else {completion(.failure(.unableToDecode)); return}
            completion(.success(image))
        }.resume()
    }
}
