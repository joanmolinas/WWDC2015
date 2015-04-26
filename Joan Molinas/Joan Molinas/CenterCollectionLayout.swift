//
//  CenterCollectionLayout.swift
//  Joan Molinas
//
//  Created by Joan Molinas on 16/4/15.
//  Copyright (c) 2015 Joan. All rights reserved.
//

import UIKit


struct Size {
    var w : CGFloat = 0.0, h : CGFloat = 0.0
}
class CenterCollectionLayout: UICollectionViewLayout {
    let COLS = 2
    let ROWS = 2
    let interimSpace: CGFloat = 0.0
    let itemSize: CGFloat = 416
    var cellCount: Int {
        return COLS*ROWS
    }
    let sizeCellTypeA = Size(w: 436, h: 300)
    let sizeCellTypeB = Size(w: 416, h: 500)
    
    
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return true
    }
    
    override func collectionViewContentSize() -> CGSize {
        return CGSizeMake(self.itemSize * CGFloat(COLS) ,
            self.itemSize * CGFloat(ROWS))
        
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [AnyObject]? {
        var attributes = [AnyObject]()
        for i in 0 ..< cellCount {
            let indexPath = NSIndexPath(forItem: i, inSection: 0)
            attributes.append(self.layoutAttributesForItemAtIndexPath(indexPath))
        }
        return attributes
    }
    
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes!
    {
        var attributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
        var frame : CGRect
        switch indexPath.row {
        case 0:
            frame = CGRectMake(0, 0, sizeCellTypeB.w,sizeCellTypeB.h)
        case 1:
            frame = CGRectMake(sizeCellTypeB.w + 10, 0, sizeCellTypeA.w, sizeCellTypeA.h)
        case 2:
            frame = CGRectMake(426, 310, 436, 300)
        case 3:
            frame = CGRectMake(0, 510, 416, 100)
        default:
            frame = CGRectZero
        }

        attributes.frame = frame
        
        
        return attributes
    }
}
