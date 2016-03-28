//
//  FriendsListCell.swift
//  Burn
//
//  Created by Митько Евгений on 24.03.16.
//  Copyright © 2016 Evgeny Mitko. All rights reserved.
//

import UIKit

class FriendsListCell: UITableViewCell {

    var itemLayer = Size(x: 0, y: 0, width: 0, height: 0)
    var friendName = UILabel()
    var friendEmail = UILabel()
    var oval = UIImageView()
    var plus1 = UIView()
    var plus2 = UIView()
    var checked = false
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .Default, reuseIdentifier: "friendCell")
        self.backgroundColor = UIColor.clearColor()
        self.backgroundView = UIImageView(image: UIImage(named: "CellBackground"))
        self.selectionStyle = .None
        
        itemLayer = Size(x: 30, y: 16, width: 300, height: 29)
        friendName = UILabel(frame: CGRect(x: itemLayer.x, y: itemLayer.y, width: itemLayer.width, height: itemLayer.height))
        friendName.font = UIFont(name: "Lato-Regular", size: 22)
        friendName.adjustsFontSizeToFitWidth = true
        friendName.textColor = UIColor.whiteColor()
        self.addSubview(friendName)
        
        itemLayer = Size(x: 30, y: 45, width: 300, height: 29)
        friendEmail = UILabel(frame: CGRect(x: itemLayer.x, y: itemLayer.y, width: itemLayer.width, height: itemLayer.height))
        friendEmail.font = UIFont(name: "Lato-Light", size: 22)
        friendEmail.adjustsFontSizeToFitWidth = true
        friendEmail.textColor = UIColor.whiteColor()
        self.addSubview(friendEmail)
        
        itemLayer = Size(x: 346, y: 25, width: 40, height: 40)
        oval = UIImageView(frame: CGRect(x: itemLayer.x, y: itemLayer.y, width: itemLayer.width, height: itemLayer.height))
        oval.image = UIImage(named: "plusIcon")!
        oval.tintColor = UIColor.whiteColor()
        self.addSubview(oval)
        
       
        
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    

    func setCell(user: BackendlessUser) {
        friendName.text = user.name
        friendEmail.text = user.email
    }
    
}
