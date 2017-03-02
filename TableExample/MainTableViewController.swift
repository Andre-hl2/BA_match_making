//
//  MainTableViewController.swift
//  TableExample
//
//  Created by Andre Ferreira dos Santos on 02/03/17.
//  Copyright © 2017 Example. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    @IBOutlet var zerar_cell: UITableViewCell!
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.row == tableView.indexPath(for: zerar_cell)?.row) {
            
            let defaults = UserDefaults.standard
            
            if let load_members = defaults.object(forKey: "members") {
                let uni = load_members as! String
                let two = uni.components(separatedBy: ",")
                
                for member in two {
                    defaults.removeObject(forKey: member)
                }
            }
            
            let alert = UIAlertController(title: "Concluído", message: "Votos zerados", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

}
