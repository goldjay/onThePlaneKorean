//
//  TutorialViewController.swift
//  onThePlaneKorean
//
//  Created by Jay Steingold on 1/31/17.
//  Copyright © 2017 Goldjay. All rights reserved.
//

import UIKit

class TutorialViewController: UIViewController {
    
    @IBOutlet weak var letterLabel: UILabel!
    @IBOutlet weak var romanizationLabel: UILabel!
    @IBOutlet weak var soundLabel: UILabel!
    
    //var num: Int = 0
    //var deck: [[String]] = []
    
    var pos = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Changes color based on level
        if num == 1 {
            self.view.backgroundColor = UIColor.customYellow
        } else if num == 2{
            self.view.backgroundColor = UIColor.customRed
        } else if num == 3 {
            self.view.backgroundColor = UIColor.customBlue
        }else {
            self.view.backgroundColor = UIColor.customGreen
        }
        
        presentData()
    }

    @IBAction func swipeRight(_ sender: AnyObject) {
        //Check
        if(pos > 0){
            pos -= 1
            presentData()
        }
        if(pos <= 0){
            //TO DO: Go back to the lesson
            
            //MAYBE: INCLUDE A SKIP BUTTON
        }
        
    }
    
    
    @IBAction func swipeLeft(_ sender: AnyObject) {
        //Check if we are out of bounds
        if(pos + 1 == currentDeck.count){
            //Go to the quiz
            if let vc = storyboard?.instantiateViewController(withIdentifier: "Question") as? QuestionViewController {
                //vc.num = num
                //vc.deck = deck
                navigationController?.pushViewController(vc, animated: true)
            }
        }else{
            pos += 1
            presentData()
        }
    }
    
    //Sets initial data for tutorial
    func presentData() {
        letterLabel.text = currentDeck[pos][0]
        romanizationLabel.text = currentDeck[pos][1]
        soundLabel.text = currentDeck[pos][2]
    }

}
