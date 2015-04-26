//
//  FactoryTables.swift
//  Joan Molinas
//
//  Created by Joan Molinas on 16/4/15.
//  Copyright (c) 2015 Joan. All rights reserved.
//

import UIKit
import MapKit

enum Type  {
    case Profile, Description, Map, Beat
}
class FactoryView: NSObject {
    class func tableWithType(type : Type, frame : CGRect) -> UIView? {
        switch type {
        case .Profile:
            return NSBundle.mainBundle().loadNibNamed("Profile", owner: self, options: nil)[0] as? UIView
        case .Description:
            return  NSBundle.mainBundle().loadNibNamed("Description", owner: self, options: nil)[0] as? UIView
        case .Map:
            return NSBundle.mainBundle().loadNibNamed("Map", owner: self, options: nil)[0] as? UIView
        case .Beat:
            return NSBundle.mainBundle().loadNibNamed("Beat", owner: self, options: nil)[0] as? UIView
        }
    }
}

class ProfileView: UIView {
    
    
    @IBOutlet weak var me: UIImageView!
    
    @IBOutlet weak var backImage: UIImageView!
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        me.layer.cornerRadius = me.frame.size.width/2
        me.layer.masksToBounds = true
    }
}
class MapView : UIView {
    
    @IBOutlet var mapView: MKMapView!

    @IBOutlet var location: UILabel!
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
       
        var span = MKCoordinateSpan(latitudeDelta: 0.0010, longitudeDelta: 0.0010)
        var coordinate = CLLocationCoordinate2D(latitude: 41.2258384177893, longitude: 1.53288770875930786)
        var region = MKCoordinateRegion(center: coordinate, span: span)
        
        mapView.setRegion(region, animated: true)
        
        location.layer.cornerRadius = 4
        location.layer.masksToBounds = true
        
        
        
    }
}
class Beat : UIView {
    
    @IBOutlet weak var label: UILabel!

    @IBAction func dribbble(sender: AnyObject) {
        
        UIApplication.sharedApplication().openURL(NSURL(string:"http://www.dribbble.com/ulidev")!)
    }

    @IBAction func twitter(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string:"http://www.twitter.com/JoanMolinas")!)
    }
    @IBAction func github(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string:"http://www.github.com/ulidev")!)
    }
}

