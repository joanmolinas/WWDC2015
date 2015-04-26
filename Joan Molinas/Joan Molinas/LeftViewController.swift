//
//  LeftViewController.swift
//  Joan Molinas
//
//  Created by Joan Molinas on 14/4/15.
//  Copyright (c) 2015 Joan. All rights reserved.
//

import UIKit
import AVFoundation

class LeftViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, CollectionViewCellDelegate {
    
    let videoName = "video"
    let format = "mp4"
    
    var player : AVPlayer!
    var layerPlayer : AVPlayerLayer!
    var blurEffectView =  UIVisualEffectView()
    
    @IBOutlet weak var back: UIButton!
    @IBOutlet weak var showVideo: UISwitch!
    let images : Array<String> = ["me", "flat","map"]
    private var collectionFrame : CGRect!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    deinit {
        collectionView.dataSource = nil
        collectionView.delegate = nil
        collectionView = nil
        back = nil
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.collectionViewLayout = CollectionViewLayout()
        collectionView.registerClass(CollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.contentInset = UIEdgeInsetsMake(150, 150, 0, 100)
        collectionFrame = collectionView.frame
        
        /* Video */
        let filePath = NSBundle.mainBundle().pathForResource(videoName, ofType: format)
        let url = NSURL(fileURLWithPath: filePath!)
        
        player = AVPlayer.playerWithURL(url) as! AVPlayer
        player.actionAtItemEnd = .None
        player.volume = 0
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "videoFinish:", name: AVPlayerItemDidPlayToEndTimeNotification, object: player.currentItem)
        
        layerPlayer = AVPlayerLayer(player: player)
        layerPlayer.frame = view.frame
        layerPlayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        
        view.layer.insertSublayer(layerPlayer, atIndex: 0)
        
        player.play()
        
        /* Blur */
        addBlurEffect(UIBlurEffectStyle.Light)
        
        
        /* Segue */
        var swipeGestureRecognizer: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "showFirstViewController")
        swipeGestureRecognizer.direction = UISwipeGestureRecognizerDirection.Left
        self.view.addGestureRecognizer(swipeGestureRecognizer)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animateWithDuration(0.5, delay: 0.4, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.back.alpha = 1
            }, completion: nil)
    }
    
    //MARK: CollectionView DataSource and Delegate
    func showFirstViewController() {
        self.performSegueWithIdentifier("idLeftUnwind", sender: self)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collectionView.collectionViewLayout.invalidateLayout()
        return 12
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CollectionViewCell
        
        cell.delegate = self
       
        return cell
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        var cell = collectionView.cellForItemAtIndexPath(indexPath) as! CollectionViewCell
        var viewer = ImageViewerView(frame: view.frame, image: cell.image!.image!)
        view.addSubview(viewer)
        
    }
    
    //MARK: Cell delegate
    func getImage(cell: CollectionViewCell) -> UIImage {
        var indexPath = collectionView.indexPathForCell(cell)
        return UIImage(named:"foto"+String(indexPath!.row+1))!
    }
    
    //MARK: Switch
    @IBAction func switchChanged(sender: UISwitch) {
            UIView.animateWithDuration(0.7, animations: { () -> Void in
                self.collectionView.alpha = sender.on ? 0 : 1
                self.blurEffectView.alpha = sender.on ? 0 : 1
            })
    }
    
    //MARK: Notifications
    func videoFinish(sender : NSNotification) {
        var item = sender.object as! AVPlayerItem
        item.seekToTime(kCMTimeZero)
    }
    
    //MARK: Blur
    func addBlurEffect(style : UIBlurEffectStyle) {
        var blur = UIBlurEffect(style: style)
        
        blurEffectView = UIVisualEffectView(effect: blur)
        blurEffectView.frame = view.bounds
        
        
        view.insertSubview(blurEffectView, atIndex: 1)
        
    }
    
    //MARK: AVPlayer
    func removeAVPlayer() {
        player.pause()
        layerPlayer.removeFromSuperlayer()
        player = nil
    }

    @IBAction func back(sender: AnyObject) {
        showFirstViewController()
    }
}
