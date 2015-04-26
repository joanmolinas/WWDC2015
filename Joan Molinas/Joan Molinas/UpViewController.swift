//
//  UpViewController.swift
//  Joan Molinas
//
//  Created by Joan Molinas on 18/4/15.
//  Copyright (c) 2015 Joan. All rights reserved.
//

import UIKit



class UpViewController: UICollectionViewController {
    
    var dicts : [[String : String]] =
        [["title" : "iFM", "descriptionRight" : "iFM is a GeoApplication. When app located you, show the near 'Major's Party'. A 'Major Party' include events, concerts, theatres, DJ's and much more. Also, it's possible to save the favorites Parties.", "descriptionLeft" : "iFM is my first app, based in El Vendrell. This app borned the last summer. In Catalonia is traditional 'Major's Party'. iFM has an iOS app & backend (nodeJS & Parse)", "color" : ColorCell.Celest.rawValue, "image" : "iFM"],
        ["title" : "Bausch&Lomb", "descriptionRight" : "Bausch&Lomb show all the events and description. Each event have a name, description, program, location and the possibility to save in a native Calendar. The next part was a calendar with all the events.", "descriptionLeft" : "Bausch&Lomb is a Bussiness Application. Borned in Valencia and made in El Vendrell. Started from November 2014 to February 2015.", "color" : ColorCell.Blue.rawValue, "image" : "bausch"],
        ["title" : "Jobjobs", "descriptionRight" : "Jobjobs is a work browser. Have 2 types of users, workers and demanders. A Worker is a person who offers your work services. Demander only search a worker. \n Its possible save in favourites.", "descriptionLeft" : "Jobjobs is the first app in my actual work. Based in Barcelona (Group Network). Borned from January 2015 to May 2015. Inspired with a Spanish need.", "color" : ColorCell.BlueDeep.rawValue, "image" : "jobjobs"],
        ["title" : "Planeat", "descriptionRight" : "App Geolocalize position and show the bars, restaurant and events near you and show their descriptions. Can save in Favorites and much more.", "descriptionLeft" : "Planeat is my most complicated project. Based in Valencia and made in some parts of Spain. Borned from October 2013 to now.", "color" : ColorCell.Red.rawValue, "image" : "planeat"],
        ["title" : "Tipbeat", "descriptionRight" : "Tipbeat is an project for PayPal Hackaton. Made in 24 hours. iOS App, Server and Design. \n Is simple, a street performer create a profile, generate an unic identifier and put in their audicions.", "descriptionLeft" : "Made in London, Paypal Hackaton (2014).", "color" : ColorCell.BlueSky.rawValue , "image" : "tipbeat"]]
    
    //MARK: Constants
    let reuseIdentifier = "Cell"
    
    //MARK: Variables
    var back : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var swipeGestureRecognizer: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "showFirstViewController")
        swipeGestureRecognizer.direction = UISwipeGestureRecognizerDirection.Up
        self.view.addGestureRecognizer(swipeGestureRecognizer)
        
        var layout = UpCollectionViewLayout()
        layout.COLS = dicts.count
        collectionView?.collectionViewLayout = layout
        collectionView?.backgroundColor = UIColor(rgba: "#2D7C6A")
        
        back = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        back.frame = CGRectMake(0, 0, 100, 50)
        back.setImage(UIImage(named: "fillBottom"), forState: .Normal)
        back.center = CGPointMake(view.center.x, view.frame.size.height - 40)
        back.tintColor = UIColor.whiteColor()
        back.addTarget(self, action: "showFirstViewController", forControlEvents: .TouchUpInside)
        back.alpha = 0
        view.addSubview(back)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animateWithDuration(0.5, delay: 0.4, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                self.back.alpha = 1
            }, completion: nil)

    }
    func showFirstViewController() {
        self.performSegueWithIdentifier("idUPUnwind", sender: self)
    }
    
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dicts.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! UPCollectionViewCell
        cell.setData(dicts[indexPath.row])
        return cell
    }
    override func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        var layout = collectionView?.collectionViewLayout as! UpCollectionViewLayout
        scrollView.setContentOffset(CGPointMake(layout.itemSize2.w * layout.actual - 1 - 60*layout.actual, 0), animated: true)
        var indexPath = NSIndexPath(forRow: Int(layout.actual), inSection: 0)
        
        
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        var layout = collectionView?.collectionViewLayout as! UpCollectionViewLayout
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            switch layout.actual {
            case 0:
                self.collectionView?.backgroundColor = UIColor(rgba: "#2D7C6A")
            case 1:
                self.collectionView?.backgroundColor = UIColor(rgba: "#275666")
            case 2:
                self.collectionView?.backgroundColor = UIColor(rgba: "#111731")
            case 3:
                self.collectionView?.backgroundColor = UIColor(rgba: "#482222")
            case 4:
                self.collectionView?.backgroundColor = UIColor(rgba: "#1C5B5E")
            default:
                break
            }
            
        })
    }

    
}
