//
//  RecipeTableViewController.swift
//  NutriTrackSample
//
//  Created by Alexandra Charland on 3/17/21.
//

import UIKit

class RecipeTableViewController: UITableViewController {

    var recipeList = [String]()
    var recipeData = RecipeDataLoader()
    let file = "sampleRecipes"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        recipeData.loadData(filename: file)
        recipeList=recipeData.getRecipes()
        recipeList = recipeList.sorted{ $0 < $1 }
        //enables large titles
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    //Number of rows in the section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeList.count
    }
    
    // Displays table view cells
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //configure the cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath)
        cell.textLabel?.text = recipeList[indexPath.row]
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "recipeSegue" {
            if let recipeVC = segue.destination as? RecipeViewController {
                if let indexPath = tableView.indexPath(for: (sender as? UITableViewCell)!) {
                    //sets the data for the destination controller
                    recipeVC.title = recipeList[indexPath.row]
                    recipeVC.recipeData = recipeData
                    recipeVC.selectedRecipe = indexPath.row
                }
            }
        }
    }
    
    @IBAction func unwindSegue (_ segue:UIStoryboardSegue){
        if segue.identifier=="doneSegue"{
            if let source = segue.source as? AddRecipeViewController {
                //only add a country if there is text in the textfield
                if ((source.newRecipe.isEmpty == false) && (source.ingredientList.isEmpty == false)){
                    //add recipe to recipe data
//                    continentsData.addCountry(index: selectedContinent, newCountry: source.addedCountry, newIndex: countryList.count)
                    let addedRecipe = RecipeData(newName: source.newRecipe, allIngredients: source.ingredientList)
                    recipeData.addRecipe(index: recipeList.endIndex, newRecipe: addedRecipe)
                    //add country to the array
                    recipeList.append(source.newRecipe)
                    recipeList = recipeList.sorted{ $0 < $1 }
                    tableView.reloadData()
                }
            }
        }
    }
}
