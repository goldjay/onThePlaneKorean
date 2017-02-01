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
    
    var num: Int = 0
    var deck: [[String]] = []
    
    var pos = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        presentData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func swipeRight(_ sender: AnyObject) {
        //Check if we are out of bounds
        if(pos + 1 == deck.count){
            //Go to the quiz
            if let vc = storyboard?.instantiateViewController(withIdentifier: "Question") as? QuestionViewController {
                vc.num = num
                vc.deck = deck
                navigationController?.pushViewController(vc, animated: true)
            }
        }else{
            pos += 1
            presentData()
        }
        
    }
    @IBAction func swipeLeft(_ sender: AnyObject) {
        //Check 
        if(pos > 0){
            pos -= 1
            presentData()
        }
    }
    
    func presentData() {
        letterLabel.text = deck[pos][0]
        romanizationLabel.text = deck[pos][1]
        soundLabel.text = deck[pos][2]
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
