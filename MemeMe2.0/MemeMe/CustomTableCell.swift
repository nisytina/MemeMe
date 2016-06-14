//
//  CustomTableCell.swift
//  MemeMe
//
//  Created by Tina Ni on 12/6/2016.
//  Copyright © 2016 TinaNi. All rights reserved.
//

import UIKit

class CustomTableCell: UITableViewCell {
    
    @IBOutlet weak var MemeImageCell: UIImageView!
    @IBOutlet var MemeLabel :UILabel!
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var bottomText: UITextField!
    override func layoutSubviews() {
        super.layoutSubviews()
        MemeImageCell.frame = CGRectMake(8, 0, 137, 90)
        MemeLabel.frame.origin.x = 153
        let memeTextAttributes = [
            NSStrokeColorAttributeName : UIColor.blackColor(),
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 12)!,
            NSStrokeWidthAttributeName : NSNumber.init(float: -3.0)
        ]
        topText.defaultTextAttributes = memeTextAttributes
        bottomText.defaultTextAttributes = memeTextAttributes
        
        topText.textAlignment = NSTextAlignment.Center
        bottomText.textAlignment = NSTextAlignment.Center
    }
}


