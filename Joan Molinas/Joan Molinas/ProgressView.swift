//
//  ProgressView.swift
//  Memory
//
//  Created by Joan Molinas on 25/3/15.
//  Copyright (c) 2015 Joan. All rights reserved.
//

import UIKit
protocol progressViewDelegate {
    func timeOut()
    func timeStart()
    func countDownFinish()
}

class ProgressView: UIView {
    private var seconds = 3
    private var animation : CABasicAnimation!
    private var rectShape : CAShapeLayer!
    private var color : UIColor!
    var label : UILabel!
    private var percent : Int!
    var textLabel : String? {
        willSet (newValue){
            self.textLabel = newValue
        }
    }
    
    var per : UILabel!
    var delegate : progressViewDelegate?
    
    
    
    init(frame: CGRect, percent : Int) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        self.percent = percent
        color = UIColor(netHex: 0xFF7043)
    }
    
    deinit {
        animation = nil
        rectShape = nil
        label = nil
        delegate = nil
    }
    
    override func drawRect(rect: CGRect) {
        
        var width = percent! * Int(rect.width) / 100
        let shapeBounds = CGRect(x: 0, y: 0, width: 1, height: rect.height)
        let shapeBounds2 = CGRect(x: 0, y: 0, width: CGFloat(width), height: rect.height)
        
        var path2 = UIBezierPath(rect:shapeBounds2).CGPath
        var path1 = UIBezierPath(rect:shapeBounds).CGPath
        
        rectShape = CAShapeLayer()
        rectShape.bounds = shapeBounds
        rectShape.path = path1
        rectShape.position = CGPointMake(0, center.y)
        rectShape.fillColor = color!.CGColor
        //rectShape.addSublayer(gradient)
        layer.addSublayer(rectShape)
        
        animation = CABasicAnimation(keyPath: "path")
        animation.duration = 0.5
        animation.beginTime = CACurrentMediaTime() + 0.5
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.fromValue = path1
        animation.toValue = path2
        animation.fillMode = kCAFillModeBoth
        animation.removedOnCompletion = false
        animation.delegate = self;
        
        addAnimation()
        
        label = UILabel(frame: CGRectMake(30, 0, CGFloat(width), rect.height))
        label?.font = UIFont(name: "HelveticaNeue-Thin", size: 30)
        label?.textColor = UIColor.whiteColor()
        label?.text = textLabel
        
        
        per = UILabel(frame: CGRectMake(rect.width - 100, 0,100, rect.height))
        per.font = UIFont(name: "HelveticaNeue-Thin", size: 30)
        per.text = "\(percent!) %"
        per.textColor = color
        per.alpha = 0
        addSubview(per)
        
        
    }
    
    //MARK : Animation
    func addAnimation() {
        rectShape.addAnimation(animation, forKey: animation.keyPath)
    }
    override func animationDidStart(anim: CAAnimation!) {
        delegate?.timeStart()
    }
    override func animationDidStop(anim: CAAnimation!, finished flag: Bool) {
        delegate?.timeOut()
        addSubview(label!)
        
        
    }
    
    //MARK : Countdown
    func countDown(timer : NSTimer) {
        if seconds < 1{
            timer.invalidate()
            delegate?.countDownFinish()
        } else {
            println(seconds--)
        }
    }
    //Pause and Resume Animation
    func pauseLayer() {
        var pausedTime = layer.convertTime(CACurrentMediaTime(), fromLayer: nil)
        rectShape.speed = 0.0
        rectShape.timeOffset = pausedTime
    }
    
    func resumeLayer() {
        var pausedTime = layer.timeOffset
        rectShape.speed = 1.0
        rectShape.timeOffset = 0.0
        var timeSincePause = layer.convertTime(CACurrentMediaTime(), fromLayer: nil) - pausedTime
        rectShape.beginTime = timeSincePause

    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
