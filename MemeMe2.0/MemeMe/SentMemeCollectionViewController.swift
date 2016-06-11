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
    
    override func viewDidAppear(animated: Bool) {
        
        collectionView.reloadData()
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let meme = memes[indexPath.row]
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MemeImageCell", forIndexPath: indexPath) as! CustomMemeCell
        
        cell.setText(meme.topText!, bottom: meme.bottomText!)
        cell.image.image = meme.memedimage
        return cell
        
    }
    
//    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
//        
//    }
//    
    
}