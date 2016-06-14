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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        MemeImageCell.frame = CGRectMake(8, 0, 137, 90)
        MemeLabel.frame.origin.x = 153
    }

    
    
}


