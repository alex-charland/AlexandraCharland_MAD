//
//  ViewController.swift
//  Project1
//
//  Created by Alexandra Charland on 10/5/20.
//  Copyright © 2020 Alexandra Charland. All rights reserved.
//

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
    //Display table row text in the same order as the elements in each array
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == taskList{
            let task = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "task")
            task.textLabel?.text = tasks[indexPath.row]
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
                    let alert = UIAlertController(title: "Reminder", message:"Please enter a total of 16 tasks before proceeding", preferredStyle: UIAlertController.Style.alert)
                    let okay = UIAlertAction(title:"OK", style: UIAlertAction.Style.default, handler: nil)
                    alert.addAction(okay)
                    self.present(alert, animated: true, completion: nil)
                }
                else{
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
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if tableView == taskList{
            if (editingStyle == UITableViewCell.EditingStyle.delete)
            {
                self.tasks.remove(at: indexPath.row)
                newTask.isUserInteractionEnabled = true
                newTask.text = ""
                checkComplete()
                taskList.reloadData()
            }
        }
    }
    func checkComplete(){
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

