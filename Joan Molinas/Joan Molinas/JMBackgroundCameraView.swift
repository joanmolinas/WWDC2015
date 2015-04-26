//
//  JMBackgroundCameraView.swift
//  JMSwiftBackgroundCameraView
//
//  Created by Joan Molinas on 2/11/14.
//  Copyright (c) 2014 joan molinas ramon. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

enum DevicePosition : Int {
    case Front
    case Back
}
class JMBackgroundCameraView: UIView {
    
    var session = AVCaptureSession()
    var input = AVCaptureDeviceInput()
    var device = AVCaptureDevice?()
    var imageOutput = AVCaptureStillImageOutput()
    var preview = AVCaptureVideoPreviewLayer()
    var blurEffectView =  UIVisualEffectView()

    init(frame: CGRect, position: DevicePosition) {
        super.init(frame: frame)
        initCameraInPosition(position)
    }

    
    init(frame: CGRect, position: DevicePosition, blur: UIBlurEffectStyle) {
        super.init(frame: frame)
        initCameraInPosition(position)
        addBlurEffect(blur)
        
    }
   
    func initCameraInPosition(position: DevicePosition) {
        
       
        session = AVCaptureSession()
        session.sessionPreset = AVCaptureSessionPresetHigh
        
        var devices = NSArray()
        devices = AVCaptureDevice.devicesWithMediaType(AVMediaTypeVideo)
        
        for device in devices {
            if position == .Back {
                if  device.position  == AVCaptureDevicePosition.Back {
                    self.device = device as? AVCaptureDevice
                }
            } else {
                if device.position == AVCaptureDevicePosition.Front {
                    self.device = device as? AVCaptureDevice
                }
            }
        }
        
        var error = NSErrorPointer()
        let outputSettings = NSDictionary(dictionary:[AVVideoCodecKey:AVVideoCodecJPEG])
        
        
        input = AVCaptureDeviceInput(device: device, error: error)
        if session.canAddInput(input) {
            session.addInput(input)
        }
        
        
        
        imageOutput = AVCaptureStillImageOutput()
        imageOutput.outputSettings = outputSettings as [NSObject : AnyObject]
        session.addOutput(imageOutput)
        preview = AVCaptureVideoPreviewLayer(session: session)
        preview.videoGravity = AVLayerVideoGravityResizeAspectFill
        preview.connection.videoOrientation = AVCaptureVideoOrientation.LandscapeRight
        preview.frame = frame
        layer.addSublayer(preview)
        session.startRunning()

    }
    func removeBlurEffect() {
        blurEffectView.removeFromSuperview()
    }
    
    func addBlurEffect(style : UIBlurEffectStyle) {
        var blur = UIBlurEffect(style: style)
        blurEffectView = UIVisualEffectView(effect: blur)
        blurEffectView.frame = bounds
        
        insertSubview(blurEffectView, atIndex: 1)
        
    }
    
    func connected() -> Bool? {
        return device?.connected
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
