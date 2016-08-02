//
//  SentMemeCollectionViewController.swift
//  MemeMe
//
//  Created by Tina Ni on 10/6/2016.
//  Copyright © 2016 TinaNi. All rights reserved.
//

import Foundation
import UIKit

class SentMemeCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var memes: [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
     // MARK: FIXME
    override func viewDidLoad() {
       
        super.viewDidLoad()
        let frameSize = view.frame.size
        let space: CGFloat = 2.0
        let dimension: CGFloat!
        if min(frameSize.width, height: frameSize.height) == 1 {
            dimension = (frameSize.width - 2 * space) / 3.0
            print(frameSize.width)
            print(frameSize.height)
        } else {
            dimension = (frameSize.height - 2 * space) / 3.0
            print(frameSize.width)
            print(frameSize.height)
        }
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSizeMake(dimension, dimension)
    }
    
    override func viewDidAppear(animated: Bool) {
        
        collectionView.reloadData()
    }
    
    func min (width: CGFloat, height: CGFloat) -> Int {
        if width > height {
            return 0
        }
        else {
            return 1
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let meme = memes[indexPath.row]
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MemeImageCell", forIndexPath: indexPath) as! CustomMemeCell
        cell.image.image = meme.image
        cell.setText(meme.topText!, bottom: meme.bottomText!)
        return cell
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        //Grab an instance of the DetailViewController from the storyboard
        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeDetailTableViewController") as! MemeDetailTableViewController
        
        //Populate view controller with data according to the selected cell
        detailController.meme = self.memes[indexPath.row]
        
        //Present the view controller using navigation
        self.navigationController?.pushViewController(detailController, animated: true)
    }

    
}