//
//  MenuCell.swift
//  Burn
//
//  Created by Митько Евгений on 24.03.16.
//  Copyright © 2016 Evgeny Mitko. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {
    
    var itemLayer = Size(x: 0, y: 0, width: 0, height: 0)
    var friendName = UILabel()
    var friendEmail = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .Default, reuseIdentifier: "menuCell")
        self.backgroundColor = UIColor.clearColor()
        self.backgroundView = UIImageView(image: UIImage(named: "CellBackground"))
        self.selectionStyle = .None
        
        itemLayer = Size(x: 25, y: 10, width: 252, height: 36)
        friendName = UILabel(frame: CGRect(x: itemLayer.x, y: itemLayer.y, width: itemLayer.width, height: itemLayer.height))
        friendName.font = UIFont(name: "Lato-Light", size: 30)
        friendName.adjustsFontSizeToFitWidth = true
        friendName.textColor = UIColor.whiteColor()
        self.addSubview(friendName)
        
        itemLayer = Size(x: 25, y: 52, width: 252, height: 29)
        friendEmail = UILabel(frame: CGRect(x: itemLayer.x, y: itemLayer.y, width: itemLayer.width, height: itemLayer.height))
        friendEmail.font = UIFont(name: "Lato-Light", size: 24)
        friendEmail.adjustsFontSizeToFitWidth = true
        friendEmail.textColor = UIColor.whiteColor()
        self.addSubview(friendEmail)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func setCell (friend: BackendlessUser) {
        friendName.text = friend.name
        friendEmail.text = friend.email
        
        


    }
}
