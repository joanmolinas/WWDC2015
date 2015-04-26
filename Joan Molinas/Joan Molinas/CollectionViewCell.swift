//
//  CollectionViewCell.swift
//  
//
//  Created by Joan Molinas on 15/4/15.
//
//

import UIKit

protocol CollectionViewCellDelegate {
    func getImage(cell : CollectionViewCell) -> UIImage
}
class CollectionViewCell: UICollectionViewCell {
   
    var image : UIImageView?
    var delegate : CollectionViewCellDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.layer.cornerRadius = frame.width/2.0
        self.contentView.layer.backgroundColor =  UIColor(red: 0.0, green: 0.0, blue: 0.9, alpha: 0.8).CGColor
        contentView.opaque = false
        opaque = false
        
    }
    
    deinit {
        image = nil
        delegate = nil
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func drawRect(rect: CGRect) {
       
        image = UIImageView(image: delegate?.getImage(self))
        image?.frame = rect
        image?.backgroundColor = UIColor.lightGrayColor()
        image?.clipsToBounds = true
        image?.layer.masksToBounds = true
        image?.contentMode = UIViewContentMode.ScaleAspectFill
        image!.autoresizingMask = UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleWidth
        image?.layer.cornerRadius = rect.width/2
        addSubview(image!)
        
    }

}
