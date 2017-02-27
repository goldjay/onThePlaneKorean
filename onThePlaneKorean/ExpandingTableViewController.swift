//
//  TableViewController.swift
//  onThePlaneKorean
//
//  Created by Jay Steingold on 2/14/17.
//  Copyright © 2017 Goldjay. All rights reserved.
//

import UIKit

class ExpandingTableViewController: UITableViewController {
    
    var datasource = [ExpandingTableViewCellContent]()
    
    var deck: [[String]] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        print(deck.count)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableViewAutomaticDimension
        
        //Load deck into format for custom cells
        for num in 0..<deck.count {
            datasource.append(ExpandingTableViewCellContent(title: deck[num][2], subtitle: deck[num][0] + "     " + deck[num][1]))
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return datasource.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ExpandingTableViewCell

        cell.set(content: datasource[indexPath.row])

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let content = datasource[indexPath.row]
        
        content.expanded = !content.expanded
        tableView.reloadRows(at: [indexPath], with: .automatic)
        
    }
    


}
