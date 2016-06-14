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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem (
            title: "Edit",
            style: UIBarButtonItemStyle.Plain,
            target: self,
            action: #selector(MemeDetailTableViewController.editMeme))
        self.tabBarController?.tabBar.hidden = true
    }
    
    func editMeme() {
        
        var controller: MemeMeViewController
        
        controller = self.storyboard?.instantiateViewControllerWithIdentifier("MemeMeViewController") as! MemeMeViewController
        
        controller.editFromViews = true
        controller.topText = meme.topText
        controller.bottomText = meme.bottomText
        controller.image = meme.image
        self.presentViewController(controller, animated: true, completion: nil)
                
    
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.imageView!.image = meme.memedimage
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.hidden = false

    }
    
}
