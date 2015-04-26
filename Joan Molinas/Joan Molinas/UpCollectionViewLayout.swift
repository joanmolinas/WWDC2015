//
//  UpCollectionViewLayout.swift
//  Joan Molinas
//
//  Created by Joan Molinas on 18/4/15.
//  Copyright (c) 2015 Joan. All rights reserved.
//

import UIKit
struct size {
    var w : CGFloat = 0, h : CGFloat = 0
}
class UpCollectionViewLayout: UICollectionViewFlowLayout {
    var COLS : Int = 0{
        willSet(newValue) {
            self.COLS = newValue
        }
    }
    let interimSpace: CGFloat = 0.0
    var itemSize2: size = size(w: 800, h: 600)
    var cellCount: Int {
        return COLS
    }
    var actual : CGFloat = 0.0

    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return true
    }
    
    override func collectionViewContentSize() -> CGSize {
        return CGSizeMake(self.itemSize2.w * CGFloat(COLS) ,
            self.itemSize2.h)
        
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [AnyObject]? {
        var attributes = [AnyObject]()
        for i in 0 ..< COLS {
            let indexPath = NSIndexPath(forItem: i, inSection: 0)
            attributes.append(self.layoutAttributesForItemAtIndexPath(indexPath))
        }
        return attributes
    }
    
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes!
    {
        var attributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
        
        let oIndex : CGFloat = CGFloat(indexPath.item % COLS)
        var x = CGFloat(oIndex) * self.itemSize2.w
        var center = collectionView!.center
        attributes.size = CGSize(width: self.itemSize2.w, height: self.itemSize2.h)
        attributes.center = CGPointMake(collectionView!.center.x + CGFloat(indexPath.row) * itemSize2.w - CGFloat(indexPath.row) * 60, collectionView!.center.y)
        
        
        
        let offset = self.collectionView!.contentOffset
        actual = round(offset.x/itemSize2.w)
        var distanceToCenter = abs(hypotf(Float(offset.x - attributes.center.x) , Float(offset.y - attributes.center.y)) - 640)
        var z : CGFloat
        var width : CGFloat = collectionView!.frame.size.width/2 - 50
        z = 1 - (CGFloat(distanceToCenter * 0.6) / width)
        z = z > 1 ? 1 : z < 0.6 ? 0.6 : z
       
        
        var alpha : Float = 0
        var a =  distanceToCenter * 100 / 650
        var y = a / 100
        alpha = 1 - y
        attributes.alpha = alpha < 0.2 ? 0.2 : CGFloat(alpha)

        
        attributes.transform = CGAffineTransformMakeScale(z, z)
        
        func description() -> String {
            return "Index = \(oIndex), a = ), alpha \(alpha)"
        }
        
        return attributes
    }
    
    

}
