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
    
    // Highlight color for the menus
    var selectedColor: UIColor = UIColor.white
    override func viewDidLoad() {
        super.viewDidLoad()

        speedArr = [speed1, speed2, speed3]
        modeArr = [mode1, mode2, mode3]
        
        for btn in speedArr {
            styleButton(btn: btn)
        }
        
        for btn in modeArr {
            styleButton(btn: btn)
        }
        
        //Set the selected mode and speed
        
    }

    @IBAction func changeSpeed(_ sender: UIButton) {
        speed = CGFloat(sender.tag)
        
        for m in speedArr {
            if(m == sender){
                m.alpha = 1
            }else{
                m.alpha = 0.5
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
            m.backgroundColor = UIColor.white
            m.setTitleColor(UIColor .customLightBlue, for: UIControlState.normal)
            
            if(m == sender){
                m.alpha = 1
            }else{
                m.alpha = 0.5
            }
        }
        
    }
    //If the text of the button doesn't match the mode, unhighlight it
    func styleButton(btn: UIButton){
        btn.layer.cornerRadius = 5
        
        
        if(CGFloat(btn.tag) != speed && btn.titleLabel?.text != mode ){
            btn.alpha = 0.5
        }

    }
    
    
}
