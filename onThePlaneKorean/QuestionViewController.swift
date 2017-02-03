//
//  QuestionViewController.swift
//  onThePlaneKorean
//
//  Created by Jay Steingold on 1/30/17.
//  Copyright © 2017 Goldjay. All rights reserved.
//

import UIKit
import GameplayKit //For shuffling the array

protocol sendBack {
    func setSentData(highScore: Double, completed: Bool)
}


class QuestionViewController: UIViewController {
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var questionLabel: UILabel!
    
    var num: Int = 0
    var deck: [[String]] = []
    var sendBack: sendBack?
    
    var correctAnswer: Int = 0
    var numAnswered: Int = 0
    var numCorrect: Int = 0
    var message = ""
    
    var completed: Bool = false
    var highScore: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button1.layer.cornerRadius = 10 //For rounding the corners
        button2.layer.cornerRadius = 10
        button3.layer.cornerRadius = 10

        print(num)
        print(deck)
        
        askQuestion()
        
        // Do any additional setup after loading the view.
    }

    func askQuestion(action: UIAlertAction! = nil) {
        //Shuffle cards in the deck
        //Shuffle Q and A's (Maybe move to detailView)
        
        //Possibly change to not shuffle every time
        
        //CHANGE TO SHUFFLE ONCE YOU MOVED THROUGH THE DECK
        let shuffledDeck = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: deck) as! [[String]]
        
        //Choose a random answer
        correctAnswer = Int(arc4random_uniform(3))
        print("CORRECT ANSWER IN askQuestion: ")
        print(correctAnswer)
        
        
        button1.setTitle(shuffledDeck[0][1], for: UIControlState.normal)
        button2.setTitle(shuffledDeck[1][1], for: UIControlState.normal)
        button3.setTitle(shuffledDeck[2][1], for: UIControlState.normal)
        
        questionLabel.text = shuffledDeck[correctAnswer][0]
    }
    
    func backToMenu(action: UIAlertAction! = nil) {
        //Send info back
        //Send info back
        sendBack?.setSentData(highScore: highScore, completed: completed)
        navigationController!.pushViewController(storyboard!.instantiateViewController(withIdentifier: "Menu") as UIViewController, animated: true)

    }
    
    @IBAction func answerTapped(_ sender: UIButton) {
        
        //If the title on the button tapped is the same as the correctAnswer
        if sender.tag == correctAnswer {
            print("YOU GOT ONE CORRECT")
            numCorrect += 1
            print("NUMBER OF CORRECT ANSWERS:")
            print(numCorrect)
        }
        
        numAnswered += 1
        //If have have answered enough questions (CHANGED FOR DEBUG)
        if numAnswered == 1 {
            
            print(Double(numCorrect/numAnswered))
            
            //If you did well enough, you can move to the next level
            if Double(numCorrect) / Double(numAnswered) >= 0.9 {
                //Send back completed
                completed = true
                
                //Maybe change this to a percentage if add # of cards
                highScore =  (Double(numCorrect / numAnswered)) * 100
                
                message = "You have answered \(numCorrect) out of \(numAnswered) questions correct. You can move on to the next section if you like."
            }
            else{
                //Message about trying harder
                message = "You have answered \(numCorrect) out of \(numAnswered) questions correct. I think you could use more practice."
            }
            
            //Send info back
            sendBack?.setSentData(highScore: highScore, completed: completed)
            print("HighScore: \(highScore)")
            print("Completed: \(completed)")
            
            
            //Reset stats
            numAnswered = 0
            numCorrect = 0
            
            let ac = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Back", style: .default, handler: backToMenu))
            ac.addAction(UIAlertAction(title: "Again", style: .default, handler: askQuestion))
            
            present(ac, animated: true)
            
        }
        askQuestion()
        
    }

}
