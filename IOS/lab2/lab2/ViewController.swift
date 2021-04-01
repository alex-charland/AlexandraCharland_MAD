//
//  ViewController.swift
//  lab2
//
//  Created by Alexandra Charland on 2/3/21.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var animeLabel: UILabel!
    @IBOutlet weak var animePicker: UIPickerView!
    var animeData = PickerData()
    var genres = [String]()
    var titles = [String]()
    let genreComponent = 0
    let titleComponent = 1
    let filename = "animelist"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        animeData.loadData(filename: filename)
        genres = animeData.getGenres()
        titles = animeData.getTitles(index: 0)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == genreComponent {
            return genres.count
        } else {
            return titles.count
        }
    }
    
    //Picker Delegate methods
    //Returns the title for a given row
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == genreComponent {
            return genres[row]
        } else {
            return titles[row]
        }
    }
    
    //Called when a row is selected
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //checks which component was picked
        if component == genreComponent {
            titles = animeData.getTitles(index: row) //gets the albums for the selected artist
            animePicker.reloadComponent(titleComponent) //reloads the album component
            animePicker.selectRow(0, inComponent: titleComponent, animated: true) //set the album component back to 0
        }
        let genreRow = pickerView.selectedRow(inComponent: genreComponent) //gets the selected row for the artist
        let titleRow = pickerView.selectedRow(inComponent: titleComponent) //gets the selected row for the album
        animeLabel.text="I recommend \(titles[titleRow]) if you like the \(genres[genreRow].lowercased()) genre"
    }

}

