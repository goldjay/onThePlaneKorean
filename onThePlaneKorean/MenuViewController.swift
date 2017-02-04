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
    
    var decks = [NSManagedObject?]()
    
    //isCompleted
    //highScore
    
    override func viewDidLoad() {
        super.viewDidLoad()
/*
        //Try to load from Core Data
        if(decks.count == 0){
            //Otherwise create objects for all of the level' data
            for _ in 0 ..< numLevels {
                let a = deckData()
                userData.append(a)
            }
        }
 */
    }
    
    //Get data from Coredata
    override func viewWillAppear(_ animated: Bool) {
      
        
        /*
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        //Managed object context
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Fetch from Core Data
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "DeckData")
        
        do {
            decks = try managedContext.fetch(fetchRequest)
            print("Loading data")
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        print(decks)
 
        */
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func levelSelected(_ sender: UIButton) {
        
        let num = sender.tag
        
        //Move button to the side
        UIView.animate(withDuration: 1.0, delay: 0, options: UIViewAnimationOptions.curveEaseIn, animations: {
        
            var offset = 0;
            
            let frmPlay : CGRect = sender.frame
            
            let originXbutton = frmPlay.origin.x
            let originYbutton = frmPlay.origin.y
            
            let originWidthbutton = frmPlay.size.width
            let originHeightbutton = frmPlay.size.height
            
            if originWidthbutton > 200 {
                offset = -300
                //sender.frame = frmPlay
                sender.setTitle("\(num)", for: .normal)
            }else{
                offset = 300
                sender.setTitle("LEVEL \(num) ", for: .normal)
            }
            
            sender.frame = CGRect(x: originXbutton, y: originYbutton, width: originWidthbutton+CGFloat(offset), height: originHeightbutton)
            
            }, completion: nil)
    }
    
    
    
    
    //Do something with the data returned
    func setSentData(num: Int,highScore: Double, completed: Bool){
        
        print("YOU GOT THIS SCORE!")
        print(highScore)
        print("AND COMPLETED")
        print(completed)
        print("AND NUM:")
        print(num)
        
        //save to core data
        self.save(num: num, highScore: highScore, completed: completed)
    }
 
    
    //Saves to core data
    func save(num: Int, highScore: Double, completed: Bool){
        
        print("TRYING TO SAVE!")
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            print("COULD NOT")
            return
        }
        
        //In memory 'scratchpad' for managed objects
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Create a new managed object and insert it into managed object context
        let entity = NSEntityDescription.entity(forEntityName: "DeckData", in: managedContext)!
        
        let deck = NSManagedObject(entity: entity, insertInto: managedContext)
        
        //Set value of managed object
        deck.setValue(num, forKeyPath: "num")
        deck.setValue(highScore, forKeyPath: "highScore")
        deck.setValue(completed, forKey: "completed")
        
        
        //Commit changes to person and save to disk
        do {
            try managedContext.save()
            decks.append(deck)
            print("SAVED!")
        } catch let error as NSError {
            print("Could not save. \(error.userInfo)")
        }
    }
    
    func goToNextView(viewName: String, num: Int){
           }
    
    @IBAction func selectTutorial(_ sender: UIButton) {
        currentDeck = [] //Clear deck from previous selection
        
        let num = sender.tag
        
        if let levelFilePath = Bundle.main.path(forResource: "level\(num)", ofType: "txt") {
            
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
            
            print(currentDeck)
            
            if let vc = storyboard?.instantiateViewController(withIdentifier: "Tutorial") as? TutorialViewController {
                
                vc.deck = currentDeck
                vc.num = num
                //vc.sendBack = self
                
                navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    
    @IBAction func selectQuiz(_ sender: UIButton) {
        currentDeck = [] //Clear deck from previous selection
        
        let num = sender.tag
        
        if let levelFilePath = Bundle.main.path(forResource: "level\(num)", ofType: "txt") {
            
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
            
            print(currentDeck)
            
            if let vc = storyboard?.instantiateViewController(withIdentifier: "Question") as? QuestionViewController {
                
                vc.deck = currentDeck
                vc.num = num
                vc.sendBack = self
                
                navigationController?.pushViewController(vc, animated: true)
            }
        }

      
    }
    
/*
    // MARK: Delete Data Records
    
    func deleteRecords() -> Void {
        let moc = getContext()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        
        let result = try? moc.fetch(fetchRequest)
        let resultData = result as! [AnyObject?]
        
        for object in resultData {
            moc.delete(object as! NSManagedObject)
        }
        
        do {
            try moc.save()
            print("saved!")
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        } catch {
            
        }
        
    }
     
    
    // MARK: Get Context
    
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
*/


}
