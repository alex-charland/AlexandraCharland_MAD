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
    let initFile = "sampleRecipes"
    let file = "sampleRecipes.plist"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if(!recipeData.loadData(file: file)){//If the animelist plist does not exist locally, load initial plist data
            recipeData.loadInitialData(file: initFile)
        }
        recipeList=recipeData.getRecipes()
        recipeList = recipeList.sorted{ $0 < $1 }
        //enables large titles
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    @objc func applicationWillResignActive(_ notification: Notification){
        recipeData.saveData(fileName: file)
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
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            recipeList.remove(at: indexPath.row)
            // Delete the row from the table
            tableView.deleteRows(at: [indexPath], with: .fade)
            //Delete from the data model instance
            recipeData.deleteRecipe(index: indexPath.row)
            recipeData.saveData(fileName: file)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
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
                    var addedRecipe = RecipeData(newName: source.newRecipe, allIngredients: source.ingredientList)
                    addedRecipe.nutrition = source.recipeNutrition
                    recipeData.addRecipe(index: recipeList.endIndex, newRecipe: addedRecipe)
                    //add country to the array
                    recipeData.saveData(fileName: file)
                    recipeList.append(source.newRecipe)
                    recipeList = recipeList.sorted{ $0 < $1 }
                    tableView.reloadData()
                }
            }
        }
    }
}
