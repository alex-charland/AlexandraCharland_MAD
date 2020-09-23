//
//  ViewController.swift
//  Lab2
//
//  Created by Alexandra Charland on 9/22/20.
//  Copyright © 2020 Alexandra Charland. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    func updateCaps(){
        if capitalSwitch.isOn{
            icLabel.text=icLabel.text?.uppercased()
        }
        else{
            icLabel.text=icLabel.text?.lowercased()
        }
    }
    @IBAction func shiftSize(_ sender: UISlider) {
        let fontSize=sender.value
        fontSizeLabel.text=String(format: "%.0f",fontSize)
        let fontSizeCGFloat = CGFloat(fontSize)
        icLabel.font=UIFont.systemFont(ofSize: fontSizeCGFloat)
    }
    @IBAction func toggleCase(_ sender: UISwitch) {
        if sender.isOn{
            icLabel.text=icLabel.text?.uppercased()
        }
        else{
            icLabel.text=icLabel.text?.lowercased()
        }
    }
    @IBAction func toggleColor(_ sender: UISwitch) {
        if sender.isOn{
            icLabel.textColor=UIColor.systemPink
        }
        else{
            icLabel.textColor=UIColor.systemGray
        }
    }
    @IBAction func toggleIC(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex==0{
            icImage.image = UIImage(named:"vic")
            icLabel.text="Vanilla"
        }
        else if sender.selectedSegmentIndex==1{
            icImage.image=UIImage(named:"cic")
            icLabel.text="Chocolate"
        }
        updateCaps()
    }
    @IBOutlet weak var sizeSlider: UISlider!
    @IBOutlet weak var capitalSwitch: UISwitch!
    @IBOutlet weak var colorSwitch: UISwitch!
    @IBOutlet weak var fontSizeLabel: UILabel!
    @IBOutlet weak var icImage: UIImageView!
    @IBOutlet weak var icLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

