//
//  RecipNutTableViewController.swift
//  NutriTrackSample
//
//  Created by Alexandra Charland on 3/17/21.
//

import UIKit

class RecipNutTableViewController: UITableViewController {

    var recipeData = RecipeDataLoader()
    var selectedRecipe = 0
    var recipeItem = [Nutrition]()
    
    @IBOutlet weak var servingSize: UILabel!
    @IBOutlet weak var calories: UILabel!
    @IBOutlet weak var totalFat: UILabel!
    @IBOutlet weak var saturatedFat: UILabel!
    @IBOutlet weak var transFat: UILabel!
    @IBOutlet weak var cholesterol: UILabel!
    @IBOutlet weak var sodium: UILabel!
    @IBOutlet weak var totalCarbohydrates: UILabel!
    @IBOutlet weak var dietaryFiber: UILabel!
    @IBOutlet weak var sugar: UILabel!
    @IBOutlet weak var protein: UILabel!
    @IBOutlet weak var vitaminA: UILabel!
    @IBOutlet weak var calcium: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func viewWillAppear(_ animated: Bool) {
        recipeItem.append(recipeData.getNutrition(index: selectedRecipe))
        let ing = recipeItem[0]
        servingSize.text = ing.serving_size
        calories.text = ing.calories
        totalFat.text = ing.total_fat
        saturatedFat.text = ing.saturated_fat
        transFat.text = ing.trans_fat
        cholesterol.text = ing.cholesterol
        sodium.text = ing.sodium
        totalCarbohydrates.text = ing.total_carbohydrates
        dietaryFiber.text = ing.dietary_fiber
        sugar.text = ing.sugar
        protein.text = ing.protein
        vitaminA.text = ing.vitamin_a
        calcium.text = ing.calcium
        
    }
    // MARK: - Table view data source


    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
