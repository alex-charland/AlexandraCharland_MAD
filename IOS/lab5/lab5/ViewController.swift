//
//  ViewController.swift
//  lab5
//
//  Created by Alexandra Charland on 3/8/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var foodLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var foodSearch: UITextField!
    @IBAction func searchButton(_ sender: UIButton) {
        if (foodSearch.text! != ""){//Don't do anything if text field is empty
            //Total number of tasks may be split between task list and finished task list
                foodDataHandler.onDataUpdate = {[weak self] (data:[Food]) in self?.render()}
                foodDataHandler.loadjson(search: foodSearch.text!)
            }
    }
    var foodDataHandler = FoodDataHandler()
    var allFood = [Food]()
    var foodDetail = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        foodDataHandler.onDataUpdate = {[weak self] (data:[Food]) in self?.render()}
        foodDataHandler.loadjson(search: "edamame")
        //print("Food item: \(allFood.count)")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodDetail.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let nutritionInfo = foodDetail[indexPath.row]
        cell.textLabel!.text = nutritionInfo
        return cell
    }
    
    func render() {
        allFood.removeAll()
        allFood = foodDataHandler.getFood()
        foodLabel.text = allFood[0].fields.item_name
        foodDetail.removeAll()
        foodDetail.append("Calories: " + String(allFood[0].fields.nf_calories) + " kcal")
        foodDetail.append("Cholesterol: " + String(allFood[0].fields.nf_cholesterol) + " mg")
        foodDetail.append("Saturated Fat: " + String(allFood[0].fields.nf_saturated_fat) + " g")
        foodDetail.append("Total Fat: " + String(allFood[0].fields.nf_total_fat) + " g")
        foodDetail.append("Sodium: " + String(allFood[0].fields.nf_sodium) + " mg")
        foodDetail.append("Sugars: " + String(allFood[0].fields.nf_sugars) + " g")
        foodDetail.append("Fiber: " + String(allFood[0].fields.nf_dietary_fiber) + " g")
        foodDetail.append("Protein: " + String(allFood[0].fields.nf_protein) + " g")
        tableView.reloadData()
    }
}

