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
    func setSentData(num: Int, highScore: Double, completed: Bool)
}


class QuestionViewController: UIViewController {
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    
    //From menu view
    var num: Int = 0
    var deck: [[String]] = []
    var sendBack: sendBack?
    
    //Data from the quiz
    var correctAnswer: Int = 0
    var numAnswered: Int = 0
    var numCorrect: Int = 0
    var message = ""
    
    var completed: Bool = false
    var highScore: Double = 0
    
    //For the timer
    var timer = Timer()
    var originalWidth: CGFloat = 0
    var decrementAmt: CGFloat = 0
    var numSecs: CGFloat = 30
    var count: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button1.layer.cornerRadius = 10 //For rounding the corners
        button2.layer.cornerRadius = 10
        button3.layer.cornerRadius = 10
        
        originalWidth = timerLabel.frame.width
        decrementAmt = originalWidth / numSecs
        
        askQuestion()
    }

    func askQuestion(action: UIAlertAction! = nil) {
        
        //resetTimerLabel()
        
        if(!checkIfFinished()){
            //TO DO: change shuffle to happen after user reaches end of deck
            let shuffledDeck = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: deck) as! [[String]]
            
            //Choose a random answer
            correctAnswer = Int(arc4random_uniform(3))
            
            button1.setTitle(shuffledDeck[0][1], for: UIControlState.normal)
            button2.setTitle(shuffledDeck[1][1], for: UIControlState.normal)
            button3.setTitle(shuffledDeck[2][1], for: UIControlState.normal)
            
            questionLabel.text = shuffledDeck[correctAnswer][0]
            
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(QuestionViewController.setTimerLabel), userInfo: nil, repeats: true)
        }
    }
    
    func checkIfFinished() -> Bool{
        if numAnswered == 3 {
            
            timer.invalidate()
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
            //sendBack?.setSentData(num: num, highScore: highScore, completed: completed)
            
            //Reset stats
            numAnswered = 0
            numCorrect = 0
            
            
            //TO DO: Change to transition to view instead
            let ac = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Back", style: .default, handler: backToMenu))
            ac.addAction(UIAlertAction(title: "Again", style: .default, handler: askQuestion))
            
            present(ac, animated: true)
            return true
        }
        return false
    }
    
    func setTimerLabel()
    {
        let currWidth = timerLabel.frame.width
        
        if currWidth <= 0
        {
            numAnswered += 1
            resetTimerLabel()
            askQuestion()
        }
        
        
        let frmPlay : CGRect = timerLabel.frame
        
        let originXbutton = frmPlay.origin.x
        let originYbutton = frmPlay.origin.y
        
        let oldHeight = frmPlay.size.height
        let newWidth = originalWidth - (decrementAmt * count)
        
        timerLabel.frame = CGRect(x: originXbutton, y: originYbutton, width: newWidth, height: oldHeight)
        
        //Update the display
        //timerLabel
        
        count += 1
    }
    
    func resetTimerLabel()
    {
        //Set width to original
        let frmPlay : CGRect = timerLabel.frame
        
        let originXbutton = frmPlay.origin.x
        let originYbutton = frmPlay.origin.y
        
        let oldHeight = frmPlay.size.height
        let newWidth = originalWidth
        
        timerLabel.frame = CGRect(x: originXbutton, y: originYbutton, width: newWidth, height: oldHeight)
        
        timer.invalidate()
        count = 0
    }

    
    func backToMenu(action: UIAlertAction! = nil) {
        //Send info back
        //Send info back
        //sendBack?.setSentData(num: num, highScore: highScore, completed: completed)
        navigationController!.pushViewController(storyboard!.instantiateViewController(withIdentifier: "Menu") as UIViewController, animated: true)

    }
    
    @IBAction func answerTapped(_ sender: UIButton) {
        
        resetTimerLabel()

        //If the title on the button tapped is the same as the correctAnswer
        if sender.tag == correctAnswer {
            numCorrect += 1
        }
        
        numAnswered += 1
        //If have have answered enough questions (CHANGED FOR DEBUG)
        
        askQuestion()
    }

}
