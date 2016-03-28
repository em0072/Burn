//
//  EditFriendsView.swift
//  Burn
//
//  Created by Митько Евгений on 24.03.16.
//  Copyright © 2016 Evgeny Mitko. All rights reserved.
//

import UIKit

extension EditFriendsViewController {
    
    func layoutView () {
    
        var layer = Size(x: 0, y: 0, width: 414, height: 70)
        let navBar = UIView(frame: CGRect(x: layer.x, y: layer.y, width: layer.width, height: layer.height))
        navBar.backgroundColor = UIColor(red: 30/255, green: 36/255, blue: 39/255, alpha: 1)
        view.addSubview(navBar)
        
        layer = Size(x: 0, y: 29, width: 414, height: 25)
        titleLabel = UILabel(frame: CGRect(x: layer.x, y: layer.y, width: layer.width, height: layer.height))
        titleLabel.font = UIFont(name: "Lato-Light", size: 21)
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.textAlignment = .Center
        titleLabel.text = "All Contacts"
        view.addSubview(titleLabel)
        

        
    layer = Size(x: 0, y: 686, width: 414, height: 50)
    let doneButton = UIButton(frame: CGRect(x: layer.x, y: layer.y, width: layer.width, height: layer.height))
    doneButton.backgroundColor = UIColor(red: 39/255, green: 171/255, blue: 158/255, alpha: 1)
    doneButton.setBackgroundImage(UIImage.imageWithColor(UIColor(red: 39/255, green: 171/255, blue: 158/255, alpha: 1)), forState: .Highlighted)
    doneButton.setTitle("Done", forState: .Normal)
    doneButton.addTarget(self, action: #selector(EditFriendsViewController.closeEdit), forControlEvents: .TouchUpInside)
    view.addSubview(doneButton)
    
        
        layer = Size(x: 0, y: 70, width: 414, height: 47)
        let searchUserFieldBack = UIImageView(frame: CGRect(x: layer.x, y: layer.y, width: layer.width, height: layer.height))
        searchUserFieldBack.image = UIImage(named: "searchField")!
        view.addSubview(searchUserFieldBack)
        
        
        layer = Size(x: 10, y: 70, width: 394, height: 47)
        searchUserField = UITextField(frame: CGRect(x: layer.x, y: layer.y, width: layer.width, height: layer.height))
        searchUserField.tag = 0
        searchUserField.delegate = self
        searchUserField.addTarget(self, action: #selector(EditFriendsViewController.searchFieldDidEdit(_:)), forControlEvents: .EditingChanged)
       
        searchUserField.autocapitalizationType = .None
        searchUserField.attributedPlaceholder = NSAttributedString(string:"Email address:", attributes:[NSForegroundColorAttributeName: UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1)])
        searchUserField.textColor = UIColor.whiteColor()
        searchUserField.font = UIFont(name: "Lato-Light", size: 16)
        searchUserField.returnKeyType = .Next
        view.addSubview(searchUserField)
    
        
        
            layer = Size(x: 0, y: 115, width: 414, height: (571))
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
    
    }
    
    
    
}
