//
//  ViewController.swift
//  Joan Molinas
//
//  Created by Joan Molinas on 14/4/15.
//  Copyright (c) 2015 Joan. All rights reserved.
//

import UIKit

let reuseIdentifier = "centerCell"


class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var arrowRight: UIButton!
    @IBOutlet weak var arrowBottom: UIButton!
    @IBOutlet weak var arrowLeft: UIButton!
    @IBOutlet weak var arrowTop: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let sectionInsets = UIEdgeInsetsMake(10, 10, 10, 10)
    let types : [Type] = [.Profile, .Description, .Map, .Beat]
    
    deinit{
        collectionView.delegate = nil
        collectionView.dataSource = nil
        collectionView = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* Notification brightness */
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "brightness", name: UIScreenBrightnessDidChangeNotification, object: nil)
        
        /* Status Bar */
        UIApplication.sharedApplication().statusBarHidden = true
        
        /* Check if camera is available*/
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            let v = JMBackgroundCameraView(frame: view.bounds, position: DevicePosition.Back, blur: UIBlurEffectStyle.Dark)
            view.insertSubview(v, atIndex: 0)
        }
        /* Arrows */
        arrowRight.imageView?.tintColor = UIColor.whiteColor()
        
        var layout = CenterCollectionLayout()
        collectionView.setCollectionViewLayout(CenterCollectionLayout(), animated: true)
        collectionView.alpha = 0.2
        
        /* Segues */
        let upGestureRecognizer: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "UPViewController")
        upGestureRecognizer.direction = UISwipeGestureRecognizerDirection.Down
        view.addGestureRecognizer(upGestureRecognizer)
        
        let rightGestureRecognizer: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "RightViewController")
        rightGestureRecognizer.direction = UISwipeGestureRecognizerDirection.Left
        view.addGestureRecognizer(rightGestureRecognizer)

        
        let downGestureRecognizer: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "DownViewController")
        downGestureRecognizer.direction = UISwipeGestureRecognizerDirection.Up
        view.addGestureRecognizer(downGestureRecognizer)
        
        let leftGestureRecognizer: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "LeftViewController")
        leftGestureRecognizer.direction = UISwipeGestureRecognizerDirection.Right
        view.addGestureRecognizer(leftGestureRecognizer)
        

    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        NSNotificationCenter.defaultCenter().postNotificationName("Show", object: self)
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.collectionView.alpha = 1
        })
        
        collectionView.setNeedsDisplay()
    }

    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        NSNotificationCenter.defaultCenter().postNotificationName("Hidden", object: self)
        var views = collectionView.subviews as Array

        var cell = collectionView.cellForItemAtIndexPath(NSIndexPath(forRow: 3, inSection: 0))
        cell?.contentView.removeFromSuperview()
        collectionView.setNeedsDisplay()
    }
    
 
    @IBAction func returnFromSegueAction(sender: UIStoryboardSegue){
        
    }
    
    //MARK: Set View Controllers
    func UPViewController() {
        self.performSegueWithIdentifier("idUpFirst", sender: self)
    }
    
    func RightViewController() {
        
        self.performSegueWithIdentifier("idRightFirst", sender: self)
    }
    
    func DownViewController() {
        self.performSegueWithIdentifier("idDownFirst", sender: self)
    }
    
    func LeftViewController() {
        self.performSegueWithIdentifier("idLeftFirst", sender: self)
    }

    
    override func segueForUnwindingToViewController(toViewController: UIViewController, fromViewController: UIViewController, identifier: String?) -> UIStoryboardSegue {
        switch identifier {
        case let x where x == "idUPUnwind":
            let unwindSegue = UPCustomSegueUnwind(identifier: x, source: fromViewController, destination: toViewController, performHandler: { () -> Void in
                
            })
            return unwindSegue
            
        case let x where x == "idRightUnwind":
            let unwindSegue = RightCustomSegueUnwind(identifier: x, source: fromViewController, destination: toViewController, performHandler: { () -> Void in
                
            })
        return unwindSegue
        
        case let x where x == "idDownUnwind":
            let unwindSegue = DownCustomSegueUnwind(identifier: x, source: fromViewController, destination: toViewController, performHandler: { () -> Void in
                
            })
            return unwindSegue
        case let x where x == "idLeftUnwind":
            let unwindSegue = LeftCustomSegueUnwind(identifier: x, source: fromViewController, destination: toViewController, performHandler: { () -> Void in
                
            })
            return unwindSegue

        default:
            break

        }
        return super.segueForUnwindingToViewController(toViewController, fromViewController: fromViewController, identifier: identifier)
    }
    
    //MARK: Collection View Delegate
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return types.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CenterCollectionViewCell
        cell.type = types[indexPath.row]
        return cell
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        //Animate map when map is visible completly
        if scrollView.contentOffset.y > 110 {
            var cell = collectionView.cellForItemAtIndexPath(NSIndexPath(forRow: 2, inSection: 0)) as! CenterCollectionViewCell

        }
    }
    //MARK: SEGUES
    
    @IBAction func right(sender: AnyObject) {
         self.performSegueWithIdentifier("idRightFirst", sender: self)
    }
    @IBAction func top(sender: AnyObject) {
         self.performSegueWithIdentifier("idUpFirst", sender: self)
    }
    @IBAction func left(sender: AnyObject) {
        self.performSegueWithIdentifier("idLeftFirst", sender: self)

    }
    @IBAction func bottom(sender: AnyObject) {
        self.performSegueWithIdentifier("idDownFirst", sender: self)
    }
}

