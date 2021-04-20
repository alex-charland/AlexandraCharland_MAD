//
//  AddIngredientViewController.swift
//  NutriTrackSample
//
//  Created by Alexandra Charland on 3/18/21.
//

import UIKit

class AddIngredientViewController: UIViewController, UITextFieldDelegate,UITableViewDelegate, UITableViewDataSource {
    
    var newIngredient = String()
    var newIng = Ingredient(newName: "")
    var foodDataHandler = FoodDataHandler()
    var allFood = [Food]()
    
    @IBOutlet weak var apiSearchResults: UITableView!
    @IBOutlet weak var searchField: UITextField!
    @IBAction func callIngr(_ sender: UITextField) {
        if searchField.text?.isEmpty == false{
            foodDataHandler.onDataUpdate = {[weak self] (data:[Food]) in self?.render()}
            foodDataHandler.loadjson(search: searchField.text!)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        allFood.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultCell", for: indexPath)
        cell.textLabel?.text = allFood[indexPath.row].fields.brand_name + " " + allFood[indexPath.row].fields.item_name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        newIng.name = allFood[indexPath.row].fields.brand_name + " " + allFood[indexPath.row].fields.item_name
        newIng.nutrition.calories = allFood[indexPath.row].fields.nf_calories ?? 0.0
        newIng.nutrition.cholesterol = allFood[indexPath.row].fields.nf_cholesterol ?? 0.0
        newIng.nutrition.saturated_fat = allFood[indexPath.row].fields.nf_saturated_fat ?? 0.0
        newIng.nutrition.total_fat = allFood[indexPath.row].fields.nf_total_fat ?? 0.0
        newIng.nutrition.sodium = allFood[indexPath.row].fields.nf_sodium ?? 0.0
        newIng.nutrition.dietary_fiber = allFood[indexPath.row].fields.nf_dietary_fiber ?? 0.0
        newIng.nutrition.sugar = allFood[indexPath.row].fields.nf_sugars ?? 0.0
        newIng.nutrition.protein = allFood[indexPath.row].fields.nf_protein ?? 0.0
        newIng.nutrition.serving_size = allFood[indexPath.row].fields.nf_serving_size_qty ?? 0.0
        newIng.nutrition.serving_size_unit = allFood[indexPath.row].fields.nf_serving_size_unit ?? "units"
        searchField.text = newIng.name
        tableView.deselectRow(at: indexPath, animated: true) //deselects the row that had been chosen
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "doneSegue"{
            //only add a country if there is text in the textfield
        }
    }

    func render() {
        allFood.removeAll()
        allFood = foodDataHandler.getFood()
        newIngredient=searchField.text!
        
//        newIng.nutrition.trans_fat = String(allFood[0].fields.nf_trans_fatty_acid)
//        newIng.nutrition.total_carbohydrates = String(allFood[0].fields.nf_total_carbohydrate)
//        newIng.nutrition.calcium = String(allFood[0].fields.nf_calcium_dv)
//        newIng.nutrition.vitamin_a = String(allFood[0].fields.nf_vitamin_a_dv)
        apiSearchResults.reloadData()
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
