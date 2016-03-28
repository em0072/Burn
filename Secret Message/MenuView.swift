//
//  MenuView.swift
//  Burn
//
//  Created by Митько Евгений on 23.03.16.
//  Copyright © 2016 Evgeny Mitko. All rights reserved.
//

import UIKit

extension MenuController {
    
    
   func layoutView() {
    self.view.backgroundColor = UIColor(patternImage: UIImage(named: "MenuBackground")!)
    
    
    // MARK: NoMessage Label
    let itemLayer = Size(x: 0, y: 475, width: 278, height: 48)
    noFriendsLabel = UILabel(frame: CGRect(x: itemLayer.x, y: itemLayer.y, width: itemLayer.width, height: itemLayer.height))
    noFriendsLabel.font = UIFont(name: "Lato-Light", size: 20)
    noFriendsLabel.textAlignment = .Center
    noFriendsLabel.adjustsFontSizeToFitWidth = true
    noFriendsLabel.numberOfLines = 0
    noFriendsLabel.textColor = UIColor.whiteColor()
    
    self.view.addSubview(noFriendsLabel)
    
    
    //MARK: Profile Title
    layer = Size(x: 0, y: 20, width: 276, height: 44)
    let profileTitleLabel = UILabel(frame: CGRect(x: layer.x, y: layer.y, width: layer.width, height: layer.height))
    profileTitleLabel.font = UIFont(name: "Lato-Light", size: 36)
    profileTitleLabel.textColor = UIColor.whiteColor()
    profileTitleLabel.textAlignment = .Center
    profileTitleLabel.text = "Profile:"
    view.addSubview(profileTitleLabel)
    
    //MARK: Username Label
    layer = Size(x: 25, y: 84, width: 252, height: 36)
    let userNameLabel = UILabel(frame: CGRect(x: layer.x, y: layer.y, width: layer.width, height: layer.height))
    userNameLabel.font = UIFont(name: "Lato-Light", size: 30)
    userNameLabel.textColor = UIColor.whiteColor()
    userNameLabel.textAlignment = .Left
    userNameLabel.adjustsFontSizeToFitWidth = true
    userNameLabel.text = activeUser.name
    view.addSubview(userNameLabel)
    
    //MARK: Email Label
    layer = Size(x: 25, y: 140, width: 252, height: 30)
    let emailLabel = UILabel(frame: CGRect(x: layer.x, y: layer.y, width: layer.width, height: layer.height))
    emailLabel.font = UIFont(name: "Lato-Light", size: 24)
    emailLabel.textColor = UIColor.whiteColor()
    emailLabel.textAlignment = .Left
    emailLabel.adjustsFontSizeToFitWidth = true
    emailLabel.text = activeUser.email
    view.addSubview(emailLabel)
    
    //MARK: Logout Button
    layer = Size(x: 0, y: 199, width: 276, height: 51)
    let logoutButton = UIButton(frame: CGRect(x: layer.x, y: layer.y, width: layer.width, height: layer.height))
    logoutButton.backgroundColor = UIColor(red: 231/255, green: 29/255, blue: 54/299, alpha: 1)
    logoutButton.setTitleColor(UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1), forState: .Highlighted)
    logoutButton.setBackgroundImage(UIImage.imageWithColor(UIColor(red: 207/255, green: 27/255, blue: 48/255, alpha: 1)), forState: .Highlighted)
    logoutButton.titleLabel?.font = UIFont(name: "Lato-Light", size: 24)
    logoutButton.titleLabel?.adjustsFontSizeToFitWidth = true
    logoutButton.tintColor = UIColor.whiteColor()
    logoutButton.setTitle("Log Out", forState: .Normal)
    logoutButton.addTarget(self, action: #selector(MenuController.logoutButtonPressed), forControlEvents: .TouchUpInside)
    view.addSubview(logoutButton)
    
    
    //MARK: Friends Title
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "MenuBackground")!)
        layer = Size(x: 0, y: 273, width: 276, height: 44)
        let friendsTitleLabel = UILabel(frame: CGRect(x: layer.x, y: layer.y, width: layer.width, height: layer.height))
        friendsTitleLabel.font = UIFont(name: "Lato-Light", size: 36)
        friendsTitleLabel.textColor = UIColor.whiteColor()
        friendsTitleLabel.textAlignment = .Center
        friendsTitleLabel.text = "Friends:"
        view.addSubview(friendsTitleLabel)

        createTableView()
    
    //MARK: Edit Friends Button
    layer = Size(x: 0, y: 685, width: 276, height: 51)
    let editFriendsButton = UIButton(frame: CGRect(x: layer.x, y: layer.y, width: layer.width, height: layer.height))
    editFriendsButton.backgroundColor = UIColor(red: 231/255, green: 29/255, blue: 54/299, alpha: 1)
    editFriendsButton.setTitleColor(UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1), forState: .Highlighted)
    editFriendsButton.setBackgroundImage(UIImage.imageWithColor(UIColor(red: 207/255, green: 27/255, blue: 48/255, alpha: 1)), forState: .Highlighted)
    editFriendsButton.titleLabel?.font = UIFont(name: "Lato-Light", size: 24)
    editFriendsButton.titleLabel?.adjustsFontSizeToFitWidth = true
    editFriendsButton.tintColor = UIColor.whiteColor()
    editFriendsButton.setTitle("Edit Friends", forState: .Normal)
    editFriendsButton.addTarget(self, action: #selector(MenuController.editFriendsButtonPressed), forControlEvents: .TouchUpInside)
    view.addSubview(editFriendsButton)

    
    }
    
    // MARK: Table View Config
    func createTableView() {
        tableView.removeFromSuperview()
        layer = Size(x: 0, y: 326, width: 276, height: 360)
        tableView = UITableView(frame: CGRect(x: layer.x, y: layer.y, width: layer.width, height: layer.height))
        tableView.backgroundColor = UIColor.clearColor()
        tableView.registerClass(MenuCell.self, forCellReuseIdentifier: "menuCell")
        tableView.dataSource = self
        tableView.delegate = self
        //        tableView.layer.cornerRadius = 10
        layer = Size(x: 0, y: 0, width: 0, height: 90)
        tableView.rowHeight = layer.height
        tableView.separatorStyle = .None
        
        view.addSubview(tableView)
        
    }
    
    
}