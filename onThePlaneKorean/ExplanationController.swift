//
//  ExplanationController.swift
//  onThePlaneKorean
//
//  Created by Jay Steingold on 3/14/17.
//  Copyright © 2017 Goldjay. All rights reserved.
//

import UIKit

class ExplanationController: UIViewController {

    @IBOutlet weak var blurb1: UILabel!
    @IBOutlet weak var explanationImage: UIImageView!
    @IBOutlet weak var blurb2: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadContent()
    }
    
    //Add swipe right and swipe left

    @IBAction func swipeRight(_ sender: AnyObject) {
        if(currentLesson - 3 >= 0){
            currentLesson -= 3
            
            //Present View Controller
            loadContent()
        }
    }
    
    @IBAction func swipeLeft(_ sender: AnyObject) {
        print("SWIPED LEFT")
        print(currentLesson)
        
        if(currentLesson + 3 < lessonDeck.count - 1){
            currentLesson += 3
            
            //Present View Controller
            loadContent()
        }
            //Otherwise, move to the tutorial
        else{
            if let vc = storyboard?.instantiateViewController(withIdentifier: "Tutorial") as? TutorialViewController {
                navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    func loadContent(){
        //Assign labels
        blurb1.text = lessonDeck[currentLesson]
        blurb2.text = lessonDeck[currentLesson + 1]
        
        //imageView.image = UIImage(named:"foo")
        explanationImage.image = UIImage(named :lessonDeck[currentLesson + 2])
    }
 

}
