//
//  ImageViewerView.swift
//  Joan Molinas
//
//  Created by Joan Molinas on 15/4/15.
//  Copyright (c) 2015 Joan. All rights reserved.
//

import UIKit

class ImageViewerView: UIView {

    private var img : UIImage?
    private var motionView : PanoramaView?
    
    init(frame : CGRect, image : UIImage) {
        super.init(frame: frame)
        self.img = image
        
        backgroundColor = UIColor(white: 0.8, alpha: 0.9)
        var blur = UIBlurEffect(style: .Dark)
        var effect = UIVisualEffectView(effect: blur)
        effect.frame = frame
        
        addSubview(effect)
        
        var tap = UITapGestureRecognizer(target: self, action: "close:")
        addGestureRecognizer(tap)
        
    }
    
    deinit {
        img = nil
        motionView = nil
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: CGRect) {
        
        motionView = PanoramaView(frame: rect)
        motionView!.setImage(img!)
        addSubview(motionView!)
    }
    
    //MARK: Tap
    func close(sender : UITapGestureRecognizer) {
        removeFromSuperview()
    }

}
