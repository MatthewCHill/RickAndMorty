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
    let prev: String?
}

struct Character: Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let image: String
    let espisode: [String]
}

