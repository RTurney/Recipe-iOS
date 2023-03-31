//
//  RecipePageViewController.swift
//  recipe-ios
//
//  Created by RichardTurney on 17/03/2023.
//

import UIKit

class RecipePageViewController: UIViewController {
    
    var recipeName: String?
    var ingredients: [String]?
    var image: UIImage?
    
    @IBOutlet var recipeImage: UIImageView!
    @IBOutlet var recipeTitle: UILabel!
    @IBOutlet var ingredientTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ingredientTable.delegate = self
        ingredientTable.dataSource = self
        
        recipeTitle.text = recipeName
        recipeImage.image = image
    }
    
    @IBAction func goBack(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}

extension RecipePageViewController: UITableViewDelegate {
    
}

extension RecipePageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ingredientTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        var config = UIListContentConfiguration.cell()
        config.text = ingredients![indexPath.row]
        cell.contentConfiguration = config
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        (ingredients?.count)!
    }
}
