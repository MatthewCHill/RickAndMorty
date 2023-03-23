//
//  RickAndMortyCharacterListEndpoint.swift
//  RickAndMorty
//
//  Created by Matthew Hill on 3/23/23.
//

import Foundation

enum RickAndMortyCharacterListEndpoint {
    
    static let baseURL = URL(string: "https://rickandmortyapi.com/api/")
    
    case characterList
    
    var fullURL: URL? {
        guard var url = Self.baseURL,
              var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else { return nil}
        switch self {
            
        case .characterList:
            urlComponents.path.append("character")
        }
        return urlComponents.url
    }
}
