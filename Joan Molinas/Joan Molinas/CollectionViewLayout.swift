//
//  CollectionViewLayout.swift
//  Watchkit
//
//  Created by Joan Molinas on 15/4/15.
//  Copyright (c) 2015 Joan. All rights reserved.
//

import UIKit

class CollectionViewLayout: UICollectionViewLayout {
    let COLS = 4
    let ROWS = 3
    let interimSpace: CGFloat = 0.0
    let itemSize: CGFloat = 200
    var center: CGPoint {
        return CGPoint(x: (self.cViewSize.width) / 2.0,
            y: (self.cViewSize.height) / 2.0)
    }
    var cellCount: Int {
        return COLS*ROWS
    }
    var cViewSize: CGSize {
        return self.collectionView!.frame.size
    }
    var width: CGFloat {
        return 2.5 * self.cViewSize.width
    }
    var height: CGFloat {
        return 2.5 * self.cViewSize.height
    }
    let cons: CGFloat = 20
    
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return true
    }
    
    override func collectionViewContentSize() -> CGSize {
        return CGSizeMake(self.itemSize * CGFloat(COLS) ,
            self.itemSize * CGFloat(ROWS))
        
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [AnyObject]? {
        var attributes = [AnyObject]()
        for i in 0 ..< 12 {
            let indexPath = NSIndexPath(forItem: i, inSection: 0)
            attributes.append(self.layoutAttributesForItemAtIndexPath(indexPath))
        }
        return attributes
    }
    
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes!
    {
        var attributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
        
        let oIndex = indexPath.item % COLS
        let vIndex = (indexPath.item - oIndex) / COLS
        var x = CGFloat(oIndex) * self.itemSize
        var y = CGFloat(vIndex) * self.itemSize
        if vIndex % 2 != 0 {
            x += self.itemSize / 2.0
        }
        
        attributes.center = CGPoint(x: x, y: y)
        
        let offset = self.collectionView!.contentOffset
        x -= (self.center.x + CGFloat(offset.x))
        y -= (self.center.y + CGFloat(offset.y))
        x = -x*x/(width*width)
        y = -y*y/(height*height)
        var z = cons * (x+y) + 1.0
        z = z < 0.0 ? 0.0 : z
        attributes.transform = CGAffineTransformMakeScale(z, z)
        attributes.size = CGSize(width: self.itemSize, height: self.itemSize)   
        
        return attributes
    }
}
