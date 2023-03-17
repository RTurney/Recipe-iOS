//
//  RecipeTableViewCell.swift
//  recipe-ios
//
//  Created by RichardTurney on 16/03/2023.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {
    
    @IBOutlet var recipeName: UILabel!
    @IBOutlet var recipeImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(viewModel: RecipeTableCellViewModel) {
        recipeName.text = viewModel.name
        recipeImage.loadFrom(URLAddress: viewModel.imageURL!)
        
//        if let url = viewModel.imageURL {
//            URLSession.shared.dataTask(with: url) { data, res, error in
//                guard let data = data, error == nil else {
//                    return
//                }
//                DispatchQueue.main.async {
//                    self.recipeImage.image = UIImage(data: data)
//                }
//            }.resume()
//        }
    }
    
}

extension UIImageView {
    func loadFrom(URLAddress: String) {
        guard let url = URL(string: URLAddress) else {
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imageData) {
                        self?.image = loadedImage
                }
            }
        }
    }
}
