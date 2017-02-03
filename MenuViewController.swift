//
//  MenuViewController.swift
//  onThePlaneKorean
//
//  Created by Jay Steingold on 1/30/17.
//  Copyright © 2017 Goldjay. All rights reserved.
//

import UIKit
import CoreData

class MenuViewController: UIViewController, sendBack {
    
    var currentDeck: [[String]] = []
    var numLevels = 6
    
    //Load info from Core Data
    //var savedDecks = [deckData]()
    
    var deckFromData = [NSManagedObject?]()
    
    //isCompleted
    //highScore
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Try to load from Core Data
        if(deckFromData.count == 0){
            //Otherwise create objects for all of the level' data
            for _ in 0 ..< numLevels {
                var a = deckData()
                userData.append(a)
            }
        }
        
    }
    
    //Get data from Coredata
    override func viewWillAppear(_ animated: Bool) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        //Managed object context
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Fetch from Core Data
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "DeckData")
        
        do {
            deckFromData = try managedContext.fetch(fetchRequest)
            print("Loading data")
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        print(deckFromData)
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
        
         //DEBUG
        //Check if the deck has not been completed
        if(userData[numLevel].completed == false){
            //Present the tutorial for the course
            if let vc = storyboard?.instantiateViewController(withIdentifier: "Tutorial") as? TutorialViewController {
                vc.deck = currentDeck
                vc.num = numLevel
                navigationController?.pushViewController(vc, animated: true)
            }

        } 
 
        else {
            if let vc = storyboard?.instantiateViewController(withIdentifier: "Question") as? QuestionViewController {
                
                vc.deck = currentDeck
                vc.num = numLevel
                vc.sendBack = self
                
                navigationController?.pushViewController(vc, animated: true)
            }
            
        }
        print(currentDeck)
        print("\n\n\n")
    }
    
    //Do something with the data returned
    func setSentData(highScore: Double, completed: Bool){
        
        print("YOU GOT THIS SCORE!")
        print(highScore)
        print("AND COMPLETED")
        print(completed)
    }


}
