//
//  CameraView.swift
//  Burn
//
//  Created by Митько Евгений on 24.03.16.
//  Copyright © 2016 Evgeny Mitko. All rights reserved.
//

import UIKit

extension CameraViewController {
    
    func layoutView() {
        self.view.backgroundColor = UIColor(red: 65/255, green: 70/255, blue: 72/255, alpha: 1)
        
        
        var layer = Size(x: 0, y: 0, width: 414, height: 70)
        let navBar = UIView(frame: CGRect(x: layer.x, y: layer.y, width: layer.width, height: layer.height))
        navBar.backgroundColor = UIColor(red: 30/255, green: 36/255, blue: 39/255, alpha: 1)
        view.addSubview(navBar)
        
        

        
        
        
        layer = Size(x: 0, y: 29, width: 414, height: 25)
        let titleLabel = UILabel(frame: CGRect(x: layer.x, y: layer.y, width: layer.width, height: layer.height))
        titleLabel.font = UIFont(name: "Lato-Light", size: 21)
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.textAlignment = .Center
        titleLabel.text = "Choose Recipients"
        view.addSubview(titleLabel)
        
        layer = Size(x: 0, y: 686, width: 206, height: 50)
        let cancelButton = UIButton(frame: CGRect(x: layer.x, y: layer.y, width: layer.width, height: layer.height))
        cancelButton.backgroundColor = UIColor(red: 231/255, green: 29/255, blue: 54/299, alpha: 1)
        cancelButton.setBackgroundImage(UIImage.imageWithColor(UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1)), forState: .Highlighted)
        cancelButton.setTitle("Cancel", forState: .Normal)
        cancelButton.addTarget(self, action: #selector(CameraViewController.cancelButtonPressed), forControlEvents: .TouchUpInside)
        view.addSubview(cancelButton)
        
        
        layer = Size(x: 208, y: 686, width: 206, height: 50)
        let doneButton = UIButton(frame: CGRect(x: layer.x, y: layer.y, width: layer.width, height: layer.height))
        doneButton.backgroundColor = UIColor(red: 46/255, green: 196/255, blue: 182/255, alpha: 1)
        doneButton.setBackgroundImage(UIImage.imageWithColor(UIColor(red: 39/255, green: 171/255, blue: 158/255, alpha: 1)), forState: .Highlighted)
        doneButton.setTitle("Send", forState: .Normal)
        doneButton.addTarget(self, action: #selector(CameraViewController.sendButtonPressed), forControlEvents: .TouchUpInside)
        view.addSubview(doneButton)
        
        
        
        
        
        layer = Size(x: 0, y: 70, width: 414, height: 616)
        tableView = UITableView(frame: CGRect(x: layer.x, y: layer.y, width: layer.width, height: layer.height))
        tableView.backgroundColor = UIColor(patternImage: UIImage(named: "BackgroundFriends")!)
        tableView.registerClass(FriendsListCell.self, forCellReuseIdentifier: "friendCell")
        tableView.dataSource = self
        tableView.delegate = self
        //        tableView.layer.cornerRadius = 10
        layer = Size(x: 0, y: 0, width: 0, height: 90)
        tableView.rowHeight = layer.height
        tableView.separatorStyle = .None
        view.addSubview(tableView)
        
        let itemLayer = Size(x: 69, y: 309, width: 276, height: 48)
        noContactsLabel = UILabel(frame: CGRect(x: itemLayer.x, y: itemLayer.y, width: itemLayer.width, height: itemLayer.height))
        noContactsLabel.font = UIFont(name: "Lato-Light", size: 22)
        noContactsLabel.textAlignment = .Center
        noContactsLabel.numberOfLines = 0
        noContactsLabel.adjustsFontSizeToFitWidth = true
        noContactsLabel.textColor = UIColor.whiteColor()
        self.view.addSubview(noContactsLabel)
        
        layer = Size(x: 104, y: 377, width: 207, height: 50)
        editFriendsButton = UIButton(frame: CGRect(x: layer.x, y: layer.y, width: layer.width, height: layer.height))
        editFriendsButton.backgroundColor = UIColor(red: 46/255, green: 196/255, blue: 182/255, alpha: 1)
        editFriendsButton.setBackgroundImage(UIImage.imageWithColor(UIColor(red: 39/255, green: 171/255, blue: 158/255, alpha: 1)), forState: .Highlighted)
        editFriendsButton.setTitle("Edit Friends", forState: .Normal)
        editFriendsButton.addTarget(self, action: #selector(CameraViewController.editFriends), forControlEvents: .TouchUpInside)
        view.addSubview(editFriendsButton)
    }
    
}
