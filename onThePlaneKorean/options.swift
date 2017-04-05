//
//  options.swift
//  onThePlaneKorean
//
//  Created by Jay Steingold on 2/27/17.
//  Copyright © 2017 Goldjay. All rights reserved.
//

import Foundation
import UIKit

var speed: CGFloat = 60 //Set the game speed

//sudden death, mystery (answers disappear after flashing),

var mode: String = "normal" //Set the mode for time attack or marathon

var currentDeck: [[String]] = []
var num: Int = 0
var lessonDeck: [String] = []
var currentLesson: Int = 1
var numQuestions: Int = 20
