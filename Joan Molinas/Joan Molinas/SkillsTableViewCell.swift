//
//  SkillsTableViewCell.swift
//  Joan Molinas
//
//  Created by Joan Molinas on 15/4/15.
//  Copyright (c) 2015 Joan. All rights reserved.
//

import UIKit

enum Language : String {
    
    case Objc = "Objective-C"
    case Swift = "Swift"
    case Android = "Android"
    case Python = "Python"
    case NodeJS = "NodeJS"
    case Alghoritms = "Algorithms"
    case Cryptography = "Cryptography"
    case BBDD = "BBDD"
    case Design = "Design"
    case Bash = "Bash"
    case Java = "Java"
}

class SkillsTableViewCell: UITableViewCell {
    
    var progress : ProgressView!
    var type : Language {
        willSet (newValue){
            self.type = newValue
        }
    }
    
    var percent : Int = 0 {
        willSet (newValue){
            self.percent = newValue
        }
    }
    var count = 2
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        type = .Objc
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: CGRect) {
        
        self.contentView.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        
        selectionStyle = .None
        
        
        progress = ProgressView(frame: rect, percent: percent)
        progress.textLabel = type.rawValue
        contentView.addSubview(progress)
    }
    
    
    func viewPercent() {
        var timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: "viewTimer:", userInfo: nil, repeats: true)
    }
    
    func viewTimer(sender : NSTimer) {
        if count < 1 {
            progress.per.alpha = 0
            sender.invalidate()
        } else {
            progress.per.alpha = 1
            count--;
        }
    }
}
