//  ViewController.swift
//  onThePlaneKorean
//
//  Created by Jay Steingold on 3/2/17.
//  Copyright © 2017 Goldjay. All rights reserved.
//

import UIKit

class LessonViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var datasource = [LeftRightTableViewCellContent]()
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var lessonTitle: UILabel!
    
    @IBOutlet weak var topLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lessonTitle.text = lessonDeck[1]
        
        // Set top label here
        topLabel.text = lessonDeck[0]
        
        tableView.delegate = self
        tableView.dataSource = self
        
                
        //Load deck into format for custom cells
        for x in 0..<currentDeck.count {
            datasource.append(LeftRightTableViewCellContent(left: currentDeck[x][2], right: currentDeck[x][0]))
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentDeck.count // number of cells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LRCell", for: indexPath) as! LeftRightTableViewCell
        
        cell.setLR(content: datasource[indexPath.row])
        
        return cell
    }
    
    @IBAction func swipeRight(_ sender: AnyObject) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Explanation") as? ExplanationController {
            navigationController?.pushViewController(vc, animated: true)
        }

    }

}

    

