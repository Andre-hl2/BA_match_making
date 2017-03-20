//
//  PontosTableViewController.swift
//  TableExample
//
//  Created by Andre Ferreira dos Santos on 20/03/17.
//  Copyright © 2017 Example. All rights reserved.
//

import UIKit

class Membro {
    var Nome : String = ""
    var Pontos : Float = 0
}

class PontosTableViewController: UITableViewController {

    var membros : [Membro] = []
    var media = [String:Float]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        if let load_members = defaults.object(forKey: "members") {
            let uni = load_members as! String
            let members = uni.components(separatedBy: ",")
            
            for member in members {
                if let points = defaults.object(forKey: member) {
                    let str_points = points as! String
                    let each_point = str_points.components(separatedBy: ",")
                    
                    let max = each_point.count
                    var actual = 0
                    
                    for point in each_point {
                        let value = Int(point)
                        actual += value!
                    }
                    media[member] = Float(actual)/Float(max)
                } else {
                    media[member] = 0
                }
            }
            
            let order = media.keysSortedByValue(isOrderedBefore: >)
            for item in order {
                let membro = Membro()
                membro.Nome = item
                membro.Pontos = media[item]!
                membros.append(membro)
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return membros.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)
        
        let fruitName = membros[indexPath.row].Nome
        cell.textLabel?.text = fruitName
        cell.detailTextLabel?.text = "\(membros[indexPath.row].Pontos)"
        
        return cell
    }
}
