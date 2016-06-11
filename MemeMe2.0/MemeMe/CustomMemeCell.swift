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
    var TopText: String!
    var BottomText: String!
    
    func setText(top: String, bottom: String) {
        TopText = top
        BottomText = bottom
        
    }
    
    
    
    
}


