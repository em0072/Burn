//
//  ImageViewController.swift
//  Secret Message
//
//  Created by Митько Евгений on 17.03.16.
//  Copyright © 2016 Evgeny Mitko. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import CoreMedia



class ImageViewController: UIViewController, UINavigationControllerDelegate {
    
    var fileType = String()
    var imageView = UIImageView()
    var videoURL = NSURL()
    
    var moviePlayer = AVPlayerViewController()
    var message = Messages()
    
    var recipientList = [BackendlessUser]()
    
    override func viewDidLoad() {
            super.viewDidLoad()
         layoutView()
        
        if message.fileType == "image" {
            downloadImage()
            let senderName = message.senderName
            print("This is recepients for this message \(message.recepients![0].name)")
            self.navigationItem.title = "From: \(senderName!)"
        } else {
            
            
                imageView.image = videoSnapshot(videoURL)
            
        }

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewWillAppear(true)
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(true)
    }
    
    
    
    func videoSnapshot(vidURL: NSURL) -> UIImage? {
        let size = Size(x: 162, y: 323, width: 90, height: 90)
        
        let playButton = UIButton(frame: CGRect(x: size.x, y: size.y, width: size.width, height: size.height))
        playButton.setImage(UIImage(named: "playButton")!, forState: .Normal)
        playButton.setImage(UIImage(named: "playButtonPressed")!, forState: .Highlighted)
        playButton.addTarget(self, action: #selector(ImageViewController.playVideo), forControlEvents: .TouchUpInside)
        view.addSubview(playButton)

        
        
        
        let asset = AVURLAsset(URL: vidURL)
        let generator = AVAssetImageGenerator(asset: asset)
        generator.appliesPreferredTrackTransform = true
        
        let timestamp = CMTime(seconds: 1, preferredTimescale: 60)
        
        do {
            let imageRef = try generator.copyCGImageAtTime(timestamp, actualTime: nil)
            return UIImage(CGImage: imageRef)
        }
        catch let error as NSError
        {
            print("Image generation failed with error \(error)")
            return nil
        }
    }

    func playVideo() {
        print("Start to play video")
        let player = AVPlayer(URL: videoURL)
        moviePlayer.player = player
        presentViewController(self.moviePlayer, animated: true, completion: {
                self.moviePlayer.player!.play()
        })
    }
    
    func report () {
        let alertController = DOAlertController(title: "Report", message: "Do you want to report or block this user?", preferredStyle: .ActionSheet)
        // Create the action.
        let ReportAction = DOAlertAction(title: "Report", style: .Default) { action in
            NSLog("ReportAction action occured.")
            self.reportAction()
        }
        // Create the action.
        let BlockAction = DOAlertAction(title: "Report and Block user", style: .Destructive) { action in
            NSLog("BlockAction action occured.")
            self.blockUser()
        }
        let CancelAction = DOAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        alertController.titleFont = UIFont(name: "Lato-Regular", size: 18)
        alertController.titleTextColor = UIColor.blackColor()
        alertController.messageFont = UIFont(name: "Lato-Light", size: 16)
        alertController.messageTextColor = UIColor.blackColor()
        alertController.buttonFont[.Default] = UIFont(name: "Lato-Regular", size: 16)
        alertController.buttonTextColor[.Default] = UIColor.whiteColor()

        // Add the action.
        alertController.addAction(ReportAction)
        alertController.addAction(BlockAction)
        alertController.addAction(CancelAction)
        
        // Show alert
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    func reportAction () {
        print("StartReport Action")
        var serchResult = [BackendlessUser]()
        let adminObjectId = "E93B7920-090D-4217-FF79-DD1966194C00"
        let whereClause = "objectId = '\(adminObjectId)'"
        let dataQuery = BackendlessDataQuery()
        dataQuery.whereClause = whereClause
        
        var error: Fault?
        let bc = backendless.data.of(BackendlessUser.ofClass()).find(dataQuery, fault: &error)
        if error == nil {
            print("Contacts have been found: \(bc.data)")
            serchResult = bc.getCurrentPage() as! [BackendlessUser]
            print("Search Results \(serchResult)")
            for user in serchResult {
                if user.name == "admin" {
                        print("new sender = \(user.name)")
                self.recipientList.append(user)
                    
                }
            }
            print("new sender = \(recipientList)")
        message.recepients = recipientList
        let dataStore = backendless.data.of(Message.ofClass())
        dataStore.save(message, response: { (result) in
            self.sendPush(self.message.recepients![0])
            print("message succkesfully sent")
            self.dismissViewControllerAnimated(true, completion: nil)
//            percentOfCompletion += percentForMessage
//            ARSLineProgress.updateWithProgress(CGFloat(percentOfCompletion))
//            if i == self.sendList.count - 1 {
//                ARSLineProgress.showSuccess()
//                self.sendList.removeAll()
//                self.clearImageVideoSendListAndDissmis()
//            }
            }, error: { (error) in
                let title = NSLocalizedString("Try Again!", comment: "account success note title")
                let message = NSLocalizedString("Please, capture a photo/video or pick one in photo library", comment: "account success message body")
                print(error)
//                ARSLineProgress.showFail()
                Utility.simpleAlert(title, message: message, sender: self)
        })
    }
    }
    
    func blockUser() {
        let senderId = message.senderId
        print("senderId = \(senderId)")
        var blockingSender = BackendlessUser()
        var serchResult = [BackendlessUser]()

        let whereClause = "objectId = '\(senderId!)'"
        let dataQuery = BackendlessDataQuery()
        dataQuery.whereClause = whereClause
        var error: Fault?
        let bc = backendless.data.of(BackendlessUser.ofClass()).find(dataQuery, fault: &error)
        if error == nil {
            print("Contacts have been found: \(bc.data)")
            serchResult = bc.getCurrentPage() as! [BackendlessUser]
            print("Search Results \(serchResult)")
            if serchResult.count > 0 {
                blockingSender = serchResult[0]
                var blockList = loadBlockList()
                blockList.append(blockingSender)
                activeUser.updateProperties(["blockList":blockList])
                backendless.userService.update(activeUser, response: { (updatedUser) in
                    
                    self.reportAction()
                    
                }) { (error) in
                    print(error.description)
                }
            }
            
            
        }
    }
    
    func loadBlockList () -> [BackendlessUser] {
        let dataQuery = BackendlessDataQuery()
        dataQuery.whereClause = "Users[blockList].objectId = \'\(activeUser.objectId)\'"
        
        var error: Fault?
        let bc = backendless.data.of(BackendlessUser.ofClass()).find(dataQuery, fault: &error)
        if error == nil {
            print("Contacts have been found: \(bc.data.count)")
            let blockArray = bc.data as! [BackendlessUser]
            return blockArray
        }
        else {
            print("Server reported an error: \(error)")
            return []
        }

    }
    
    
        func sendPush(sender: BackendlessUser) {
            let publishOptions = PublishOptions()
            publishOptions.headers = ["ios-badge":"1",
                                      "ios-sound":"Sound12.aif",
                                      "ios-alert":"\(activeUser.name!) send you a message!"]
            //        publishOptions.addHeader("publisher_name", value: activeUser.name)
            
            var error: Fault?
            let messageStatus = backendless.messagingService.publish(sender.objectId, message: "\(activeUser.name!) send you a message!", publishOptions: publishOptions, error: &error)
            if error == nil {
                print("MessageStatus = \(messageStatus.status) ['\(messageStatus.messageId)']")
            }
            else {
                print("Server reported an error: \(error)")
            }
        }

    
    func downloadImage() {
        let stringURL = message.file?.fileURL
        print("StringURL is \(stringURL!)")
        let url = NSURL(string: stringURL!)!
        let urlData = NSData(contentsOfURL: url)
        
        imageView.image = UIImage(data: urlData!)
    }

    
    func dismissView() {
        progressViewManager.show()
        var recipientArray = message.recepients!
        if recipientArray.count == 1 {
            // DeleteIt
            let fileFullURL = message.file!.fileURL
            let fileURLArray = fileFullURL.componentsSeparatedByString("files/")
            
            
            let fileURL = fileURLArray[1]
            print(fileURLArray[1])
            backendless.fileService.remove(fileURL, response: { (respone) in
                print(respone)
                progressViewManager.hide()
                }, error: { (error) in
                    print(error)
            })
            backendless.data.of(Messages.ofClass()).remove(message)
        } else {
            for recipt in recipientArray {
                if recipt.objectId == activeUser.objectId {
                    let index = recipientArray.indexOf(recipt)
                    recipientArray.removeAtIndex(index!)
                    message.recepients = recipientArray
                    var error: Fault?
                    let result = backendless.data.save(message, error: &error) as? Messages
                    if error == nil {
                        print("PhoneBook havs been updated: \(result)")
                        progressViewManager.hide()
                    }
                    else {
                        print("Server reported an error: \(error)")
                    }
                    
                }
            }
        }

        self.dismissViewControllerAnimated(true) {
            
        }
    }
    

    

}

