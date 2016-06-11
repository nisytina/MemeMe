//
//  MemeDetailTableViewController.swift
//  MemeMe
//
//  Created by Tina Ni on 11/6/2016.
//  Copyright © 2016 TinaNi. All rights reserved.
//

import Foundation
import UIKit

class MemeDetailTableViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var meme: Meme!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.imageView!.image = meme.memedimage
    }
    
    
}
