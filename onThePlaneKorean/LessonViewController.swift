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
    
    @IBOutlet weak var skipButton: UIButton!
    //var num: Int = 0
    //var deck: [[String]] = []
    //var lessonDeck: [String] = []
    
    //var count:Int = 0
    //var currentLesson = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lessonTitle.text = lessonDeck[0]
        
        tableView.delegate = self
        tableView.dataSource = self
        
        skipButton.backgroundColor = .clear
        skipButton.layer.cornerRadius = 5
        skipButton.layer.borderWidth = 2
        skipButton.layer.borderColor = UIColor.white.cgColor
        
        
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
    
    /*
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //on selection
    }
    */
    
    @IBAction func swipeRight(_ sender: AnyObject) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Explanation") as? ExplanationController {
            navigationController?.pushViewController(vc, animated: true)
        }

    }
    @IBAction func skipToQuiz(_ sender: AnyObject) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Question") as? QuestionViewController {
            //vc.num = num
            //vc.deck = deck
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

    

