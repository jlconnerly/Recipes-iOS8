//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Jake Connerly on 6/17/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    
    //
    // MARK: - Outlets and Properties
    //
    
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var recipeTextView: UITextView!
    
    var recipe: Recipe? {
        didSet {
            updateViews()
        }
    }
    
    //
    //MARK: - View Lifecycle
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    //
    // MARK: - Methods
    //
    
    func updateViews() {
        guard isViewLoaded,
              let recipe = recipe else { return }
            recipeNameLabel?.text = recipe.name
            recipeTextView?.text = recipe.instructions
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
