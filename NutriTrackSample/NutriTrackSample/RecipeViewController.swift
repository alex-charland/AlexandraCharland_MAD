//
//  RecipeViewController.swift
//  NutriTrackSample
//
//  Created by Alexandra Charland on 3/17/21.
//

import UIKit

class RecipeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var recipeData = RecipeDataLoader()
    var selectedRecipe = 0
    var recipeItems = [String]()
    
    @IBOutlet weak var recipeList: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        recipeItems = recipeData.getIngredients(index: selectedRecipe)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeItemCell", for: indexPath)
        cell.textLabel?.text = recipeItems[indexPath.row]
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "recipeNutrition" {
            if let recipeVC = segue.destination as? RecipNutTableViewController {
                //sets the data for the destination controller
                recipeVC.title = "Nutrition Facts"
                recipeVC.recipeData = recipeData
                recipeVC.selectedRecipe = selectedRecipe
                
            }
        }
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
