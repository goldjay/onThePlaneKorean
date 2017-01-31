//
//  MenuViewController.swift
//  onThePlaneKorean
//
//  Created by Jay Steingold on 1/30/17.
//  Copyright © 2017 Goldjay. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    var currentDeck: [[String]] = []
    
    //Load info from Core Data
    var savedDecks = [deckData?](repeating: nil, count:6)
    
    
    //isCompleted
    //highScore
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        print(savedDecks)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func levelSelected(_ sender: UIButton) {
        
        currentDeck = [] //Clear deck from previous selection
        
        let numLevel = sender.tag
        
        //Prep the proper deck
        //Find and load level string from the disk
        if let levelFilePath = Bundle.main.path(forResource: "level\(numLevel)", ofType: "txt") {
            
            if let levelContents = try? String(contentsOfFile: levelFilePath) {
                //Split Q and A's by linebreak
                let lines = levelContents.components(separatedBy: CharacterSet.newlines)
                    .filter{ !$0.isEmpty }
                
                for line in lines{
                    //Splits each line into answer and clue
                    let parts = line.components(separatedBy: ":")
                    
                    let card = [parts[0],parts[1], parts[2]]
                    currentDeck.append(card)
                }
            }
        }
        
        
        //Check if the deck has not been completed
        if(savedDecks[numLevel] == nil || savedDecks[numLevel]?.completed == false){
            //Present the tutorial for the course
            if let vc = storyboard?.instantiateViewController(withIdentifier: "Tutorial") as? TutorialViewController {
                vc.deck = currentDeck
                vc.num = numLevel
                
                navigationController?.pushViewController(vc, animated: true)
            }

        } else {
            if let vc = storyboard?.instantiateViewController(withIdentifier: "Question") as? QuestionViewController {
                
                vc.deck = currentDeck
                vc.num = numLevel
                
                navigationController?.pushViewController(vc, animated: true)
            }
            
        }
        
        
        
        
        
        print(currentDeck)
        print("\n\n\n")
    }
    

}
