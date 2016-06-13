//
//  CustomMemeCell.swift
//  MemeMe
//
//  Created by Tina Ni on 10/6/2016.
//  Copyright © 2016 TinaNi. All rights reserved.
//

import UIKit

class CustomMemeCell: UICollectionViewCell {
    
    var memedImage: Meme!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var bottomText: UITextField!
    
    func setText(top: String, bottom: String) {
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
        topText.text = top
        bottomText.text = bottom
        
    }
    
    
    
    
}


