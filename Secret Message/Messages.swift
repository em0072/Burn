//
//  Message.swift
//  Secret Message
//
//  Created by Митько Евгений on 16.03.16.
//  Copyright © 2016 Evgeny Mitko. All rights reserved.
//

import UIKit

class Messages : NSObject {
    
    var file : BackendlessFile?
    var fileType : String?
    var senderId: String?
    var senderName: String?
    var recepients: [BackendlessUser]?
    var senderEmail: String?
    var created: NSDate?
    


}


