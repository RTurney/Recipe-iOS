//
//  APICaller.swift
//  recipe-ios
//
//  Created by RichardTurney on 16/03/2023.
//

import Foundation
import UIKit

struct APICaller {
    
    func getRecipes(url: String, completion: @escaping (Result<[Recipe], Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: URL(string: url)!) { data, res, error in
            guard let data = data, error == nil else {
                print("Call error")
                return
            }
            
            do {
                let result = try JSONDecoder().decode(APIResponse.self, from: data)
                completion(.success(result.recipes))
            } catch {
                print("Failure to decode")
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}
