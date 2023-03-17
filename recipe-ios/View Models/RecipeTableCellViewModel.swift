//
//  RecipeTableVCellModel.swift
//  recipe-ios
//
//  Created by RichardTurney on 16/03/2023.
//

import Foundation
import UIKit

struct RecipeTableCellViewModel {
    let name: String
    let ingredients: [String]
    let id: String
    let imageURL: String?
}
