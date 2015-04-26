//
//  LeftCustomSegueUnwind.swift
//  Joan Molinas
//
//  Created by Joan Molinas on 14/4/15.
//  Copyright (c) 2015 Joan. All rights reserved.
//

import UIKit

class LeftCustomSegueUnwind: UIStoryboardSegue {
    override func perform() {
        var leftVC = self.sourceViewController as! LeftViewController
        
        var secondVCView = self.sourceViewController.view as UIView!
        var firstVCView = self.destinationViewController.view as UIView!
        
        let screenHeight = UIScreen.mainScreen().bounds.size.height
        let screenWidth = UIScreen.mainScreen().bounds.size.width
        
        let window = UIApplication.sharedApplication().keyWindow
        window?.insertSubview(firstVCView, aboveSubview: secondVCView)
        
        // Animate the transition.
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            firstVCView.frame = CGRectMake(0, 0, screenWidth, screenHeight)
            secondVCView.frame = CGRectMake(-screenWidth, 0, screenWidth, screenHeight)
            }) { (Finished) -> Void in
                leftVC.removeAVPlayer()
                self.sourceViewController.dismissViewControllerAnimated(false, completion: nil)
        }
    }
}
