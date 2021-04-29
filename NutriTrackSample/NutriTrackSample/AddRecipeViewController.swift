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
    @IBOutlet weak var servingField: UITextField!
    
    @IBAction func addIngredientButton(_ sender: UIButton) {
        if (titleField.text == ""){
            let textFieldAlert = UIAlertController(title: "Missing Title", message: "Please give a title for the new recipe, or cancel", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            textFieldAlert.addAction(OKAction)
            present(textFieldAlert, animated: true, completion: nil)
        }
        if (servingField.text == ""){
            let textFieldAlert = UIAlertController(title: "Missing Serving Size", message: "Please give a serving amount for the new recipe, or cancel", preferredStyle: .alert)
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
        
        let ingFrame = UIPickerView(frame: CGRect(x: -30, y: 50, width: 450, height: 140))
        ingFrame.tag = 2
        
        ingredientAlert.view.addSubview(ingFrame)
        ingFrame.dataSource = self
        ingFrame.delegate = self
        
        //Alert constraints: https://stackoverflow.com/questions/26774038/how-to-set-height-and-width-of-a-uialertcontroller-in-ios-8
        
        let widthConstraints = ingredientAlert.view.constraints.filter({ return $0.firstAttribute == .width })
        ingredientAlert.view.removeConstraints(widthConstraints)
        let newWidth = UIScreen.main.bounds.width * 1.0
        let widthConstraint = NSLayoutConstraint(item: ingredientAlert.view,
                                                 attribute: .width,
                                                 relatedBy: .equal,
                                                 toItem: nil,
                                                 attribute: .notAnAttribute,
                                                 multiplier: 1,
                                                 constant: newWidth)
        ingredientAlert.view.addConstraint(widthConstraint)
        let firstContainer = ingredientAlert.view.subviews[0]
        let constraint = firstContainer.constraints.filter({ return $0.firstAttribute == .width && $0.secondItem == nil })
        firstContainer.removeConstraints(constraint)
        ingredientAlert.view.addConstraint(NSLayoutConstraint(item: firstContainer,
                                                    attribute: .width,
                                                    relatedBy: .equal,
                                                    toItem: ingredientAlert.view,
                                                    attribute: .width,
                                                    multiplier: 1.0,
                                                    constant: 0))
        let innerBackground = firstContainer.subviews[0]
        let innerConstraints = innerBackground.constraints.filter({ return $0.firstAttribute == .width && $0.secondItem == nil })
        innerBackground.removeConstraints(innerConstraints)
        firstContainer.addConstraint(NSLayoutConstraint(item: innerBackground,
                                                        attribute: .width,
                                                        relatedBy: .equal,
                                                        toItem: firstContainer,
                                                        attribute: .width,
                                                        multiplier: 1.0,
                                                        constant: 0))
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
    
    //Picker view font and size: https://stackoverflow.com/questions/44223862/how-do-i-change-the-font-size-in-a-uipickerview-in-swift
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel: UILabel? = (view as? UILabel)
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont(name: "Helvetica", size: 14)
            pickerLabel?.textAlignment = .center
        }
        if(pickerView.tag == 1){
            pickerLabel?.text = quantities[row]
        }
        else{
            if (component == categComponent) {
                pickerLabel?.text = categs[row]
            } else {
                pickerLabel?.text = ingredientNames[row]
            }
        }

        return pickerLabel!
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
                ingredientNames = ingredientNames.sorted{ $0 < $1 }
                pickerView.reloadComponent(ingComponent)
                pickerView.selectRow(0, inComponent: ingComponent, animated: true)
            }
            else{
                if(ingredientNames.count > 1){
                    ingredientPick = ingredientNames[row]
                }
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
        let range = 0...categs.count-1
        for ing in ingredientFieldList{
            for categ in range{
                ingredientSearch = ingData.getIngredients(index: categ)
                for ingredient in ingredientSearch{
                    if ing == ingredient.name{
                        newIngVals.append(convert(ing: ingredient, desired: quantityList[index], amount: amountList[index]))
                        index += 1
                        break
                    }
                }
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
        recipeNutrition.serving_size = Double(servingField.text!)!
        recipeNutrition.calories /= recipeNutrition.serving_size
        recipeNutrition.calories = round(recipeNutrition.calories * 10)/10.0
        recipeNutrition.total_fat /= recipeNutrition.serving_size
        recipeNutrition.total_fat = round(recipeNutrition.total_fat * 10)/10.0
        recipeNutrition.saturated_fat /= recipeNutrition.serving_size
        recipeNutrition.saturated_fat = round(recipeNutrition.saturated_fat * 10)/10.0
        recipeNutrition.trans_fat /= recipeNutrition.serving_size
        recipeNutrition.trans_fat = round(recipeNutrition.trans_fat * 10)/10.0
        recipeNutrition.cholesterol /= recipeNutrition.serving_size
        recipeNutrition.cholesterol = round(recipeNutrition.cholesterol * 10)/10.0
        recipeNutrition.sodium /= recipeNutrition.serving_size
        recipeNutrition.sodium = round(recipeNutrition.sodium * 10)/10.0
        recipeNutrition.total_carbohydrates /= recipeNutrition.serving_size
        recipeNutrition.total_carbohydrates = round(recipeNutrition.total_carbohydrates * 10)/10.0
        recipeNutrition.dietary_fiber /= recipeNutrition.serving_size
        recipeNutrition.dietary_fiber = round(recipeNutrition.dietary_fiber * 10)/10.0
        recipeNutrition.sugar /= recipeNutrition.serving_size
        recipeNutrition.sugar = round(recipeNutrition.sugar * 10)/10.0
        recipeNutrition.protein /= recipeNutrition.serving_size
        recipeNutrition.protein = round(recipeNutrition.protein * 10)/10.0
        recipeNutrition.vitamin_a /= recipeNutrition.serving_size
        recipeNutrition.vitamin_a = round(recipeNutrition.vitamin_a * 10)/10.0
        recipeNutrition.calcium /= recipeNutrition.serving_size
        recipeNutrition.calcium = round(recipeNutrition.calcium * 10)/10.0
        recipeNutrition.serving_size = 1
    }
    
    func convert(ing: Ingredient,desired: String, amount: Double)->Ingredient{
        //["...","Teaspoon","Tablespoon","Cup","Milligram","Gram","Ounce","Fluid Ounce","Quantity"]
        var multiple : Double = 0.0
        var unit : String = ""
        if(ing.nutrition.serving_size_unit.contains(" cup") || ing.nutrition.serving_size_unit.contains(" cup ")){
            unit = "cup"
        }
        else if (ing.nutrition.serving_size_unit.contains(" tsp") || ing.nutrition.serving_size_unit.contains(" tsp ")){
            unit = "tsp"
        }
        else if (ing.nutrition.serving_size_unit.contains(" tbsp") || ing.nutrition.serving_size_unit.contains(" tbsp ")){
            unit = "tbsp"
        }
        else if (ing.nutrition.serving_size_unit.contains(" mg") || ing.nutrition.serving_size_unit.contains(" mg ")){
            unit = "mg"
        }
        else if (ing.nutrition.serving_size_unit.contains(" g") || ing.nutrition.serving_size_unit.contains(" g ")){
            unit = "g"
        }
        else{
            unit = ing.nutrition.serving_size_unit
        }
        
        switch desired{
        case "Teaspoon":
            switch unit{
            case "cup":
                multiple = 0.0205372 * amount/ing.nutrition.serving_size
            case "tbsp":
                multiple = 0.333 * amount/ing.nutrition.serving_size
            case "g":
                multiple = 4.92892 * amount/ing.nutrition.serving_size
            case "mg":
                multiple = 4928.92 * amount/ing.nutrition.serving_size
            case "oz":
                multiple = 0.1738625365 * amount/ing.nutrition.serving_size
            default:
                multiple = amount/ing.nutrition.serving_size
            }
        case "Tablespoon":
            switch unit{
            case "cup":
                multiple = 0.0616115 * amount/ing.nutrition.serving_size
            case "g":
                multiple = 14.7868 * amount/ing.nutrition.serving_size
            case "mg":
                multiple = 14787 * amount/ing.nutrition.serving_size
            case "oz":
                multiple = 0.5215890206 * amount/ing.nutrition.serving_size
            default:
                multiple = amount/ing.nutrition.serving_size
            }
        case "Cup":
            switch unit{
            case "tsp":
                multiple = 48.6922 * amount/ing.nutrition.serving_size
            case "tbsp":
                multiple = 16.2307 * amount/ing.nutrition.serving_size
            case "g":
                multiple = 240 * amount/ing.nutrition.serving_size
            case "mg":
                multiple = 240000 * amount/ing.nutrition.serving_size
            case "oz":
                multiple = 8.46575 * amount/ing.nutrition.serving_size
            default:
                multiple = amount/ing.nutrition.serving_size
            }
        case "Milligram":
            switch unit{
            case "cup":
                multiple = 0.000004 * amount/ing.nutrition.serving_size
            case "g":
                multiple = 0.001 * amount/ing.nutrition.serving_size
            case "tsp":
                multiple = 0.0002028842 * amount/ing.nutrition.serving_size
            case "tbsp":
                multiple = 0.0000676279 * amount/ing.nutrition.serving_size
            case "oz":
                multiple = 0.000035274 * amount/ing.nutrition.serving_size
            default:
                multiple = amount/ing.nutrition.serving_size
            }
        case "Gram":
            switch unit{
            case "cup":
                multiple = 0.004 * amount/ing.nutrition.serving_size
            case "tsp":
                multiple = 0.202884 * amount/ing.nutrition.serving_size
            case "tbsp":
                multiple = 0.067628 * amount/ing.nutrition.serving_size
            case "mg":
                multiple = 1000 * amount/ing.nutrition.serving_size
            case "oz":
                multiple = 0.035274 * amount/ing.nutrition.serving_size
            default:
                multiple = amount/ing.nutrition.serving_size
            }
        case "Ounce":
            switch unit{
            case "cup":
                multiple = 0.125 * amount/ing.nutrition.serving_size
            case "g":
                multiple = 28.349 * amount/ing.nutrition.serving_size
            case "mg":
                multiple = 28349.55 * amount/ing.nutrition.serving_size
            case "tsp":
                multiple = 5.751670372 * amount/ing.nutrition.serving_size
            case "tbsp":
                multiple = 1.917218271 * amount/ing.nutrition.serving_size
            default:
                multiple = amount/ing.nutrition.serving_size
            }
        case "Fluid Ounce":
            switch unit{
            case "cup":
                multiple = 0.123223 * amount/ing.nutrition.serving_size
            case "g":
                multiple = 29.57354942 * amount/ing.nutrition.serving_size
            case "mg":
                multiple = 29573.54942 * amount/ing.nutrition.serving_size
            case "oz":
                multiple = 1.0432 * amount/ing.nutrition.serving_size
            case "tsp":
                multiple = 6 * amount/ing.nutrition.serving_size
            case "tbsp":
                multiple = 2 * amount/ing.nutrition.serving_size
            default:
                multiple = amount/ing.nutrition.serving_size
            }
        default:
            multiple = amount/ing.nutrition.serving_size
        }
        var newIng = Ingredient(newName: "")
        newIng.nutrition.calories += multiple * ing.nutrition.calories
        newIng.nutrition.total_fat += multiple * ing.nutrition.total_fat
        newIng.nutrition.saturated_fat += multiple * ing.nutrition.saturated_fat
        newIng.nutrition.trans_fat += multiple * ing.nutrition.trans_fat
        newIng.nutrition.cholesterol += multiple * ing.nutrition.cholesterol
        newIng.nutrition.sodium += multiple * ing.nutrition.sodium
        newIng.nutrition.total_carbohydrates += multiple * ing.nutrition.total_carbohydrates
        newIng.nutrition.dietary_fiber += multiple * ing.nutrition.dietary_fiber
        newIng.nutrition.sugar += multiple * ing.nutrition.sugar
        newIng.nutrition.protein += multiple * ing.nutrition.protein
        newIng.nutrition.vitamin_a += multiple * ing.nutrition.vitamin_a
        newIng.nutrition.calcium += multiple * ing.nutrition.calcium
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
        ingredientNames = ingredientNames.sorted{ $0 < $1 }
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
    
//    @IBAction func unwindSegue (_ segue:UIStoryboardSegue){
//        if segue.identifier=="doneSegue"{
//            if let source = segue.source as? AddIngredientViewController {
//                if source.newIngredient.isEmpty == false{
//                    ingData.addIngredient(categ: selectedCategory, newIngredient: source.newIng, newIndex: ingredientList.count)
//                    ingredientNames.append(source.newIng.name)
//                    ingredientNames = ingredientNames.sorted{$0 < $1}
//                    ingredientList = ingData.getIngredients(index: selectedCategory)
//                    ingredientList = ingredientList.sorted{ $0.name < $1.name }
//                    ingredientData.saveData(fileName: "sampleIngredients.plist")
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
