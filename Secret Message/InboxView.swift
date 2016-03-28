//
//  InboxView.swift
//  Secret Message
//
//  Created by Митько Евгений on 22.03.16.
//  Copyright © 2016 Evgeny Mitko. All rights reserved.
//

import UIKit

extension InboxViewController {
    
    func layoutInboxView() {
        self.view.backgroundColor = UIColor(red: 65/255, green: 70/255, blue: 72/255, alpha: 1)
        configNavigationBar()
        createTableView()
        createImagePickerButtons()
        
        noMessageLabel.removeFromSuperview()
        let itemLayer = Size(x: 73, y: 281, width: 268, height: 27)
        noMessageLabel = UILabel(frame: CGRect(x: itemLayer.x, y: itemLayer.y, width: itemLayer.width, height: itemLayer.height))
        noMessageLabel.font = UIFont(name: "Lato-Light", size: 22)
        noMessageLabel.textAlignment = .Center
        noMessageLabel.adjustsFontSizeToFitWidth = true
        noMessageLabel.textColor = UIColor.whiteColor()
        
        self.view.addSubview(noMessageLabel)
        
        
        
    }
    
    // MARK: Navigation Bar Config
    func configNavigationBar() {
        self.navigationItem.title = "Inbox"
        let navBar = self.navigationController!.navigationBar
        itemLayer = Size(x: 0, y: 0, width: 414, height: 70)
        navBar.frame = CGRect(x: itemLayer.x, y: itemLayer.y, width: itemLayer.width, height: itemLayer.height)
        navBar.barTintColor = UIColor(red: 30/255, green: 36/255, blue: 39/255, alpha: 1)
        navBar.translucent = false
        navBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Lato-Light", size: 19)!,
                                      NSForegroundColorAttributeName:UIColor.whiteColor()]
        
        
    }
    
    // MARK: Table View Config
    func createTableView() {
        refreshControl.removeFromSuperview()
        tableView.removeFromSuperview()
        itemLayer = Size(x: 0, y: 0, width: 414, height: (616))
        tableView = UITableView(frame: CGRect(x: itemLayer.x, y: itemLayer.y, width: itemLayer.width, height: itemLayer.height))
        tableView.backgroundColor = UIColor(patternImage: UIImage(named: "BackgroundTableView")!)
        tableView.registerClass(InboxCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        //        tableView.layer.cornerRadius = 10
        itemLayer = Size(x: 0, y: 0, width: 0, height: 90)
        tableView.rowHeight = itemLayer.height
        tableView.separatorStyle = .None
        
        view.addSubview(tableView)
        tableView.addSubview(refreshControl)
        
    }
    
    
    
    //MARK: Image Picker Buttons Config
    func createImagePickerButtons() {
        imagePickerCameraButton.removeFromSuperview()
        itemLayer = Size(x: 207, y: 686 - 70, width: 208, height: 50)
        imagePickerCameraButton = UIButton(frame: CGRect(x: itemLayer.x, y: itemLayer.y, width: itemLayer.width, height: itemLayer.height))
        imagePickerCameraButton.backgroundColor = UIColor(red: 46/255, green: 196/255, blue: 182/255, alpha: 1)
        imagePickerCameraButton.setBackgroundImage(UIImage.imageWithColor(UIColor(red: 39/255, green: 171/255, blue: 158/255, alpha: 1)), forState: .Highlighted)
        imagePickerCameraButton.setImage(UIImage(named: "camera_F"), forState: .Normal)
        imagePickerCameraButton.addTarget(self, action: #selector(InboxViewController.rollCamera), forControlEvents: .TouchUpInside)
        view.addSubview(imagePickerCameraButton)
        
        imagePickerLibraryButton.removeFromSuperview()
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
        print("Library button")
        itemLayer = Size(x: 0, y: 686 - 70, width: 206, height: 50)
        } else {
            itemLayer = Size(x: 0, y: 686 - 70, width: 414, height: 50)
        }
        imagePickerLibraryButton = UIButton(frame: CGRect(x: itemLayer.x, y: itemLayer.y, width: itemLayer.width, height: itemLayer.height))
        imagePickerLibraryButton.backgroundColor = UIColor(red: 46/255, green: 196/255, blue: 182/255, alpha: 1)
        imagePickerLibraryButton.setBackgroundImage(UIImage.imageWithColor(UIColor(red: 39/255, green: 171/255, blue: 158/255, alpha: 1)), forState: .Highlighted)
        imagePickerLibraryButton.setImage(UIImage(named: "folder_F"), forState: .Normal)
        imagePickerLibraryButton.addTarget(self, action: #selector(InboxViewController.openLibrary), forControlEvents: .TouchUpInside)
        view.addSubview(imagePickerLibraryButton)
        
        
        
    }
    
    
    
    
}