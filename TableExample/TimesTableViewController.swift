//
//  TimesTableViewController.swift
//  TableExample
//
//  Created by Andre Ferreira dos Santos on 02/03/17.
//  Copyright © 2017 Example. All rights reserved.
//

import UIKit

class TimesTableViewController: UITableViewController {

    var time1 : [String] = []
    var time2 : [String] = []
    var media = [String:Int]()
    
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
                    
                    print(actual/max)
                    
                    media[member] = actual/max
                } else {
                    media[member] = 0
                }
            }
            
            let order = media.keysSortedByValue(isOrderedBefore: >)
            for i in stride(from: 0, to: order.count, by: 2) {
            
                let diceRoll = Int(arc4random_uniform(6) + 1)
                
                if(diceRoll % 2 == 0) {
                    time1.append(order[i])
                    if((i+1) < order.count) {
                        time2.append(order[i+1])
                    }
                    
                } else {
                    time2.append(order[i])
                    if((i+1) < order.count) {
                        time1.append(order[i+1])
                    }
                }
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Time \(section+1)"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(section == 0) {
            return time1.count
        } else {
            return time2.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)
        
        var name = ""
        
        if(indexPath.section == 0) {
            name = time1[indexPath.row]
        } else {
            name = time2[indexPath.row]
        }
        
        cell.textLabel?.text = name
        
        return cell
    }
    
}


// falcatruagem para ordenar dicionarios

extension Dictionary {
    func sortedKeys(isOrderedBefore:(Key,Key) -> Bool) -> [Key] {
        return Array(self.keys).sorted(by: isOrderedBefore)
    }
    
    // Slower because of a lot of lookups, but probably takes less memory (this is equivalent to Pascals answer in an generic extension)
    func sortedKeysByValue(isOrderedBefore:(Value, Value) -> Bool) -> [Key] {
        return sortedKeys {
            isOrderedBefore(self[$0]!, self[$1]!)
        }
    }
    
    // Faster because of no lookups, may take more memory because of duplicating contents
    func keysSortedByValue(isOrderedBefore:(Value, Value) -> Bool) -> [Key] {
        return Array(self)
            .sorted() {
                let (_, lv) = $0
                let (_, rv) = $1
                return isOrderedBefore(lv, rv)
            }
            .map {
                let (k, _) = $0
                return k
        }
    }
}
