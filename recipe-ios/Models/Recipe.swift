//
//  Recipe.swift
//  recipe-ios
//
//  Created by RichardTurney on 16/03/2023.
//

import Foundation

struct Recipe: Codable {
    let name: String
    let ingredients: [String]
    let _id: String
    let imageURL: String
    let instructions: [String]
}
