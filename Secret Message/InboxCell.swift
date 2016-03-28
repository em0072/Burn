//
//  InboxCell.swift
//  Secret Message
//
//  Created by Митько Евгений on 22.03.16.
//  Copyright © 2016 Evgeny Mitko. All rights reserved.
//

import UIKit

class InboxCell: UITableViewCell {
    
    var itemLayer = Size(x: 0, y: 0, width: 0, height: 0)
    var messageTypeImage = UIImageView()
    var senderNameLabel = UILabel()
    var senderEmailLabel = UILabel()
    var dateStampLabel = UILabel()
    var timeStampLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .Default, reuseIdentifier: "cell")
        
        
        itemLayer = Size(x: 20, y: 23, width: 60, height: 44)
        messageTypeImage = UIImageView(frame: CGRect(x: itemLayer.x, y: itemLayer.y, width: itemLayer.width, height: itemLayer.height))
        self.addSubview(messageTypeImage)
        
        itemLayer = Size(x: 96, y: 23, width: 207, height: 24)
        senderNameLabel = UILabel(frame: CGRect(x: itemLayer.x, y: itemLayer.y, width: itemLayer.width, height: itemLayer.height))
        senderNameLabel.font = UIFont(name: "Lato-Regular", size: 20)
        senderNameLabel.adjustsFontSizeToFitWidth = true
        senderNameLabel.textColor = UIColor.whiteColor()
        self.addSubview(senderNameLabel)
        
        itemLayer = Size(x: 96, y: 45, width: 207, height: 23)
        senderEmailLabel = UILabel(frame: CGRect(x: itemLayer.x, y: itemLayer.y, width: itemLayer.width, height: itemLayer.height))
        senderEmailLabel.font = UIFont(name: "Lato-Light", size: 18)
        senderEmailLabel.adjustsFontSizeToFitWidth = true
        senderEmailLabel.textColor = UIColor.whiteColor()
        self.addSubview(senderEmailLabel)
        
        itemLayer = Size(x: 303, y: 23, width: 100, height: 15)
        dateStampLabel = UILabel(frame: CGRect(x: itemLayer.x, y: itemLayer.y, width: itemLayer.width, height: itemLayer.height))
        dateStampLabel.font = UIFont(name: "Lato-Light", size: 12)
        dateStampLabel.adjustsFontSizeToFitWidth = true
        dateStampLabel.textAlignment = .Right
        dateStampLabel.textColor = UIColor.whiteColor()
        self.addSubview(dateStampLabel)
        
        itemLayer = Size(x: 301, y: 38, width: 100, height: 15)
        timeStampLabel = UILabel(frame: CGRect(x: itemLayer.x, y: itemLayer.y, width: itemLayer.width, height: itemLayer.height))
        timeStampLabel.font = UIFont(name: "Lato-Light", size: 12)
        timeStampLabel.adjustsFontSizeToFitWidth = true
        timeStampLabel.textAlignment = .Right
        timeStampLabel.textColor = UIColor.whiteColor()
        self.addSubview(timeStampLabel)

        

    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func setCell (message: Messages) {
        self.backgroundColor = UIColor.clearColor()
        self.backgroundView = UIImageView(image: UIImage(named: "CellBackground"))
        self.selectionStyle = .Gray
        
        if message.fileType == "image" {
            messageTypeImage.image = UIImage(named: "ImageIcon")
        } else {
            messageTypeImage.image = UIImage(named: "VideoIcon")
        }
        
        senderNameLabel.text = message.senderName
        
        senderEmailLabel.text = message.senderEmail
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale.currentLocale()
        dateFormatter.dateFormat = "EE, dd MMM yyyy"
        
        let timeFormatter = NSDateFormatter()
        timeFormatter.locale = NSLocale.currentLocale()
        timeFormatter.dateFormat = "HH:mm:ss"
        
        
        dateStampLabel.text = dateFormatter.stringFromDate(message.created!)
        timeStampLabel.text = timeFormatter.stringFromDate(message.created!)
        
        
    }
    
}
