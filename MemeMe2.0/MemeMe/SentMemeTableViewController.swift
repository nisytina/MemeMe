//
//  SentMemeTableViewController.swift
//  MemeMe
//
//  Created by Tina Ni on 10/6/2016.
//  Copyright © 2016 TinaNi. All rights reserved.
//

import Foundation
import UIKit

class SentMemeTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var memes: [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidAppear(animated: Bool) {
        tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("MemeImageCell")!
        cell.imageView?.image = self.memes[indexPath.row].memedimage
        cell.textLabel?.text = self.memes[indexPath.row].topText! + " " + self.memes[indexPath.row].bottomText!
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        
        //Grab an instance of the DetailViewController from the storyboard
        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeDetailTableViewController") as! MemeDetailTableViewController
        
        //Populate view controller with data according to the selected cell
        detailController.meme = self.memes[indexPath.row]
        print(detailController.meme)
        
        //Present the view controller using navigation
        self.navigationController?.pushViewController(detailController, animated: true)
//
    }
    
    
}
