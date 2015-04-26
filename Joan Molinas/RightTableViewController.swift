//
//  RightTableViewController.swift
//  Joan Molinas
//
//  Created by Joan Molinas on 15/4/15.
//  Copyright (c) 2015 Joan. All rights reserved.
//

import UIKit

class RightTableViewController: UITableViewController {
    
    var skills = [85, 80, 73 , 65, 65, 60, 55, 80, 76, 50 ,88]
    var skillsLaguage : [Language] = [.Objc, .Swift, .Android, .Python, .NodeJS, .Alghoritms, .Cryptography, .BBDD, .Design, .Bash, .Java]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var swipeGestureRecognizer: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "showFirstViewController")
        swipeGestureRecognizer.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(swipeGestureRecognizer)
        
        tableView.tableFooterView = UIView()
        tableView?.registerClass(SkillsTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.separatorStyle = .None
        tableView.scrollEnabled = false
        
        
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    func showFirstViewController() {
        self.performSegueWithIdentifier("idRightUnwind", sender: self)
    }
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 13
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell  = tableView.dequeueReusableCellWithIdentifier("cell") as! SkillsTableViewCell!
        
        cell.percent = skills[indexPath.section]
        cell.type = skillsLaguage[indexPath.section]
        
        return cell
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var cell = tableView.cellForRowAtIndexPath(indexPath) as! SkillsTableViewCell
        cell.viewPercent()
    }
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {

        return view.frame.size.height / CGFloat(skills.count) - 5.0
    }
}
