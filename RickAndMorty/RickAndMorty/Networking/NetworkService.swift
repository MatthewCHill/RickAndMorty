//
//  NetworkService.swift
//  RickAndMorty
//
//  Created by Matthew Hill on 3/7/23.
//

import UIKit

struct NetworkService {
    
    static func fetchCharacterList(completion: @escaping (Result<TopLevelCharacterDict, NetworkError>) -> Void) {
        
        guard let baseURL = URL(string: Constants.RickAndMortyURL.baseURL) else { completion(.failure(.invalidURL)); return}
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        urlComponents?.path.append(contentsOf: Constants.RickAndMortyURL.characterPath)
        
        guard let finalURL = urlComponents?.url else {completion(.failure(.invalidURL)); return}
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { data, response, error in
            
            if let error = error {
                completion(.failure(.thrownError(error)))
                return
            }
            if let response = response as? HTTPURLResponse {
                print(response.statusCode)
            }
            
            guard let data = data else {completion(.failure(.noData)); return}
            do {
                let topLevel = try JSONDecoder().decode(TopLevelCharacterDict.self, from: data)
                completion(.success(topLevel))
            } catch {
                completion(.failure(.unableToDecode))
                return
            }
        }.resume()
    }
    
    static func fetchCharacterImage(for character: Character, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
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
