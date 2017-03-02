//
//  VotoTableViewController.swift
//  TableExample
//
//  Created by Andre Ferreira dos Santos on 02/03/17.
//  Copyright © 2017 Example. All rights reserved.
//

import UIKit

class VotoTableViewController: UITableViewController {

    var members : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.isEditing = true
        
        let defaults = UserDefaults.standard
        if let load_members = defaults.object(forKey: "members") {
            let uni = load_members as! String
            let two = uni.components(separatedBy: ",")
            for el in two {
                members.append(el)
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)
        
        let fruitName = members[indexPath.row]
        cell.textLabel?.text = fruitName
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedObject = self.members[sourceIndexPath.row]
        members.remove(at: sourceIndexPath.row)
        members.insert(movedObject, at: destinationIndexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete) {
            members.remove(at: indexPath.row)
            updateSavedNames()
            tableView.reloadData()
        }
    }
    
    func updateSavedNames() {
        var load_members = ""
        for member in members {
            if(load_members == "") {
                load_members += member
            } else {
                load_members += ","+member
            }
        }
        
        let defaults = UserDefaults.standard
        defaults.set(load_members, forKey: "members")
        
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }
    
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    
    @IBAction func Done(_ sender: Any) {
        
        var counter = 0
        let max = members.count
        
        let defaults = UserDefaults.standard
        
        for member in members {
            
            if let previous = defaults.object(forKey: member) {
                let res = "\(previous),\(max - counter)"
                defaults.set(res, forKey: member)
            } else {
                let newRes = "\(max - counter)"
                defaults.set(newRes, forKey: member)
            }
            
            counter+=1
        }
        
        navigationController?.popViewController(animated: true)
    }
    
}
