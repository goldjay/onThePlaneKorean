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
    @IBOutlet weak var lessonText: UILabel!
    @IBOutlet weak var lessonImage: UIImageView!
    @IBOutlet weak var lessonTitle: UILabel!
    
    var num: Int = 0
    var deck: [[String]] = []
    var lessonDeck: [String] = []
    
    var count:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set the 
        
        lessonTitle.text = lessonDeck[0]
        lessonText.text = lessonDeck[1]
        //lessonImage //TO DO: SET THE IMAGE
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //Load deck into format for custom cells
        for x in 0..<deck.count {
            datasource.append(LeftRightTableViewCellContent(left: deck[x][2], right: deck[x][0]))
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deck.count // number of cells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LRCell", for: indexPath) as! LeftRightTableViewCell
        
        cell.setLR(content: datasource[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //on selection
    }
    
    @IBAction func swipeRight(_ sender: AnyObject) {
        //Send to tutorial viewController
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Tutorial") as? TutorialViewController {
            
            vc.deck = deck
            vc.num = num
            //vc.sendBack = self //Must send back a different way
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
