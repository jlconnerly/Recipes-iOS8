//
//  MainViewController.swift
//  Recipes
//
//  Created by Jake Connerly on 6/17/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    //
    // MARK: - Outlets & Properties
    //
    
    @IBOutlet weak var searchTextField: UITextField!
    
    let networkClient = RecipesNetworkClient()
    
    var allRecipes: [Recipe] = [] {
        didSet {
            filterRecipes()
        }
    }
    var recipesTableViewController: RecipesTableViewController? {
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
        }
    }
    var filteredRecipes: [Recipe] = [] {
        didSet {
           recipesTableViewController?.recipes = filteredRecipes
        }
    }
    
    //
    // MARK: - View Lifecyles
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filteredRecipes = allRecipes
        networkClient.fetchRecipes { allRecipes, error in
            if let error = error {
                NSLog("Error fetching recipes: \(error)")
                return
            }
            DispatchQueue.main.async {
                self.allRecipes = allRecipes ?? []
            }
        }
    }
    
    //
    // MARK: - IBActions and Methods
    //
    
    @IBAction func editingDidEndOnExit(_ sender: Any) {
        resignFirstResponder()
        filterRecipes()
    }
    
    func filterRecipes() {
    
        if let searchTerm = searchTextField.text, !searchTerm.isEmpty {
                filteredRecipes = allRecipes.filter({ $0.name.lowercased() == searchTerm.lowercased() || $0.instructions.lowercased().contains(searchTerm.lowercased())})
                
            }else {
                filteredRecipes = allRecipes
        }
    }

    //
    // MARK: - Navigation
    //
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EmbededSegue"{
            recipesTableViewController = segue.destination as? RecipesTableViewController
        }
    }
}
