//
//  Recipe.swift
//  recipe-ios
//
//  Created by RichardTurney on 15/03/2023.
//

import Foundation
import UIKit

struct APIResponse: Codable {
    let recipes: [Recipe]
}
