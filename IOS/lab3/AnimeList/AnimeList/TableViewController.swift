//
//  TableViewController.swift
//  AnimeList
//
//  Created by Alexandra Charland on 2/14/21.
//

import UIKit

class TableViewController: UITableViewController {
    
    var data = animeDataLoader()
    var genres = [String]()
    let file = "animelist"
    var searchController = UISearchController()

    override func viewDidLoad() {
        super.viewDidLoad()
        data.loadAnimeData(file: file)
        genres = data.getGenres()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem

        let resultsController = SearchViewController()
        resultsController.allTitles = genres
        searchController = UISearchController(searchResultsController: resultsController)
        searchController.searchBar.placeholder = "Enter a genre"
        searchController.searchBar.sizeToFit()
        tableView.tableHeaderView=searchController.searchBar
        searchController.searchResultsUpdater = resultsController
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return genres.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "animeCell", for: indexPath)
        cell.textLabel?.text = genres[indexPath.row]
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "titleSegue" {
            if let titlevc = segue.destination as? TitleTableViewController {
                if let indexPath = tableView.indexPath(for: (sender as? UITableViewCell)!) {
                    titlevc.title = genres[indexPath.row]
                    titlevc.animeData = data
                    titlevc.selectedtitle = indexPath.row
                }
            }
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
