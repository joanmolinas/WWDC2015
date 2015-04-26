//
//  CenterCollectionViewCell.swift
//  Joan Molinas
//
//  Created by Joan Molinas on 16/4/15.
//  Copyright (c) 2015 Joan. All rights reserved.
//

import UIKit

class CenterCollectionViewCell: UICollectionViewCell {
    
    var type : Type! {
        willSet(newValue) {
            self.type = newValue
            
        }
    }
    
    override func drawRect(rect: CGRect) {
        layer.cornerRadius = 5
       
            var v = FactoryView.tableWithType(type, frame: rect)!
            addSubview(v)
    }

}
