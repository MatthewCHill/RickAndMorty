//
//  Character.swift
//  RickAndMorty
//
//  Created by Matthew Hill on 3/7/23.
//

import Foundation

struct TopLevelCharacterDict: Codable {
    let info: PageInfo
    let results: [Character]
}

struct PageInfo: Codable {
    let count: Int
    let pages: Int
    let next: String
}

struct Character: Codable {
    var id: Int?
    var name: String?
    var status: String?
    var species: String?
    var gender: String?
    var image: String
}


