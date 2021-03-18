//
//  IngredientTableViewController.swift
//  NutriTrackSample
//
//  Created by Alexandra Charland on 3/17/21.
//

import UIKit

class IngredientTableViewController: UITableViewController {

    var ingredientData = IngredientDataLoader()
    var selectedCategory = 0
    var ingredientList = [Ingredient]()
    var ingredientNames = [String]()

    override func viewWillAppear(_ animated: Bool) {
        ingredientList = ingredientData.getIngredients(index: selectedCategory)
        for ingredient in ingredientList{
            ingredientNames.append(ingredient.name)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ingredientList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell", for: indexPath)

        cell.textLabel?.text = ingredientNames[indexPath.row]

        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ingredientNutrition" {
            if let nutritionVC = segue.destination as? IngNutTableViewController {
                if let indexPath = tableView.indexPath(for: (sender as? UITableViewCell)!) {
                    //sets the data for the destination controller
                    nutritionVC.title = ingredientNames[indexPath.row]
                    nutritionVC.ingredientData = ingredientData
                    nutritionVC.selectedIngredient = indexPath.row
                    nutritionVC.ingredientItem = ingredientList
                }
            }
        }
    }
    // Override to support conditional editing of the table view.
//    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        // Return false if you do not want the specified item to be editable.
//        return true
//    }



    // Override to support editing the table view.
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            //Delete the country from the array
//            ingredientList.remove(at: indexPath.row)
//            // Delete the row from the table
//            tableView.deleteRows(at: [indexPath], with: .fade)
//            //Delete from the data model instance
//            ingredientData.deleteIngredient(index: selectedCategory, currIndex: indexPath.row)
//        } else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }
//    }

}
