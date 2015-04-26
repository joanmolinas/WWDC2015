//
//  UPCollectionViewCell.swift
//  Joan Molinas
//
//  Created by Joan Molinas on 20/4/15.
//  Copyright (c) 2015 Joan. All rights reserved.
//

import UIKit
enum ColorCell : String {
    case Red = "#F25656"
    case Blue = "#5CC5E8"
    case BlueDeep = "#274079"
    case Yellow = "#F7A619"
    case Celest = "#1ABC9C"
    case BlueSky = "#24A6F0"
    case CelestSky = "#56DCE3"
}
class Scroll : UIScrollView {
    var index = 0, currentPage = 0, npages = 1
    var images : NSMutableArray!
    var title : String!
    
    init(frame : CGRect, center : CGPoint) {
        super.init(frame: frame)
        showsHorizontalScrollIndicator = false
        self.center = center
        backgroundColor = UIColor.blueColor()
        scrollEnabled = false
        pagingEnabled = true
    
        images = NSMutableArray()
        
        userInteractionEnabled = true
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addScreen(name : String?) {
        
            contentSize = CGSizeMake(frame.size.width * CGFloat(npages++), frame.size.height)
            
            var image = UIImageView(image: UIImage(named: name!))
            image.frame = CGRectMake(frame.size.width * CGFloat(index++), 0, frame.size.width, frame.size.height)
            image.backgroundColor = index%2 == 0 ? UIColor.redColor() : UIColor.blueColor()
            addSubview(image)
        
    }
    
    func addImages(images : NSArray) {
        self.images = images.mutableCopy() as! NSMutableArray
        for i in self.images {
            addScreen(i as? String)
        }
    }
    
    func removeImages() {
        contentSize = CGSizeMake(0, frame.size.height)
    }
    func animation() {
        UIView.animateWithDuration(0.2, delay: 3, options: UIViewAnimationOptions.LayoutSubviews, animations: { () -> Void in
            if self.currentPage == 3 { self.currentPage = 0 }
            self.contentOffset = CGPointMake(CGFloat(self.currentPage++) * self.frame.size.width, 0)
        }) { (Finished) -> Void in
            self.animation()
        }
        
    }
}
protocol CellProtocol {
    func setImage(image : NSString) -> UIImage
}
class UPCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var iphone: UIImageView!
    @IBOutlet weak var LeftDescription: UITextView!
    @IBOutlet weak var RightDescription: UITextView!
    @IBOutlet weak var titleLabel: UILabel!
    var image = ""
    var images = NSMutableArray()
    
    private var scrollView : Scroll!

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override func drawRect(rect: CGRect) {
        layer.cornerRadius = 7
        layer.masksToBounds = true
        
        scrollView = Scroll(frame: CGRectMake(0, 0, 197, 347), center: iphone.center) as Scroll
        contentView.addSubview(scrollView)
        scrollView.addImages(images)
        scrollView!.animation()
        
       
    }
    func setData(dict : Dictionary<String, String>) {
        titleLabel.text = dict["title"]
        RightDescription.text = dict["descriptionRight"]
        LeftDescription.text = dict["descriptionLeft"]
        image = dict["image"]!
        
        images = NSMutableArray()
        images.addObject(image+"1")
        images.addObject(image+"2")
        images.addObject(image+"3")
        
        setNeedsDisplay()
       
        contentView.backgroundColor = UIColor(rgba: dict["color"]!)
        
   
    }
    
}
