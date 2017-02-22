//
//  customColors.swift
//  onThePlaneKorean
//
//  Created by Jay Steingold on 2/14/17.
//  Copyright © 2017 Goldjay. All rights reserved.
//

import UIKit

extension UIColor {
    
    class var customBlue: UIColor {
        let cornflowerBlue = 0x54ACD2
        return UIColor.rgb(fromHex: cornflowerBlue)
    }
    
    class var customRed: UIColor {
        let terracottaRed = 0xEB6B56
        return UIColor.rgb(fromHex: terracottaRed)
    }
    
    class var customGreen: UIColor {
        let fernGreen = 0x61BD6D
        return UIColor.rgb(fromHex: fernGreen)
    }
    
    class var customYellow: UIColor {
        let turboYellow = 0xFAC51C
        return UIColor.rgb(fromHex: turboYellow)
    }
    
    //Convert to rgb UIColor from Hex code
    class func rgb(fromHex: Int) -> UIColor {
        
        let red =   CGFloat((fromHex & 0xFF0000) >> 16) / 0xFF
        let green = CGFloat((fromHex & 0x00FF00) >> 8) / 0xFF
        let blue =  CGFloat(fromHex & 0x0000FF) / 0xFF
        let alpha = CGFloat(1.0)
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}
