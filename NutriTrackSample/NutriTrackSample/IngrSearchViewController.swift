//
//  IngrSearchViewController.swift
//  NutriTrackSample
//
//  Created by Alexandra Charland on 4/20/21.
//

import UIKit

class IngrSearchViewController: UITableViewController, UISearchResultsUpdating {
    var allIngredients = [String]()
    var ingredientData = IngredientDataLoader()
    var ingredientList = [Ingredient]()
    var searchIngredients = [String]()
    func updateSearchResults(for searchController: UISearchController) {
        let searchString = searchController.searchBar.text
                searchIngredients.removeAll(keepingCapacity: true)
                if searchString?.isEmpty == false {
                    let searchfilter: (String) -> Bool = { name in
                        let range = name.range(of: searchString!, options: .caseInsensitive)
                        return range != nil
                    }
                    let matches = allIngredients.filter(searchfilter)
                    searchIngredients.append(contentsOf: matches)
                }
                tableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ingredientCell")
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
        return searchIngredients.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = searchIngredients[indexPath.row]
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ingredientNutrition" {
            if let nutritionVC = segue.destination as? IngNutTableViewController {
                if let indexPath = tableView.indexPath(for: (sender as? UITableViewCell)!) {
                    //sets the data for the destination controller
                    nutritionVC.title = searchIngredients[indexPath.row]
                    nutritionVC.ingredientData = ingredientData
                    nutritionVC.selectedIngredient = indexPath.row
                    nutritionVC.ingredientItem = ingredientList
                }
            }
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
