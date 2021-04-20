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
        servingSize.text = String(ing.serving_size) + " " + ing.serving_size_unit
        calories.text = String(ing.calories)
        totalFat.text = String(ing.total_fat) + " g"
        saturatedFat.text = String(ing.saturated_fat) + " g"
        transFat.text = String(ing.trans_fat) + " g"
        cholesterol.text = String(ing.cholesterol) + " mg"
        sodium.text = String(ing.sodium) + " mg"
        totalCarbohydrates.text = String(ing.total_carbohydrates) + " g"
        dietaryFiber.text = String(ing.dietary_fiber) + " g"
        sugar.text = String(ing.sugar) + " g"
        protein.text = String(ing.protein) + " g"
        vitaminA.text = String(ing.vitamin_a) + "%"
        calcium.text = String(ing.calcium) + "%"
        
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
