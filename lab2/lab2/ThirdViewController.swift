//
//  ThirdViewController.swift
//  lab2
//
//  Created by Alexandra Charland on 2/3/21.
//

import UIKit

class ThirdViewController: UIViewController {

    @IBAction func animeButton(_ sender: UIButton) {
        //check to see if there's an app installed to handle this URL scheme
        if(UIApplication.shared.canOpenURL(URL(string: "pinterest://")!)){
            //open the app with this URL scheme
            UIApplication.shared.open(URL(string: "pinterest://")!, options: [:], completionHandler: nil)
        } else {
                UIApplication.shared.open(URL(string: "https://myanimelist.net/")!, options: [:], completionHandler: nil)
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
