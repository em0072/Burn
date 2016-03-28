//
//  Utility.swift
//  Secret Message
//
//  Created by Митько Евгений on 20.03.16.
//  Copyright © 2016 Evgeny Mitko. All rights reserved.
//

import UIKit

extension UIImage {
    class func imageWithColor(color: UIColor) -> UIImage {
        let rect = CGRectMake(0.0, 0.0, 1.0, 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextFillRect(context, rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
    func resize(scale:CGFloat)-> UIImage {
        let imageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: size.width*scale, height: size.height*scale)))
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContext(imageView.bounds.size)
        imageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result
    }
    func resizeToWidth(width:CGFloat)-> UIImage {
        let imageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))))
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContext(imageView.bounds.size)
        imageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result
    }
}





class Utility {
    
    static func randomStringWithLength (len : Int) -> NSString {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        
        let randomString : NSMutableString = NSMutableString(capacity: len)
        
        for _ in 0..<len{
            let length = UInt32 (letters.length)
            let rand = arc4random_uniform(length)
            randomString.appendFormat("%C", letters.characterAtIndex(Int(rand)))
        }
        
        return randomString
    }
    
    static func randomWithMinAndMax (min: Int, max: Int) -> Int {
        return Int(arc4random()) % (max - min) + min
    }
    
    
    static func simpleAlert(title: String, message: String, sender: UIViewController) {
        let alertController = DOAlertController(title: title, message: message, preferredStyle: .Alert)
        let okAction = DOAlertAction(title: "OK", style: .Default) { action in
            print("OK action occured.")
        }
        alertController.addAction(okAction)
        alertController.overlayColor = UIColor(red:0/255, green:0/255, blue:0/255, alpha:0.2)
        alertController.alertViewBgColor = UIColor(red: 228/255, green: 228/255, blue: 228/255, alpha: 1)
        alertController.titleFont = UIFont(name: "Lato-Regular", size: 18)
        alertController.titleTextColor = UIColor.blackColor()
        alertController.messageFont = UIFont(name: "Lato-Light", size: 16)
        alertController.messageTextColor = UIColor.blackColor()
        alertController.buttonFont[.Default] = UIFont(name: "Lato-Regular", size: 16.0)
        alertController.buttonTextColor[.Default] = UIColor.whiteColor()
        alertController.buttonBgColor[.Default] = UIColor(red: 46/255, green:196/255, blue:182/255, alpha:1)
        alertController.buttonBgColorHighlighted[.Default] = UIColor(red:39/255, green:171/255, blue:158/255, alpha:1)
        
        sender.presentViewController(alertController, animated: true, completion: {
            progressViewManager.hide()
        })

        
        
    }
    static func simpleAlertWithHandler(title: String, message: String, sender: UIViewController, handler: () -> Void) {
        let alertController = DOAlertController(title: title, message: message, preferredStyle: .Alert)
        let okAction = DOAlertAction(title: "OK", style: .Default) { action in
            print("OK action occured.")
            handler()
        }
        alertController.addAction(okAction)
        alertController.overlayColor = UIColor(red:0/255, green:0/255, blue:0/255, alpha:0.2)
        alertController.alertViewBgColor = UIColor(red: 228/255, green: 228/255, blue: 228/255, alpha: 1)
        alertController.titleFont = UIFont(name: "Lato-Regular", size: 18)
        alertController.titleTextColor = UIColor.blackColor()
        alertController.messageFont = UIFont(name: "Lato-Light", size: 16)
        alertController.messageTextColor = UIColor.blackColor()
        alertController.buttonFont[.Default] = UIFont(name: "Lato-Regular", size: 16)
        alertController.buttonTextColor[.Default] = UIColor.whiteColor()
        alertController.buttonBgColor[.Default] = UIColor(red: 46/255, green:196/255, blue:182/255, alpha:1)
        alertController.buttonBgColorHighlighted[.Default] = UIColor(red:39/255, green:171/255, blue:158/255, alpha:1)
        
        sender.presentViewController(alertController, animated: true, completion: {
            progressViewManager.hide()
            
        })
    }
    
        static func simpleAlertWithTextFieldAndHandler(title: String, message: String, sender: UIViewController, handler: (UITextField) -> Void) {
            let alertController = DOAlertController(title: title, message: message, preferredStyle: .Alert)
            alertController.overlayColor = UIColor(red:0/255, green:0/255, blue:0/255, alpha:0.2)
            alertController.alertViewBgColor = UIColor(red: 228/255, green: 228/255, blue: 228/255, alpha: 1)
            alertController.titleFont = UIFont(name: "Lato-Regular", size: 18)
            alertController.titleTextColor = UIColor.blackColor()
            alertController.messageFont = UIFont(name: "Lato-Light", size: 16)
            alertController.messageTextColor = UIColor.blackColor()
            alertController.buttonFont[.Default] = UIFont(name: "Lato-Regular", size: 16)
            alertController.buttonTextColor[.Default] = UIColor.whiteColor()
            alertController.buttonBgColor[.Default] = UIColor(red: 46/255, green:196/255, blue:182/255, alpha:1)
            alertController.buttonBgColorHighlighted[.Default] = UIColor(red:39/255, green:171/255, blue:158/255, alpha:1)
            var emailField = UITextField()
            alertController.addTextFieldWithConfigurationHandler { textField in
                textField.placeholder = "Email address:"
                textField.autocapitalizationType = .None
                
                emailField = textField
            }
            let okAction = DOAlertAction(title: "OK", style: .Default) { action in
                print("OK action occured.")
                handler(emailField)
            }
            let cancelAction = DOAlertAction(title: "Cancel", style: .Destructive, handler: nil)
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)

            
            sender.presentViewController(alertController, animated: true, completion: {
                progressViewManager.hide()
                
            })

        }

    


}


