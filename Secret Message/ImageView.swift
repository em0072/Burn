//
//  ImageView.swift
//  Burn
//
//  Created by Митько Евгений on 24.03.16.
//  Copyright © 2016 Evgeny Mitko. All rights reserved.
//

import UIKit

extension ImageViewController {
    
    func layoutView () {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Background")!)
        
        var layer = Size(x: 0, y: 0, width: 414, height: 70)
        let navBar = UIView(frame: CGRect(x: layer.x, y: layer.y, width: layer.width, height: layer.height))
        navBar.backgroundColor = UIColor(red: 30/255, green: 36/255, blue: 39/255, alpha: 1)
        view.addSubview(navBar)
        
        layer = Size(x: 0, y: 29, width: 414, height: 25)
        let titleLabel = UILabel(frame: CGRect(x: layer.x, y: layer.y, width: layer.width, height: layer.height))
        titleLabel.font = UIFont(name: "Lato-Light", size: 21)
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.textAlignment = .Center
        titleLabel.text = "From \(message.senderName!)"
        view.addSubview(titleLabel)
        
        layer = Size(x: 0, y: 70, width: 415, height: 617)
        imageView = UIImageView(frame: CGRect(x: layer.x, y: layer.y, width: layer.width, height: layer.height))
        imageView.contentMode = .ScaleAspectFit
        view.addSubview(imageView)
        
        
        layer = Size(x: 0, y: 686, width: 414, height: 50)
        let cancelButton = UIButton(frame: CGRect(x: layer.x, y: layer.y, width: layer.width, height: layer.height))
        cancelButton.backgroundColor = UIColor(red: 231/255, green: 29/255, blue: 54/299, alpha: 1)
        cancelButton.setBackgroundImage(UIImage.imageWithColor(UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1)), forState: .Highlighted)
        cancelButton.setTitle("Burn", forState: .Normal)
        cancelButton.addTarget(self, action: #selector(ImageViewController.dismissView), forControlEvents: .TouchUpInside)
        view.addSubview(cancelButton)
        
        layer = Size(x: 374, y: 33, width: 25, height: 25)
        let reportButton = UIButton(frame: CGRect(x: layer.x, y: layer.y, width: layer.width, height: layer.height))
        reportButton.setImage(UIImage(named: "reportButton")!, forState: .Normal)
        reportButton.setImage(UIImage(named: "reportButtonPressed")!, forState: .Highlighted)
        reportButton.addTarget(self, action: #selector(ImageViewController.report), forControlEvents: .TouchUpInside)
        view.addSubview(reportButton)

        
    }
    
    
}
