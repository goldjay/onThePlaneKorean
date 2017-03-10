//
//  OptionsViewController.swift
//  onThePlaneKorean
//
//  Created by Jay Steingold on 3/4/17.
//  Copyright © 2017 Goldjay. All rights reserved.
//

import UIKit

class OptionsViewController: UIViewController {
    @IBOutlet weak var speed1: UIButton!
    @IBOutlet weak var speed2: UIButton!
    @IBOutlet weak var speed3: UIButton!
    
    @IBOutlet weak var mode1: UIButton!
    @IBOutlet weak var mode2: UIButton!
    @IBOutlet weak var mode3: UIButton!
    
    var speedArr: [UIButton] = []
    var modeArr: [UIButton] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        speedArr = [speed1, speed2, speed3]
        modeArr = [mode1, mode2, mode3]
        
        // Do any additional setup after loading the view.
    }

    @IBAction func changeSpeed(_ sender: UIButton) {
        switch(sender.tag){
        case 1:
            speed = 20
            break
        case 2:
            speed = 30
            break
        case 3:
            speed = 40
            break
        default:
            return
        }
        
        for m in speedArr {
            if(m == sender){
                m.backgroundColor = UIColor.customGreen
            }else{
                m.backgroundColor = UIColor.white
            }
        }
    }
    
    @IBAction func changeMode(_ sender: UIButton) {
        switch(sender.tag){
        case 1:
            mode = "normal"
            break
        case 2:
            mode = "sudden death"
            break
        case 3:
            mode = "mystery"
            break
        default:
            return
        }
            print("Mode is: \(mode)")
        
        for m in modeArr {
            if(m == sender){
                m.backgroundColor = UIColor.customGreen
            }else{
                m.backgroundColor = UIColor.white
            }
        }
        
    }
    //If the text of the button doesn't match the mode, unhighlight it
    
    
    
}
