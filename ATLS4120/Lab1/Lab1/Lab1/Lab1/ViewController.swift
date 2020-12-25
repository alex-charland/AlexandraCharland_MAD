//
//  ViewController.swift
//  Lab1
//
//  Created by Alexandra Charland on 9/7/20.
//  Copyright © 2020 Alexandra Charland. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var shiba1: UIImageView!
    @IBAction func sayHello(_ sender: UIButton) {
        if sender.tag == 1{
            shiba1.image = UIImage(named: "shiba2")
            message.text="Hewoo!"
        }
        else if sender.tag == 2{
            shiba1.image = UIImage(named: "shiba1")
            message.text="Soo sleeepy..."
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

