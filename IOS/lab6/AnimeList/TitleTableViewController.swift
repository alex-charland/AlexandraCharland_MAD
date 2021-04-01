//
//  TitleTableViewController.swift
//  AnimeList
//
//  Created by Alexandra Charland on 2/14/21.
//

import UIKit

class TitleTableViewController: UITableViewController {
    var animeData = animeDataLoader()
    var selectedtitle = 0
    var titleList = [String]()
    
    override func viewWillAppear(_ animated: Bool) {
        titleList = animeData.getTitles(index: selectedtitle)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return titleList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "animeCell", for: indexPath)

        cell.textLabel?.text = titleList[indexPath.row]

        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            titleList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            animeData.deleteTitle(index: selectedtitle, titleIndex: indexPath.row)
        }
    }

    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let fromRow = fromIndexPath.row
        let toRow = to.row
        let titletomove = titleList[fromRow]
        titleList.swapAt(fromRow, toRow)
        animeData.deleteTitle(index: selectedtitle, titleIndex: fromRow)
        animeData.addTitle(index: selectedtitle, newTitle: titletomove, titleIndex: toRow)

    }

    
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    @IBAction func unwindSegue (_ segue:UIStoryboardSegue){
        if segue.identifier=="doneSegue"{
            if let source = segue.source as? AddTitleViewController {
                if source.titleToAdd.isEmpty == false{
                    animeData.addTitle(index: selectedtitle, newTitle: source.titleToAdd, titleIndex: titleList.count)
                    titleList.append(source.titleToAdd)
                    tableView.reloadData()
                }
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
