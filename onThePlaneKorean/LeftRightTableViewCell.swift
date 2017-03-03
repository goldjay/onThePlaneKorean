//
//  LeftRightTableViewCell.swift
//  onThePlaneKorean
//
//  Created by Jay Steingold on 3/2/17.
//  Copyright © 2017 Goldjay. All rights reserved.
//

import UIKit

class LeftRightTableViewCellContent {
    var left: String?
    var right: String?

    init(left: String, right: String){
        self.left = left
        self.right = right
    }
}
class LeftRightTableViewCell: UITableViewCell {
        
    @IBOutlet var rightLabel: UILabel!
    @IBOutlet var leftLabel: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
        
    func setLR(content: LeftRightTableViewCellContent){
        self.leftLabel.text = content.left //
        self.rightLabel.text = content.right
    }
}


