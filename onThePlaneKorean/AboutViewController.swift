//
//  AboutViewController.swift
//  onThePlaneKorean
//
//  Created by Jay Steingold on 4/1/17.
//  Copyright © 2017 Goldjay. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var mainLabel: UILabel!
    
    // Add an array of images and text to be loaded
    let imageArr = ["Artboard 2.png", "Artboard 4.png", "Artboard 3.png", "Artboard 5.png", "Artboard 1.png"];
    let textArr = ["Hello! Whether you are travelling to Korea, binging on dramas, listening to Kpop or just learning for fun, learning to read Korean is an excellent choice and I'm so happy you decided to start your journey with me.", "A long time ago Korean writing was very different. It was called \"Hanja\" and it was very similar to chinese characters we see today. While Hanja is still taught in Korean schools, it's not used much in everyday life.", "King Sejeong of the Joseon Dynasty called for the invention of Hangul because only wealthy people had the time and money to learn how to write. ", "Hangul was designed to be legible and easy to remember. To master the basics you only need a couple of hours- so simple you could learn it on the plane ride over.", "After you can confidently recognize all of the characters, spend some time listening to people speak Korean. While it is a phonetic writing system, characters often blend together in speach. Now get out there and put all this learning to good use!"]
    
    var numSlide = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // display image and text
        setAssets()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func swipeLeft(_ sender: AnyObject) {
        // bounds checking
        if(numSlide < imageArr.count - 1){
            numSlide += 1
            setAssets()
        }
    }

    
    @IBAction func swipeRight(_ sender: AnyObject) {
        
        if(numSlide >= 0){
            numSlide -= 1
            setAssets()
        }
    }
    
    func setAssets(){
        mainImage.image = UIImage(named : imageArr[numSlide])
        mainLabel.text = textArr[numSlide]
    }

}
