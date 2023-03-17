//
//  ViewController.swift
//  recipe-ios
//
//  Created by RichardTurney on 07/03/2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    let url: String = "http://localhost:3000/recipes"
    let apiCaller = APICaller()
    var recipes = [Recipe]()
    var recipeViewModels = [RecipeTableCellViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Recipes"
        
        let nib = UINib(nibName: "RecipeTableViewCell", bundle: nil)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(nib, forCellReuseIdentifier: "RecipeTableViewCell")
        
        apiCaller.getRecipes(url: url) { result in
            switch result {
            case .success(let recipeList):
                self.recipes = recipeList
                self.recipeViewModels = recipeList.compactMap({
                    RecipeTableCellViewModel(name: $0.name, ingredients: $0.ingredients, id: $0._id, imageURL: $0.imageURL)
                })
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}


// MARK: - Table view delegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(recipeViewModels[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Table view data source
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeTableViewCell", for: indexPath) as! RecipeTableViewCell
            
        cell.configure(viewModel: recipeViewModels[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
