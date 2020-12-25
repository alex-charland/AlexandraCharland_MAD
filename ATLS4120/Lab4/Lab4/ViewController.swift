//
//  ViewController.swift
//  Lab4
//
//  Created by Alexandra Charland on 10/5/20.
//  Copyright © 2020 Alexandra Charland. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var originalAmount: UITextField!
    @IBOutlet weak var serving: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var newAmount: UILabel!
    @IBAction func updateStepper(_ sender: UIStepper) {
        serving.text = String(format: "%.0f", stepper.value)
        calculateAmount()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    override func viewDidLoad() {
        originalAmount.delegate = self
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }
    func calculateAmount(){
        var input:Double
        if originalAmount.text!.isEmpty{
            input = 0.0
            let alert = UIAlertController(title: "Reminder", message:"Please enter an ingredient amount in decimal format", preferredStyle: UIAlertController.Style.alert)
            let okay = UIAlertAction(title:"OK", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(okay)
            present(alert, animated: true, completion: nil)
        }
        else{
            input = Double(originalAmount.text!)!
        }
        
        let servingAmount = stepper.value
        var multAmount:Double = 0.0
        multAmount = input * servingAmount
        newAmount.text = String(format: "%.2f", multAmount)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        calculateAmount()
    }

}

