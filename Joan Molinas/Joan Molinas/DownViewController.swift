//
//  DownViewController.swift
//  Joan Molinas
//
//  Created by Joan Molinas on 14/4/15.
//  Copyright (c) 2015 Joan. All rights reserved.
//

import UIKit

class DownViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    
    @IBOutlet weak var arrow: UIButton!
    var images = ["Systems", "Java", "Crossplatform", "Apple", "Robocode", "plus"]
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var swipeGestureRecognizer: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "showFirstViewController")
        swipeGestureRecognizer.direction = UISwipeGestureRecognizerDirection.Down
        view.addGestureRecognizer(swipeGestureRecognizer)
        
        view.backgroundColor = UIColor(patternImage: UIImage(named: "school")!)
        
    }
    func showFirstViewController() {
        self.performSegueWithIdentifier("idDownUnwind", sender: self)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animateWithDuration(0.5, delay: 0.4, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.arrow.alpha = 1
        }, completion: nil)
       
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.arrow.alpha = 0
    }
    //MARK: CollectionView Datasource and Delegate
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as!BottomCollectionViewCell
        cell.image.image = UIImage(named:images[indexPath.row])
        return cell
    }
    //MARK: CollectionView Flow
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(327, 254)
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 30
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(60, 10, 0, 10)
    }
    
    @IBAction func back(sender: AnyObject) {
        self.performSegueWithIdentifier("idDownUnwind", sender: self)
    }
    
}
