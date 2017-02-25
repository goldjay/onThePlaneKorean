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
    func setSentData(highScore: Double)
}


class QuestionViewController: UIViewController {
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var quizNumLabel: UILabel!
    
    //From menu view
    var num: Int = 0
    var deck: [[String]] = []
    var sendBack: sendBack?
    
    //Data from the quiz
    var correctAnswer: Int = 0
    var numAnswered: Int = 0
    var numCorrect: Int = 0
    var message = ""
    
    //For saving data
    //var completed: Bool = false
    var highScore: Double = 0
    
    //For the timer
    var timer = Timer()
    var originalWidth: CGFloat = 0
    var decrementAmt: CGFloat = 0
    var numSecs: CGFloat = 30
    var count: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setButtonAndBackground()
 
 
        originalWidth = timerLabel.frame.width
        decrementAmt = originalWidth / numSecs
        
        quizNumLabel.text = "QUIZ LEVEL \(num)"
        
        askQuestion()
    }
    
    func setButtonAndBackground() {
        if num == 1 {
            self.view.backgroundColor = UIColor.customYellow
            button1.setTitleColor(UIColor.customYellow, for: .normal)
            button2.setTitleColor(UIColor.customYellow, for: .normal)
            button3.setTitleColor(UIColor.customYellow, for: .normal)
            navigationController?.navigationBar.barTintColor = UIColor.customYellow
        } else if num == 2{
            self.view.backgroundColor = UIColor.customRed
            button1.setTitleColor(UIColor.customRed, for: .normal)
            button2.setTitleColor(UIColor.customRed, for: .normal)
            button3.setTitleColor(UIColor.customRed, for: .normal)
            navigationController?.navigationBar.barTintColor = UIColor.customRed
        } else if num == 3 {
            self.view.backgroundColor = UIColor.customBlue
            button1.setTitleColor(UIColor.customBlue, for: .normal)
            button2.setTitleColor(UIColor.customBlue, for: .normal)
            button3.setTitleColor(UIColor.customBlue, for: .normal)
            navigationController?.navigationBar.barTintColor = UIColor.customBlue
        }else {
            self.view.backgroundColor = UIColor.customGreen
            button1.setTitleColor(UIColor.customGreen, for: .normal)
            button2.setTitleColor(UIColor.customGreen, for: .normal)
            button3.setTitleColor(UIColor.customGreen, for: .normal)
            navigationController?.navigationBar.barTintColor = UIColor.customGreen
        }
    }

    func askQuestion(action: UIAlertAction! = nil) {
        
        if(!checkIfFinished()){
            //TO DO:Possibly change shuffle to happen after user reaches end of deck
            let shuffledDeck = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: deck) as! [[String]]
            
            //Choose a random answer
            correctAnswer = Int(arc4random_uniform(3) + 1)
            
            //Choose if question is in Korean or english
            let language = Int(arc4random_uniform(2))
            if language == 1{
                button1.setTitle(shuffledDeck[1][0], for: UIControlState.normal)
                button2.setTitle(shuffledDeck[2][0], for: UIControlState.normal)
                button3.setTitle(shuffledDeck[3][0], for: UIControlState.normal)
                questionLabel.text = shuffledDeck[correctAnswer][1]
            }else{
                button1.setTitle(shuffledDeck[1][1], for: UIControlState.normal)
                button2.setTitle(shuffledDeck[2][1], for: UIControlState.normal)
                button3.setTitle(shuffledDeck[3][1], for: UIControlState.normal)
                questionLabel.text = shuffledDeck[correctAnswer][0]
            }
            
            
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(QuestionViewController.setTimerLabel), userInfo: nil, repeats: true)
        }
    }
    
    func checkIfFinished() -> Bool{
        if numAnswered == (deck.count * 2) { //TO DO: CHANGE TO BE RELATIVE TO DECK SIZE
            
            timer.invalidate()
            print(Double(numCorrect/numAnswered))
            
            //If you did well enough, you can move to the next level
            if Double(numCorrect) / Double(numAnswered) >= 0.9 {
                
                //Maybe change this to a percentage if add # of cards
                highScore =  (Double(numCorrect / numAnswered)) * 100
                
                message = "You have answered \(numCorrect) out of \(numAnswered) questions correct. You can move on to the next section if you like."
            }
            else{
                //Message about trying harder
                message = "You have answered \(numCorrect) out of \(numAnswered) questions correct. I think you could use more practice."
            }
            
            print("You got this many right: \(numCorrect)\n")
            print("And you answered this many: \(numAnswered)\n")
            
            //Send info back
            sendBack?.setSentData(highScore: highScore)
            
            //Reset stats
            numAnswered = 0
            numCorrect = 0
            
            
            //TO DO: Possible transition to view with stats/words missed
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
        sendBack?.setSentData(highScore: highScore)
        navigationController!.pushViewController(storyboard!.instantiateViewController(withIdentifier: "Menu") as UIViewController, animated: true)

    }
    
    @IBAction func answerTapped(_ sender: UIButton) {
        //Change color of correct button
        if let button = self.view.viewWithTag(correctAnswer) as? UIButton{
            
            button.backgroundColor = UIColor.blue
            
            UIView.animate(withDuration: 0.2, animations: {
                button.backgroundColor = UIColor.white
            }, completion: nil)
            
        }
        
        resetTimerLabel()

        //If the title on the button tapped is the same as the correctAnswer
        if sender.tag == correctAnswer {
            numCorrect += 1
        }
        
        numAnswered += 1
        
        askQuestion()
    }

}
