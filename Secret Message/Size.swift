//
//  Size.swift
//  Secret Message
//
//  Created by Митько Евгений on 19.03.16.
//  Copyright © 2016 Evgeny Mitko. All rights reserved.
//

import UIKit


class Size {
    
//    enum CalculatedHeight: CGFloat {
//        case Screen
//        case Cell
//    }
    
    


    
    var x: CGFloat
    var y: CGFloat
    var width: CGFloat
    var height: CGFloat

    
    init(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) {
            self.x = screenWidth * (x / 414)
            self.y = screenHeight * (y / 736.0)
            self.width = screenWidth * (width / 414)
            self.height = screenHeight * (height / 736.0)
        }
    
    
}

