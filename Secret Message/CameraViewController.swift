//
//  CameraViewController.swift
//  Secret Message
//
//  Created by Митько Евгений on 15.03.16.
//  Copyright © 2016 Evgeny Mitko. All rights reserved.
//

import UIKit
import MobileCoreServices

class CameraViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    var tableView = UITableView()
    let imagePicker = UIImagePickerController()
    var image: UIImage?
    var mediaIsSelected = false
    var videoFilePath: String?
    var friendsArray: [BackendlessUser] = []
    var sendList: [BackendlessUser] = []
    var noContactsLabel = UILabel()
    var editFriendsButton = UIButton()
    
    //MARK: View Flow
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.hidden = true
        
        
        
        
        if !(mediaIsSelected) {
            imagePicker.delegate = self
            imagePicker.allowsEditing = false
            imagePicker.videoMaximumDuration = 30
            imagePicker.videoQuality = .TypeLow
            imagePicker.mediaTypes = [kUTTypeImage as String, kUTTypeMovie as String]
            
            imagePicker.mediaTypes = UIImagePickerController.availableMediaTypesForSourceType(imagePicker.sourceType)! //[kUTTypeImage as String]
            self.presentViewController(imagePicker, animated: false, completion:{
                print("Camera opened")
            })
        }
//        else {
        
            print("Load Contacts")
            mediaIsSelected = false
            let dataQuery = BackendlessDataQuery()
            dataQuery.whereClause = "Users[userRelations].objectId = \'\(activeUser.objectId)\'"
            
            backendless.data.of(BackendlessUser.ofClass()).find(dataQuery, response: { (bc) in
                print("Contacts have been found: \(bc.data.count)")
                self.friendsArray = bc.data as! [BackendlessUser]
                
                
                if self.friendsArray.count == 0 {
                    self.noContactsLabel.text = "You have no contacts.\nPress 'Edit Button' to add some"
                    self.editFriendsButton.hidden = false
                } else {
                    self.noContactsLabel.text = ""
                    self.editFriendsButton.hidden = true
                }
                self.tableView.reloadData()
            
            }) { (error) in
                print("Server reported an error: \(error)")
            
        
        }
        
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        self.navigationController?.navigationBar.hidden = true
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.navigationBar.hidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutView()
    }
    
    
    
    
    //MARK: tableView Delegates
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("friendCell") as! FriendsListCell
        let user = friendsArray[indexPath.row]
        cell.setCell(user)
        if sendList.contains(user) {
            cell.oval.image = UIImage(named: "checkIcon")!
            cell.checked = true
        } else {
            cell.oval.image = UIImage(named: "emptyCheck")!
            cell.checked = false
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! FriendsListCell
        let user = friendsArray[indexPath.row]
        
        if cell.checked == false {
            cell.oval.image = UIImage(named: "checkIcon")!
            cell.checked = true
            sendList.append(user)
        } else {
            cell.oval.image = UIImage(named: "emptyCheck")!
            cell.checked = false
            for friend in sendList {
                if friend.objectId == user.objectId {
                    if let index = sendList.indexOf(friend) {
                        sendList.removeAtIndex(index)
                    }
                }
            }
        }
        print("Send to \(sendList.count) friends")
    }
    
    //MARK: ImagePicker Delegates
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(false) {}
        self.navigationController?.popViewControllerAnimated(false)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let mediaType: String = info[UIImagePickerControllerMediaType] as! String
        if mediaType == kUTTypeImage as String {
            //Photo is taken or selected
            image = info[UIImagePickerControllerOriginalImage] as? UIImage
            if imagePicker.sourceType == .Camera {
                //save Image ?
            }
        } else {
            //Video is taken or selected
            videoFilePath = (info[UIImagePickerControllerMediaURL]?.path)!
            if imagePicker.sourceType == .Camera {
                //save Video ?
            }
        }
        mediaIsSelected = true
        self.navigationController?.navigationBar.hidden = true
        self.dismissViewControllerAnimated(true, completion: {})
       
    }
    
    //MARK: Button Selectors
    
    func cancelButtonPressed() {
        clearImageVideoSendListAndDissmis()
    }
    
    func sendButtonPressed() {
        if (image == nil) && (videoFilePath?.characters.count == 0) {
            let title = NSLocalizedString("Try Again!", comment: "account success note title")
            let message = NSLocalizedString("Please, capture a photo/video or pick one in photo library", comment: "account success message body")
            Utility.simpleAlert(title, message: message, sender: self)
            
        } else {
            if sendList != [] {
                ARSLineProgress.showWithProgress(initialValue: 0)
                self.uploadMessage()
            }
        }
    }
    
    //MARK: Helper Methods
    
    func editFriends() {
        NSNotificationCenter.defaultCenter().postNotificationName("openMenu", object: nil)
        self.navigationController?.popToRootViewControllerAnimated(true)
        
    }
    
    func uploadMessage() {
        let data: NSData
        var fileName: String
        var fileType: String
        let percentForMessage = 100 / sendList.count
        var percentOfCompletion = 0
        
        if image != nil {
//            let newImage = resizeImage(image!)
           let newImage =  image!.resize(0.3)
            data = UIImageJPEGRepresentation(newImage, 0.5)!
            fileName = "image\( NSDate().timeIntervalSince1970).jpg"
            fileType = "image"
            
        } else {
            let url = NSURL(fileURLWithPath: videoFilePath!)
            data = NSData(contentsOfURL: url)!
            fileName = "video\( NSDate().timeIntervalSince1970).mov"
            fileType = "video"
        }
        
        
        for i in 0..<sendList.count {
            if image != nil {
                fileName = "image\( NSDate().timeIntervalSince1970).jpg"
                fileType = "image"
                
            } else {
                fileName = "video\( NSDate().timeIntervalSince1970).mov"
                fileType = "video"
            }
        backendless.fileService.upload(fileName, content: data, response: { (file) in
            let message = Messages()
            message.file = file
            message.fileType = fileType
            message.recepients = [self.sendList[i]]
            message.senderId = activeUser.objectId
            message.senderName = activeUser.name
            message.senderEmail = activeUser.email
            message.created = NSDate()
            
            let dataStore = backendless.data.of(Message.ofClass())
            dataStore.save(message, response: { (result) in
                self.sendPush(message.recepients![0])
                print("message succkesfully sent")
                percentOfCompletion += percentForMessage
                ARSLineProgress.updateWithProgress(CGFloat(percentOfCompletion))
                if i == self.sendList.count - 1 {
                    ARSLineProgress.showSuccess()
                    self.sendList.removeAll()
                    self.clearImageVideoSendListAndDissmis()
                }
                }, error: { (error) in
                    let title = NSLocalizedString("Try Again!", comment: "account success note title")
                    let message = NSLocalizedString("Please, capture a photo/video or pick one in photo library", comment: "account success message body")
                    print(error)
                    ARSLineProgress.showFail()
                    Utility.simpleAlert(title, message: message, sender: self)
            })
        }) { (error) in
            let title = NSLocalizedString("Oooops!", comment: "download failed")
            let message = NSLocalizedString(error.description, comment: "default message for blankField login error")
            ARSLineProgress.showFail()
            Utility.simpleAlert(title, message: message, sender: self)
        }
        }
    }
    

    
    
    
    func clearImageVideoSendListAndDissmis() {
        self.sendList.removeAll()
        image = nil
        videoFilePath = nil
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    func resizeImage (image: UIImage) -> UIImage {
        let imageWidth = image.size.width
        let imageHeight = image.size.height
        var width = Double()
        var height = Double()
        
        if imageWidth <= 1224 {
            width = Double(imageWidth)
        } else {
            width = 1224
        }
        if imageHeight <= 1637 {
            height = Double(imageHeight)
        } else {
            height = 1637
        }
        // 2448 × 3264
        
        let newSize = CGSize(width: width, height: height)
        let newRectangle = CGRect(x: 0, y: 0, width: width, height: height)
        
        //create bitmap & redraw smaller version
        UIGraphicsBeginImageContext(newSize)
        image.drawInRect(newRectangle)
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return resizedImage
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
}
