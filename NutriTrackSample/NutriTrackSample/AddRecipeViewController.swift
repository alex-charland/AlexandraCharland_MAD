//
//  AddRecipeViewController.swift
//  NutriTrackSample
//
//  Created by Alexandra Charland on 3/18/21.
//

import UIKit

class AddRecipeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    var quantities = ["...","Teaspoon","Tablespoon","Cup","Milligram","Gram","Ounce","Fluid Ounce","Quantity"]
    var measurePick = ""
    var measureChoice = ""
    var ingredientPick = ""
    var ingredientChoice = ""
    
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
    var newIngVals = [Ingredient]()
    var recipeNutrition = Nutrition()
    var ingredientList = [String]()
    var amountList = [Double]()
    var quantityList = [String]()
    var ingredientFieldList = [String]()
    
    @IBOutlet weak var ingredientTable: UITableView!
    @IBOutlet weak var ingredientField: UITextField!
    @IBOutlet weak var quantityField: UITextField!
    @IBOutlet weak var amountField: UITextField!
    @IBOutlet weak var titleField: UITextField!
    
    @IBAction func addIngredientButton(_ sender: UIButton) {
        if (titleField.text == ""){
            let textFieldAlert = UIAlertController(title: "Missing Title", message: "Please give a title for the new recipe, or cancel", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            textFieldAlert.addAction(OKAction)
            present(textFieldAlert, animated: true, completion: nil)
        }
        else if(amountField.text != "" && quantityField.text != "" && ingredientField.text != ""){
            ingredientList.append(amountField.text! + " " + quantityField.text! + " " + ingredientField.text!)
            amountList.append(Double(amountField.text!)!)
            quantityList.append(quantityField.text!)
            ingredientFieldList.append(ingredientField.text!)
            ingredientTable.reloadData()
            amountField.text = ""
            quantityField.text = ""
            ingredientField.text = ""
        }
        else{
            let textFieldAlert = UIAlertController(title: "Missing Fields", message: "Please fill all fields", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            textFieldAlert.addAction(OKAction)
            present(textFieldAlert, animated: true, completion: nil)
        }
    }
    
    @IBAction func openQuantityAlert(_ sender: UITextField) {
        let quantityAlert = UIAlertController(title: "Quantity", message: "Choose a measurement \n\n\n\n\n\n", preferredStyle: .alert)
        
        
        let quantityFrame = UIPickerView(frame: CGRect(x: 5, y: 30, width: 250, height: 140))
        quantityFrame.tag = 1
        
        quantityAlert.view.addSubview(quantityFrame)
        quantityFrame.dataSource = self
        quantityFrame.delegate = self
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        quantityAlert.addAction(cancelAction)
        let chooseMeasureAction = UIAlertAction(title: "Done", style: .default, handler: {(UIAlertAction)in
            // set measurement
            if(self.measurePick != "..."){
                self.measureChoice = self.measurePick
                self.quantityField.text = self.measureChoice
            }
        })
        quantityAlert.addAction(chooseMeasureAction)
        present(quantityAlert, animated: true, completion: nil)
    }
    
    @IBAction func openIngredientAlert(_ sender: UITextField) {
        let ingredientAlert = UIAlertController(title: "New ingredient", message: "Choose an ingredient from your grocery database \n\n\n\n\n\n", preferredStyle: .alert)
        
        let ingFrame = UIPickerView(frame: CGRect(x: 5, y: 50, width: 250, height: 140))
        ingFrame.tag = 2
        
        ingredientAlert.view.addSubview(ingFrame)
        ingFrame.dataSource = self
        ingFrame.delegate = self
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        ingredientAlert.addAction(cancelAction)
        let chooseIngredientAction = UIAlertAction(title: "Done", style: .default, handler: {(UIAlertAction)in
            // sets ingredient
            if(self.ingredientPick != "..."){
                self.ingredientChoice = self.ingredientPick
                self.ingredientField.text = self.ingredientChoice
            }
        })
        ingredientAlert.addAction(chooseIngredientAction)
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
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            ingredientList.remove(at: indexPath.row)
            // Delete the row from the table
            tableView.deleteRows(at: [indexPath], with: .fade)
            //Delete from the data model instance
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if(pickerView.tag == 1){
            return 1
        }
        else{
            return 2
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        if pickerView.tag == 1{
            return quantities.count
        }
        else{
            if (component == categComponent){
                return categs.count
            }
            else{
                return ingredientNames.count
            }
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(pickerView.tag == 1){
            return quantities[row]
        }
        else{
            if (component == categComponent) {
                return categs[row]
            } else {
                return ingredientNames[row]
            }
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(pickerView.tag == 1){
            measurePick = quantities[row]
        }
        else{
            if (component == categComponent) {
                ingredientNames = []
                ingredientNames.append("...")
                ingredients = ingData.getIngredients(index: row)
                for ingredient in ingredients{
                    ingredientNames.append(ingredient.name)
                }
                pickerView.reloadComponent(ingComponent)
                pickerView.selectRow(0, inComponent: ingComponent, animated: true)
            }
            if(ingredientNames.count > 1){
                ingredientPick = ingredientNames[row]
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func calculateNutrition(){
        var ingredientSearch = [Ingredient]()
        var index = 0
        for ing in ingredientFieldList{
            for categ in 0...categs.count-1{
                ingredientSearch = ingData.getIngredients(index: categ)
                for ingredient in ingredientSearch{
                    if ing == ingredient.name{
                        newIngVals.append(convert(ing: ingredient, desired: quantityList[index], amount: amountList[index]))
                        index += 1
                        break
                    }
                }
                break
            }
        }
        for ing in newIngVals{
            recipeNutrition.calories += ing.nutrition.calories
            recipeNutrition.total_fat += ing.nutrition.total_fat
            recipeNutrition.saturated_fat += ing.nutrition.saturated_fat
            recipeNutrition.trans_fat += ing.nutrition.trans_fat
            recipeNutrition.cholesterol += ing.nutrition.cholesterol
            recipeNutrition.sodium += ing.nutrition.sodium
            recipeNutrition.total_carbohydrates += ing.nutrition.total_carbohydrates
            recipeNutrition.dietary_fiber += ing.nutrition.dietary_fiber
            recipeNutrition.sugar += ing.nutrition.sugar
            recipeNutrition.protein += ing.nutrition.protein
            recipeNutrition.vitamin_a += ing.nutrition.vitamin_a
            recipeNutrition.calcium += ing.nutrition.calcium
        }
        recipeNutrition.serving_size = 1
    }
    
    func convert(ing: Ingredient,desired: String, amount: Double)->Ingredient{
        //["...","Teaspoon","Tablespoon","Cup","Milligram","Gram","Ounce","Fluid Ounce","Quantity"]
        var multiple : Double = 0.0
        switch desired{
        case "Teaspoon":
            switch ing.nutrition.serving_size_unit{
            case "cup":
                multiple = 0.02 * amount
            case "g":
                multiple = 4.2 * amount
            case "mg":
                multiple = 4928.9 * amount
            case "oz":
                multiple = 0.16 * amount
            default:
                multiple = amount
            }
        case "Tablespoon":
            switch ing.nutrition.serving_size_unit{
            case "cup":
                multiple = 0.0625 * amount
            case "g":
                multiple = 15 * amount
            case "mg":
                multiple = 14787 * amount
            case "oz":
                multiple = 0.5 * amount
            default:
                multiple = amount
            }
        case "Cup":
            switch ing.nutrition.serving_size_unit{
            case "cup":
                multiple = amount
            case "g":
                multiple = 240 * amount
            case "mg":
                multiple = 236588 * amount
            case "oz":
                multiple = 8 * amount
            default:
                multiple = amount
            }
        case "Milligram":
            switch ing.nutrition.serving_size_unit{
            case "cup":
                multiple = 0.000004 * amount
            case "g":
                multiple = 0.001 * amount
            case "mg":
                multiple = amount
            case "oz":
                multiple = 0.000035274 * amount
            default:
                multiple = amount
            }
        case "Gram":
            switch ing.nutrition.serving_size_unit{
            case "cup":
                multiple = 0.004 * amount
            case "g":
                multiple = amount
            case "mg":
                multiple = 1000 * amount
            case "oz":
                multiple = 0.035274 * amount
            default:
                multiple = amount
            }
        case "Ounce":
            switch ing.nutrition.serving_size_unit{
            case "cup":
                multiple = 0.125 * amount
            case "g":
                multiple = 28.349 * amount
            case "mg":
                multiple = 28349.55 * amount
            case "oz":
                multiple = amount
            default:
                multiple = amount
            }
        case "Fluid Ounce":
            switch ing.nutrition.serving_size_unit{
            case "cup":
                multiple = 0.125 * amount
            case "g":
                multiple = 28.349 * amount
            case "mg":
                multiple = 28349.55 * amount
            case "oz":
                multiple = amount
            default:
                multiple = amount
            }
        default:
            multiple = amount
        }
        var newIng = ing
        newIng.nutrition.calories *= multiple
        newIng.nutrition.total_fat *= multiple
        newIng.nutrition.saturated_fat *= multiple
        newIng.nutrition.trans_fat *= multiple
        newIng.nutrition.cholesterol *= multiple
        newIng.nutrition.sodium *= multiple
        newIng.nutrition.total_carbohydrates *= multiple
        newIng.nutrition.dietary_fiber *= multiple
        newIng.nutrition.sugar *= multiple
        newIng.nutrition.protein *= multiple
        newIng.nutrition.vitamin_a *= multiple
        newIng.nutrition.calcium *= multiple
        return newIng
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ingData.loadData(file: "sampleIngredients.plist")
        categs = ingData.getCategories()
        ingredients = ingData.getIngredients(index: 0)
        ingredientNames.append("...")
        for ingredient in ingredients{
            ingredientNames.append(ingredient.name)
        }
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "doneSegue"{
            calculateNutrition()
            if titleField.text?.isEmpty == false{
                newRecipe = titleField.text!
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
