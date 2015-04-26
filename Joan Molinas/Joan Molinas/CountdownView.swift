//
//  CountdownView.swift
//  Memory
//
//  Created by Joan Molinas on 27/3/15.
//  Copyright (c) 2015 Joan. All rights reserved.
//

import UIKit

class CountdownView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        println("aaaa")
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: CGRect) {
        var oval = UIBezierPath(ovalInRect: rect)
        UIColor.redColor().setFill()
        oval.fill()
        
    }


}
