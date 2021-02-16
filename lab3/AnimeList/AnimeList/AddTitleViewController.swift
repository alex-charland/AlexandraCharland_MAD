//
//  AddTitleViewController.swift
//  AnimeList
//
//  Created by Alexandra Charland on 2/14/21.
//

import UIKit

class AddTitleViewController: UIViewController {
    
    var titleToAdd = String()

    @IBOutlet weak var titleTextField: UITextField!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "doneSegue"{
            //only add a country if there is text in the textfield
            if titleTextField.text?.isEmpty == false{
                titleToAdd=titleTextField.text!
            }
        }
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
