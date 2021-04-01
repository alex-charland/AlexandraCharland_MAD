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
    var ingredientList = [String]()
    
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
                ingredients = ingData.getIngredients(index: row) //gets the albums for the selected artist
                for ingredient in ingredients{
                    ingredientNames.append(ingredient.name)
                }
                pickerView.reloadComponent(ingComponent) //reloads the album component
                pickerView.selectRow(0, inComponent: ingComponent, animated: true) //set the album component back to 0
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ingData.loadData(filename: file)
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
            //only add a country if there is text in the textfield
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
