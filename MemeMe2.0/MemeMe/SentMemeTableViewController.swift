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
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationItem.leftBarButtonItem = editButtonItem()
//        enableEdit(memes.count)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        enableEdit(memes.count)
    }
    
    override func viewDidAppear(animated: Bool) {
        tableView.reloadData()
    }
    
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: animated)
    }
    
    func enableEdit(memesCount: Int) {
        if memesCount == 0 {
            if navigationItem.leftBarButtonItem?.title == "Done" {
                navigationItem.leftBarButtonItem?.enabled = true
            } else {
                navigationItem.leftBarButtonItem?.enabled = false
            }
        }
        else{
            navigationItem.leftBarButtonItem = editButtonItem()
            navigationItem.leftBarButtonItem?.enabled = true
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("MemeImageCell") as! CustomTableCell
        cell.MemeImageCell.autoresizesSubviews = false
        cell.MemeImageCell.autoresizingMask = .None
        cell.MemeImageCell.image = self.memes[indexPath.row].image
        cell.MemeLabel.text = self.memes[indexPath.row].topText! + " " + self.memes[indexPath.row].bottomText!
        cell.topText.text = self.memes[indexPath.row].topText!
        cell.bottomText.text = self.memes[indexPath.row].bottomText!
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //Grab an instance of the DetailViewController from the storyboard
        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeDetailTableViewController") as! MemeDetailTableViewController
        
        //Populate view controller with data according to the selected cell
        detailController.meme = self.memes[indexPath.row]
        //Present the view controller using navigation
        self.navigationController?.pushViewController(detailController, animated: true)
//
    }
    
    // Override to support conditional editing of the table view.
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            (UIApplication.sharedApplication().delegate as!AppDelegate).memes.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            }
        
    }
    
    
}
