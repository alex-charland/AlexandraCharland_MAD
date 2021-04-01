//
//  SecondViewController.swift
//  lab2
//
//  Created by Alexandra Charland on 2/3/21.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBAction func datePicker(_ sender: UIDatePicker) {
        timeLabel.text = "You've changed the date"
    }
    //        timeLabel.text = "\(currDate.string(from: datePickerthing.date))"
    
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
