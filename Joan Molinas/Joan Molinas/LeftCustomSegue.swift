//
//  LeftCustomSegue.swift
//  Joan Molinas
//
//  Created by Joan Molinas on 14/4/15.
//  Copyright (c) 2015 Joan. All rights reserved.
//

import UIKit

class LeftCustomSegue: UIStoryboardSegue {
    override func perform() {
        var firstVC = self.sourceViewController.view as UIView!
        var secondVC = self.destinationViewController.view as UIView!
        
        let screenWidth = UIScreen.mainScreen().bounds.size.width
        let screenHeight = UIScreen.mainScreen().bounds.size.height
        secondVC.frame = CGRectMake(-screenWidth, 0, screenWidth, screenHeight)
        
        let window = UIApplication.sharedApplication().keyWindow
        window?.insertSubview(secondVC, aboveSubview: firstVC)
        
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            firstVC.frame = CGRectMake(+screenWidth, 0, screenWidth, screenHeight)
            secondVC.frame = CGRectMake(0, 0, screenWidth, screenHeight)
            
            
            }) { (Finished) -> Void in
                self.sourceViewController.presentViewController(self.destinationViewController as! UIViewController,
                    animated: false,
                    completion: nil)
        }

    }
}
