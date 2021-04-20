//
//  GroceryTableViewController.swift
//  NutriTrackSample
//
//  Created by Alexandra Charland on 3/17/21.
//

import UIKit

class GroceryTableViewController: UITableViewController {

    var categoryList = [String]()
    var ingredientData = IngredientDataLoader()
    let initFile = "sampleIngredients"
    let file = "sampleIngredients.plist"

    @IBAction func addCategory(_ sender: UIBarButtonItem) {
        let newCategAlert = UIAlertController(title: "Add a new category", message: "Type in the name of your new category", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .cancel, handler: {(UIAlertAction)in
            if(newCategAlert.textFields?.first?.text != ""){
                self.ingredientData.addCategory(newCateg: (newCategAlert.textFields?.first?.text)!)
                self.ingredientData.saveData(fileName: self.file)
                self.categoryList = self.ingredientData.getCategories()
                self.tableView.reloadData()
            }
        })
        newCategAlert.addTextField { (textField) in
            textField.placeholder = "Category name"
          }
        newCategAlert.addAction(OKAction)
        present(newCategAlert, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if(!ingredientData.loadData(file: file)){//If the animelist plist does not exist locally, load initial plist data
            ingredientData.loadInitialData(file: initFile)
        }
        // Do any additional setup after loading the view.
        categoryList=ingredientData.getCategories()
        
        //enables large titles
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    @objc func applicationWillResignActive(_ notification: Notification){
        ingredientData.saveData(fileName: file)
    }
    //Number of rows in the section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryList.count
    }
    
    // Displays table view cells
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //configure the cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "groceryCell", for: indexPath)
        cell.textLabel?.text = categoryList[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            categoryList.remove(at: indexPath.row)
            // Delete the row from the table
            tableView.deleteRows(at: [indexPath], with: .fade)
            //Delete from the data model instance
            ingredientData.deleteCategory(index: indexPath.row)
            ingredientData.saveData(fileName: file)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ingredientSegue" {
            if let ingredientVC = segue.destination as? IngredientTableViewController {
                if let indexPath = tableView.indexPath(for: (sender as? UITableViewCell)!) {
                    //sets the data for the destination controller
                    ingredientVC.title = categoryList[indexPath.row]
                    ingredientVC.ingredientData = ingredientData
                    ingredientVC.selectedCategory = indexPath.row
                }
            }
        }
    }

}
