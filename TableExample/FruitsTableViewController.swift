//
//  DataTableViewController.swift
//  TableExample
//
//  Created by Ralf Ebert on 19/09/16.
//  Copyright © 2016 Example. All rights reserved.
//

import UIKit

class FruitsTableViewController: UITableViewController {
    
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
    
    @IBAction func NovoMembro(_ sender: Any) {
        
        let alert = UIAlertController(title: "Novo Membro", message: "Digite o nome", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Nome"
        }
        
        alert.addAction(UIAlertAction(title: "Adicionar", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            self.members.append((textField?.text)!)
            self.tableView.reloadData()
            self.updateSavedNames()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
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
        
        if(load_members == "") {
            defaults.removeObject(forKey: "members")
            return
        }
        
        defaults.set(load_members, forKey: "members")
        
    }
    
    
}
