//
//  AddRecipeViewController.swift
//  NutriTrackSample
//
//  Created by Alexandra Charland on 3/18/21.
//

import UIKit

class AddRecipeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {
    
//    var quantities = ["Teaspoon","Tablespoon","Cup","Quantity"]
    var choices = ["Test","Meep"]
    let categComponent = 0
    let ingComponent = 1
    var ingData = IngredientDataLoader()
    var pickerView = UIPickerView()
    var typeValue = String()
    let file = "sampleIngredients"
    
    var categs = [String]()
    var ingredients = [Ingredient]()
    var ingredientNames = [String]()
    
    var newRecipe = String()
    var ingredientList = [String]()
    
    @IBOutlet weak var ingredientTable: UITableView!
    @IBOutlet weak var newIngredientField: UITextField!
    
    
    
    @IBAction func openIngredientAlert(_ sender: UITextField) {
        let ingredientAlert = UIAlertController(title: "New ingredient", message: "Choose an ingredient from your grocery database \n\n\n\n\n\n", preferredStyle: .alert)
        
        
        let pickerFrame = UIPickerView(frame: CGRect(x: 5, y: 30, width: 250, height: 140))
        ingredientAlert.view.addSubview(pickerFrame)
        pickerFrame.dataSource = self
        pickerFrame.delegate = self
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        ingredientAlert.addAction(cancelAction)
        let addItemAction = UIAlertAction(title: "Add", style: .default, handler: {(UIAlertAction)in
            // adds new item
//            let newitem = addalert.textFields![0] //gets textfield
//            let newGroceryItem = newitem.text! //gets textfield text
//            self.groceries.append(newGroceryItem) //adds textfield text to array
//            self.tableView.reloadData()
//            self.groceryData.addItem(newItem: newGroceryItem) // add to data handler
        })
        ingredientAlert.addAction(addItemAction)
        present(ingredientAlert, animated: true, completion: nil)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        ingredientList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newIngredientCell", for: indexPath)
        cell.textLabel?.text = ingredientList[indexPath.row]
        return cell
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        if (component == categComponent){
            return categs.count
        }
        else{
            return ingredientNames.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (component == categComponent) {
            return categs[row]
        } else {
            return ingredientNames[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (component == categComponent) {
            ingredients = ingData.getIngredients(index: row) //gets the albums for the selected artist
            for ingredient in ingredients{
                ingredientNames.append(ingredient.name)
            }
            pickerView.reloadComponent(ingComponent) //reloads the album component
            pickerView.selectRow(0, inComponent: ingComponent, animated: true) //set the album component back to 0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ingData.loadData(filename: file)
        categs = ingData.getCategories()
        ingredients = ingData.getIngredients(index: 0)
        for ingredient in ingredients{
            ingredientNames.append(ingredient.name)
        }
        // Do any additional setup after loading the view.
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
