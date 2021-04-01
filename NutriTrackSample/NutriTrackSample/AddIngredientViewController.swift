//
//  AddIngredientViewController.swift
//  NutriTrackSample
//
//  Created by Alexandra Charland on 3/18/21.
//

import UIKit

class AddIngredientViewController: UIViewController, UITextFieldDelegate {
    
    var newIngredient = String()
    
    @IBOutlet weak var searchField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "doneSegue"{
            //only add a country if there is text in the textfield
            if searchField.text?.isEmpty == false{
                newIngredient=searchField.text!
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
