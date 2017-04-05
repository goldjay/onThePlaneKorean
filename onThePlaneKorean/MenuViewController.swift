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
    @IBOutlet weak var level1: UIButton!
    @IBOutlet weak var level2: UIButton!
    @IBOutlet weak var level3: UIButton!
    @IBOutlet weak var level4: UIButton!
    @IBOutlet weak var practiceQuiz: UIButton!
    @IBOutlet weak var phraseBook: UIButton!
    
    @IBOutlet weak var level1ButtonWidth: NSLayoutConstraint! //Set individually?
    @IBOutlet weak var level2ButtonWidth: NSLayoutConstraint!
    @IBOutlet weak var level3ButtonWidth: NSLayoutConstraint!
    @IBOutlet weak var level4ButtonWidth: NSLayoutConstraint!
    @IBOutlet weak var level5ButtonWidth: NSLayoutConstraint!
    
    var decks = [NSManagedObject?]() // TO DO: Remove
    
    // GET WIDTH OF CONTAINER AND SUBTRACT 32 TO GET WIDTH OF MENU BUTTONS AND BORDER
    
    
    func addTopBorder(btn: UIButton, color: UIColor){
        let lineView = UIView(frame: CGRect(x: 0,y: 0,width: 343,height: 5)) //Magic number FIX
        lineView.backgroundColor = color
        btn.addSubview(lineView)
    }
    
    //Get data from Coredata
    override func viewWillAppear(_ animated: Bool) {
        
        let button = UIButton.init(type: .custom)
        //set image for button
        button.setImage(UIImage(named: "gear.png"), for: UIControlState.normal)
        //add function for button
        button.addTarget(self, action: #selector(toMenu), for: UIControlEvents.touchUpInside)
        //set frame
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        
        let barButton = UIBarButtonItem(customView: button)
        //assign button to navigationbar
        self.navigationItem.rightBarButtonItem = barButton
        
        addTopBorder(btn: level1, color: UIColor.customYellow)
        addTopBorder(btn: level2, color: UIColor.customRed)
        addTopBorder(btn: level3, color: UIColor.customBlue)
        addTopBorder(btn: level4, color: UIColor.customGreen)
        
        navigationController?.navigationBar.barTintColor = UIColor.customLightBlue
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        //Managed object context
        let managedContext = appDelegate.persistentContainer.viewContext
 
        //DeleteAllData() //Clears core data for debug
 
        //Fetch from Core Data
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "DeckData")
        
        do {
            decks = try managedContext.fetch(fetchRequest)
            print("Loading data")
            print(decks)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        // Save number of times the app has been opened
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let times = delegate.currentTimesOfOpenApp
        
        print("You opened this app \(times) times")
        
        // If it's the first time opening the app, go to special intro about Hangul
        if(times <= 1){
            if let vc = storyboard?.instantiateViewController(withIdentifier: "Explanation") as? ExplanationController {
                
                navigationController?.pushViewController(vc, animated: true)
            }
        }
        
    }

    @IBAction func levelSelected(_ sender: UIButton) {
        
        var selectedConstraint: NSLayoutConstraint! //Not a very good solution
        
        //Set constraint to be altered (width of menu button)
        switch(sender.tag){
        case 1:
            selectedConstraint = level1ButtonWidth
            break
        case 2:
            selectedConstraint = level2ButtonWidth
            break
        case 3:
            selectedConstraint = level3ButtonWidth
            break
        case 4:
            selectedConstraint = level4ButtonWidth
            break
        case 5:
            selectedConstraint = level5ButtonWidth
            break
        default:
            break
        }
        
        let num = sender.tag
        
        //Move button to the side
        UIView.animate(withDuration: 0.5, delay: 0, options: UIViewAnimationOptions.curveEaseIn, animations: {
        
            self.view.layoutIfNeeded() //Update constraints
            
            
            var offset = 0;
            
            let btn : CGRect = sender.frame
            
            let originXbutton = btn.origin.x
            let originYbutton = btn.origin.y
            
            let originWidthbutton = btn.size.width
            let originHeightbutton = btn.size.height
            
            
            if originWidthbutton > 200 {
                offset = -300
                //sender.frame = frmPlay
                sender.setTitle("\(num)", for: .normal)
            }else{
                offset = 300
                sender.setTitle("LEVEL \(num) ", for: .normal)
            }
            
            sender.frame = CGRect(x: originXbutton, y: originYbutton, width: originWidthbutton+CGFloat(offset), height: originHeightbutton)
            
            selectedConstraint.constant = originWidthbutton + CGFloat(offset)
            self.view.layoutIfNeeded() //Update constraints
            
            }, completion: nil)
    }
    
    
    
    
    //Do something with the data returned
    func setSentData(highScore: Double){
        
        print("YOU GOT THIS SCORE!")
        print(highScore)
        
        //save to core data
        self.save(highScore: highScore)
    }
 
    
    //Saves to core data
    func save(highScore: Double){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            print("COULD NOT SAVE")
            return
        }
        
        //In memory 'scratchpad' for managed objects
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Create a new managed object and insert it into managed object context
        
        print("THIS MANY DECKS: ")
        print(decks.count)
        
        if decks.count == 0 {
            print("FIRST DECK CREATED")
            //Create a new managed object and set its high score
            let entity = NSEntityDescription.entity(forEntityName: "DeckData", in: managedContext)!
            let deck = NSManagedObject(entity: entity, insertInto: managedContext)
            deck.setValue(highScore, forKeyPath: "highScore")
        } else{
            //Otherwise update the managed object
            let currHigh = decks[0]?.value(forKey: "highScore") as! Double
            
            print("CURRENT HIGH: ")
            print(currHigh)
            
            if(currHigh < highScore){
                print("UPDATING THE HIGH SCORE to \(highScore)")
                //Change the highscore
                decks[0]?.setValue(highScore, forKey: "highScore")
            }
        }
        
        //Commit changes and save to disk
        do {
            try managedContext.save()
            //decks.append(deck)
            print("SAVED!")
        } catch let error as NSError {
            print("Could not save. \(error.userInfo)")
        }
    }
    
    func goToNextView(viewName: String, num: Int){
           }
    
    @IBAction func selectTutorial(_ sender: UIButton) {
        currentDeck = [] //Clear deck from previous selection
        
        num = sender.tag
        
        //Get lesson deck
        if let lessonFilePath = Bundle.main.path(forResource: "lesson\(num)", ofType: "txt"){
            if let lessonContents = try? String(contentsOfFile: lessonFilePath) {
                let lines = lessonContents.components(separatedBy: CharacterSet.newlines).filter{ !$0.isEmpty}
                
                for line in lines {
                    //append to an array for lesson
                    lessonDeck.append(line)
                }
            }
        }
        
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
            
            if let vc = storyboard?.instantiateViewController(withIdentifier: "Lesson") as? LessonViewController {
                
                navigationController?.pushViewController(vc, animated: true)
            }
 
        }
    }
    
    @IBAction func selectQuiz(_ sender: UIButton) {
        currentDeck = [] //Clear deck from previous selection
        
        num = sender.tag
        print( "NUM IS: \(num)")
        
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
            
            if let vc = storyboard?.instantiateViewController(withIdentifier: "Question") as? QuestionViewController {
        
                vc.sendBack = self
                
                navigationController?.pushViewController(vc, animated: true)
            }
        }

      
    }
    
    @IBAction func commonWordsList(_ sender: UIButton) {
        if let levelFilePath = Bundle.main.path(forResource: "commonWords", ofType: "txt") {
            
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
            
            if let vc = storyboard?.instantiateViewController(withIdentifier: "ExpandingViewController") as? ExpandingTableViewController {
                
                vc.deck = currentDeck
                
                navigationController?.pushViewController(vc, animated: true)
            }
        }
        
    }
    
    func toMenu(){
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Options") as? OptionsViewController {
            
            navigationController?.pushViewController(vc, animated: true)
        }

    }
    
    
    
    //DEBUG FOR DELETE CORE DATA
    func DeleteAllData(){
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let DelAllReqVar = NSBatchDeleteRequest(fetchRequest: NSFetchRequest<NSFetchRequestResult>(entityName: "DeckData"))
        do {
            try managedContext.execute(DelAllReqVar)
        }
        catch {
            print(error)
        }
    }
    
}
