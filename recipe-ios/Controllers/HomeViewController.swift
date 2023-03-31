//
//  ViewController.swift
//  recipe-ios
//
//  Created by RichardTurney on 07/03/2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    let url: String = "http://localhost:3000/recipes"
    let apiCaller = APICaller()
    var recipes = [Recipe]()
    var recipeViewModels = [RecipeTableCellViewModel]()
    var index: Int = 0
    
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
                    RecipeTableCellViewModel(name: $0.name, ingredients: $0.ingredients, id: $0._id, imageURL: $0.imageURL, instructions: $0.instructions)
                })
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToRecipe" {
            let destinationVC = segue.destination as! RecipePageViewController
            destinationVC.recipeName = recipeViewModels[self.index].name
            destinationVC.ingredients = recipeViewModels[self.index].ingredients
        }
    }
}


// MARK: - Table view delegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.index = indexPath.row
        print(recipeViewModels[self.index].name)
        tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: "goToRecipe", sender: self)
    }
}

// MARK: - Table view data source
extension HomeViewController: UITableViewDataSource {
    
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
