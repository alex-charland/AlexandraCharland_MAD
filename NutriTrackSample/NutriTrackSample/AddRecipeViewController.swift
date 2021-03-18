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
