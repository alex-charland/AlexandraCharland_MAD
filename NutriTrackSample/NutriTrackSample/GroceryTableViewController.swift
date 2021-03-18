//
//  GroceryTableViewController.swift
//  NutriTrackSample
//
//  Created by Alexandra Charland on 3/17/21.
//

import UIKit

class GroceryTableViewController: UITableViewController {

    var categoryList = [String]()
    var ingredientData = IngredientDataLoader()
    let file = "sampleIngredients"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        ingredientData.loadData(filename: file)
        categoryList=ingredientData.getCategories()
        
        //enables large titles
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    //Number of rows in the section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryList.count
    }
    
    // Displays table view cells
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //configure the cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "groceryCell", for: indexPath)
        cell.textLabel?.text = categoryList[indexPath.row]
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ingredientSegue" {
            if let ingredientVC = segue.destination as? IngredientTableViewController {
                if let indexPath = tableView.indexPath(for: (sender as? UITableViewCell)!) {
                    //sets the data for the destination controller
                    ingredientVC.title = categoryList[indexPath.row]
                    ingredientVC.ingredientData = ingredientData
                    ingredientVC.selectedCategory = indexPath.row
                }
            }
        }
    }

}
