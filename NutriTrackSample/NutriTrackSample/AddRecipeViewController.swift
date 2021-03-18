//
//  AddRecipeViewController.swift
//  NutriTrackSample
//
//  Created by Alexandra Charland on 3/18/21.
//

import UIKit

class AddRecipeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var newRecipe = String()
    var ingredientList = [String]()
    
    @IBOutlet weak var ingredientTable: UITableView!
    @IBOutlet weak var newIngredientField: UITextField!
    
    @IBAction func openIngredientAlert(_ sender: UITextField) {
        let addalert = UIAlertController(title: "New Item", message: "Add a new item to your grocery list", preferredStyle: .alert)
        //add textfield to the alert
        addalert.addTextField(configurationHandler: {(UITextField) in
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        addalert.addAction(cancelAction)
        let addItemAction = UIAlertAction(title: "Add", style: .default, handler: {(UIAlertAction)in
            // adds new item
//            let newitem = addalert.textFields![0] //gets textfield
//            let newGroceryItem = newitem.text! //gets textfield text
//            self.groceries.append(newGroceryItem) //adds textfield text to array
//            self.tableView.reloadData()
//            self.groceryData.addItem(newItem: newGroceryItem) // add to data handler
        })
        addalert.addAction(addItemAction)
        present(addalert, animated: true, completion: nil)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        ingredientList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newIngredientCell", for: indexPath)
        cell.textLabel?.text = ingredientList[indexPath.row]
        return cell
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

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
