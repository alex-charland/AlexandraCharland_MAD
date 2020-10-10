//
//  ViewController.swift
//  Project1
//
//  Created by Alexandra Charland on 10/5/20.
//  Copyright © 2020 Alexandra Charland. All rights reserved.
//

//SOURCES

//Tutorials:
//Table View: https://www.youtube.com/watch?v=LrCqXmHenJY
//Multiple Table Views: https://www.youtube.com/watch?v=gufghHEbD_w
//Swipe action buttons: https://www.youtube.com/watch?v=Jl91LuRCkxg
import UIKit

var complete: Bool = false //completion status is when 16 different tasks have been entered
let maxTasks = 15 //max number of tasks defined to be 1 less than intended amount
var taskNo = 0 //counter for number of tasks completed
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    var tasks: [String] = [] //Initialize empty string array to store list of tasks
    var finishedTasks: [String] = [] //Array to store list of finished tasks
    @IBOutlet weak var taskList: UITableView!
    @IBOutlet weak var finishedTaskList: UITableView!
    @IBOutlet weak var newTask: UITextField!
    @IBOutlet weak var meterImg: UIImageView!
    @IBOutlet weak var completedTasks: UILabel!
    @IBAction func addTask(_ sender: UIButton) {
        if (newTask.text! != ""){//Don't do anything if text field is empty
            //Total number of tasks may be split between task list and finished task list
            if ((tasks.count + finishedTasks.count) < maxTasks){
                //Insert up to 16 tasks at the beginning of the tasks array
                tasks.insert(newTask.text!, at: 0)
                taskList.reloadData()
            }
            else if((tasks.count + finishedTasks.count) == maxTasks){
                //Disable the textfield after the 16th entry
                tasks.insert(newTask.text!, at: 0)
                taskList.reloadData()
                newTask.text = "List is full!"
                newTask.isUserInteractionEnabled = false
                checkComplete()
            }
        }
    }
    
    //Determines how many rows are stored in each table view, which should be the current size of each array
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == taskList{
            return tasks.count
        }
        else{
            return finishedTasks.count
        }
    }
    //Populate the table view with enough copies (size specified in numberOfRowsInSection) of the prototype cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == taskList{
            let task = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "task")
            task.textLabel?.text = tasks[indexPath.row]//Display table row text in the same order as the elements in each array
            return task
        }
        else{
            let task = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "finishedTask")
            task.textLabel?.text = finishedTasks[indexPath.row]
            task.textLabel?.textColor = UIColor.systemGray
            return task
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    //Define swipe-right action for both table views
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?{
        if tableView == taskList{
            let finishTask = UIContextualAction(style: .normal, title: "Finish") { (_, _, _) in
                if(complete == false){
                    //Alert user if total number of input tasks have not been reached
                    let alert = UIAlertController(title: "Reminder", message:"Please enter a total of 16 tasks before proceeding", preferredStyle: UIAlertController.Style.alert)
                    let okay = UIAlertAction(title:"OK", style: UIAlertAction.Style.default, handler: nil)
                    alert.addAction(okay)
                    self.present(alert, animated: true, completion: nil)
                }
                else{
                    //Remove the task at the desired cell from the tasks array,
                    //add it to the finishedTasks array, change the meter image,
                    //and increment the task number label over the meter
                    let thisTask = self.tasks[indexPath.row]
                    self.tasks.remove(at: indexPath.row)
                    self.finishedTasks.insert(thisTask, at: 0)
                    taskNo = taskNo + 1
                    self.meterImg.image = UIImage(named: "t" + String(taskNo))
                    self.completedTasks.text = String(taskNo)
                    self.taskList.reloadData()
                    self.finishedTaskList.reloadData()
                }
            }
            finishTask.backgroundColor = UIColor.systemGreen
            return UISwipeActionsConfiguration(actions: [finishTask])
        }
        else{
            //Move the desired finished task out of the finishedTasks array and
            //into the tasks array, change the meter image, and decrement
            //the task number label over the meter
            let reTask = UIContextualAction(style: .normal, title: "Undo") { (_, _, _) in
                let thisTask = self.finishedTasks[indexPath.row]
                self.finishedTasks.remove(at: indexPath.row)
                self.tasks.insert(thisTask, at: 0)
                taskNo = taskNo - 1
                self.meterImg.image = UIImage(named: "t" + String(taskNo))
                self.completedTasks.text = String(taskNo)
                self.taskList.reloadData()
                self.finishedTaskList.reloadData()
            }
            return UISwipeActionsConfiguration(actions: [reTask])
        }
    }
    //Define swipe-left action for both table views
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if tableView == taskList{
            //Remove the desired task from the tasks array, enable the text field,
            //and change the "complete" boolean to false
            let deleteTask = UIContextualAction(style: .destructive, title: "Delete") { (_, _, _) in
                self.tasks.remove(at: indexPath.row)
                self.newTask.isUserInteractionEnabled = true
                self.newTask.text = ""
                self.checkComplete()
                self.taskList.reloadData()
            }
            return UISwipeActionsConfiguration(actions: [deleteTask])
        }
        else{
            //Same undo button as above
            let reTask = UIContextualAction(style: .normal, title: "Undo") { (_, _, _) in
                let thisTask = self.finishedTasks[indexPath.row]
                self.finishedTasks.remove(at: indexPath.row)
                self.tasks.insert(thisTask, at: 0)
                taskNo = taskNo - 1
                self.meterImg.image = UIImage(named: "t" + String(taskNo))
                self.completedTasks.text = String(taskNo)
                self.taskList.reloadData()
                self.finishedTaskList.reloadData()
            }
            return UISwipeActionsConfiguration(actions: [reTask])
        }
    }
    //Define conditions for "complete" boolean variable
    func checkComplete(){
        //Complete when the total number of tasks in the tasks and finishedTasks
        //arrays are 16, false otherwise
        if ((tasks.count + finishedTasks.count) < (maxTasks + 1)){
            complete = false
        }
        else{
            complete = true
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        newTask.delegate = self
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }


}
