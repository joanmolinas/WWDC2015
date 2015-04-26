//
//  DownCustomSegueUnwind.swift
//  Joan Molinas
//
//  Created by Joan Molinas on 14/4/15.
//  Copyright (c) 2015 Joan. All rights reserved.
//

import UIKit

class DownCustomSegueUnwind: UIStoryboardSegue {
    override func perform() {
        var firstVC = self.sourceViewController.view as UIView!
        var secondVC = self.destinationViewController.view as UIView!
        
        let screenWidth = UIScreen.mainScreen().bounds.size.width
        let screenHeight = UIScreen.mainScreen().bounds.size.height
        secondVC.frame = CGRectMake(0, -screenHeight, screenWidth, screenHeight)
        
        let window = UIApplication.sharedApplication().keyWindow
        window?.insertSubview(secondVC, aboveSubview: firstVC)
        
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            firstVC.frame = CGRectOffset(firstVC.frame, 0.0, screenHeight)
            secondVC.frame = CGRectOffset(secondVC.frame, 0.0, screenHeight)
            
            
            }) { (Finished) -> Void in
                self.sourceViewController.dismissViewControllerAnimated(false, completion: nil)
        }
    }
}
