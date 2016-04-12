//
//  InboxViewController.swift
//  Secret Message
//
//  Created by Митько Евгений on 13.03.16.
//  Copyright © 2016 Evgeny Mitko. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import CoreMedia



var activeUser = backendless.userService.currentUser
var downloadProgress = CGFloat()
var registerForNotifications = true





class InboxViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AVPlayerViewControllerDelegate, UINavigationControllerDelegate, NSURLSessionDownloadDelegate, FlowingMenuDelegate {

    var itemLayer = Size(x: 0, y: 0, width: 0, height: 0)
    var tableView = UITableView()
    var imagePickerLibraryButton = UIButton()
    var imagePickerCameraButton = UIButton()
    var videoUrl = NSURL()
    let flowingMenuTransitionManager = FlowingMenuTransitionManager()
    let refreshControl = SpringIndicator.Refresher()
    var noMessageLabel = UILabel()
//    let videoURL = NSURL()
    
    
    //MARK: Stored Properties
    var messageToPass = Messages()
   
    let logInTransition = ElasticTransition()
    var menu = UIViewController()
    
    var messageArray = [Messages]()
    
    
    //MARK: View Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.sharedApplication().applicationIconBadgeNumber = 0

        registerForNotifications = NSUserDefaults.standardUserDefaults().boolForKey("registerForNotifications")
        
        self.view.backgroundColor = UIColor(red: 65/255, green: 70/255, blue: 72/255, alpha: 1)
        layoutInboxView()
        
        
        
        //ADD Pull to refresh
        refreshControl.indicator.lineColor = UIColor(red: 46/255, green: 196/255, blue: 182/255, alpha: 1)
        refreshControl.addTarget(self, action: #selector(InboxViewController.reloadInbox), forControlEvents: .ValueChanged)

        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(InboxViewController.logout(_:)),name:"logout", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(InboxViewController.dismissMenu(_:)),name:"dismissMenu", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(InboxViewController.newNotification(_:)),name:"newMessage", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(InboxViewController.openMenu(_:)),name:"openMenu", object: nil)
        
        //Elastic Transition Config
        logInTransition.panThreshold = 0.4
        logInTransition.transformType = .TranslateMid

        // Add the pan screen edge gesture to the current view
        flowingMenuTransitionManager.setInteractivePresentationView(view)
        // Add the delegate to respond to interactive transition events
        flowingMenuTransitionManager.delegate = self
        
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.hidden = false

       layoutInboxView()
        
        
        if activeUser == nil {
            performSegueWithIdentifier("showLogin", sender: nil)
            registerForNotifications = false
        } else {
            print("User \(activeUser.name) is logged in")
        }
        
        if registerForNotifications == false {
            UIApplication.sharedApplication().registerForRemoteNotifications()
            UIApplication.sharedApplication().registerUserNotificationSettings(UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil))
            registerForNotifications = true
            NSUserDefaults.standardUserDefaults().setBool(registerForNotifications, forKey: "registerForNotifications")
        } else {
            print("User already registered for notifications")
        }

        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        
        loadNewMessages()
        
            }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.navigationBar.hidden = true
    }
    
    

    // MARK: TableView Delegate Methods
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messageArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! InboxCell
        cell.setCell(messageArray[indexPath.row])
        
        
//        let message = messageArray[indexPath.row]
//        cell.textLabel?.text = message.senderName!
//        
//        if message.fileType! == "image" {
//            cell.imageView?.image = UIImage(named: "imageType")
//        } else {
//            cell.imageView?.image = UIImage(named: "videoType")
//        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        let cell = tableView.cellForRowAtIndexPath(indexPath)
        messageToPass = messageArray[indexPath.row]
        if messageToPass.fileType! == "image" {
            performSegueWithIdentifier("showImage", sender: self)
        } else {
            print("Perform present video")
            let videoFilePath = messageToPass.file!.fileURL
            downloadVideo(videoFilePath)
        
        }
        
        
    }

    // MARK: - FlowingMenu Delegate Methods
    
    func flowingMenuNeedsPresentMenu(flowingMenu: FlowingMenuTransitionManager) {
        performSegueWithIdentifier("showMenu", sender: self)
    }
    
    func flowingMenuNeedsDismissMenu(flowingMenu: FlowingMenuTransitionManager) {
        menu.performSegueWithIdentifier("closeMenu", sender: self)
    }
    
    func dismissMenu(notification: NSNotification) {
        menu.performSegueWithIdentifier("closeMenu", sender: self)
    }
    
    func openMenu(notification: NSNotification) {
        performSegueWithIdentifier("showMenu", sender: self)
        NSNotificationCenter.defaultCenter().postNotificationName("openEditFriends", object: nil)
    }

    
    
    //MARK: Helper Methods
    func reloadInbox() {
        loadNewMessages()
        
    }
    
    func newNotification(notification: NSNotification) {
        print("i get a notification and i will reload table")
        // declared system sound here
        let systemSoundID: SystemSoundID = 1003
        
        // to play sound
        AudioServicesPlaySystemSound (systemSoundID)
        loadNewMessages()
    }

    func logout(notification: NSNotification) {
        self.performSegueWithIdentifier("showLoginAnimated", sender: self)
    }
    
    func rollCamera() {
        performSegueWithIdentifier("showCamera", sender: self)
    }
    func openLibrary() {
        performSegueWithIdentifier("showLibrary", sender: self)
    }
    
    func getFileLocalPathByUrl(fileUrl: NSURL) -> NSURL? {
        // create your document folder url
        let documentsUrl =  NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first! as NSURL
        
        // your destination file url
        if let fileName = fileUrl.lastPathComponent {
            let destinationUrl = documentsUrl.URLByAppendingPathComponent(fileName)
            
            if destinationUrl.path != nil && NSFileManager().fileExistsAtPath(destinationUrl.path!) {
                return destinationUrl
            }
        }
        else {
            print("fileName is nil")
        }
        
        return nil
    }

    
        
    func downloadVideo(videoImageUrl:String) {
        
        videoUrl = NSURL(string: videoImageUrl)!
        
            let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration(), delegate: self, delegateQueue: nil)
            let downloadTask = session.downloadTaskWithURL(videoUrl)
            downloadTask.resume()
        ARSLineProgress.showWithProgress(initialValue: 0) {
            print("Loading Complete")
            self.performSegueWithIdentifier("showImage", sender: self)
//            self.deleteVideoFromServer()
//            let player = AVPlayer(URL: self.videoUrl)
//            self.moviePlayer.player = player
//            self.presentViewController(self.moviePlayer, animated: true, completion: {
//                self.moviePlayer.player!.play()
//            })

        }
        
        
    }

    func deleteVideoFromServer() {
    var recipientArray = messageToPass.recepients!
        if recipientArray.count == 1 {
            // DeleteIt
            let fileFullURL = messageToPass.file!.fileURL
            let fileURLArray = fileFullURL.componentsSeparatedByString("files/")
            
            
            let fileURL = fileURLArray[1]
            print(fileURLArray[1])
            backendless.fileService.remove(fileURL, response: { (respone) in
                print(respone)
                }, error: { (error) in
                    print(error)
            })
            backendless.data.of(Messages.ofClass()).remove(messageToPass)
        } else {
            for recipt in recipientArray {
                if recipt.objectId == activeUser.objectId {
                    let index = recipientArray.indexOf(recipt)
                    recipientArray.removeAtIndex(index!)
                    messageToPass.recepients = recipientArray
                    var error: Fault?
                    let result = backendless.data.save(messageToPass, error: &error) as? Messages
                    if error == nil {
                        print("PhoneBook havs been updated: \(result)")
                    }
                    else {
                        print("Server reported an error: \(error)")
                    }
                    
                }
            }
        }

        
    }
    
    func loadNewMessages() {
        progressViewManager.show()
        if let user = backendless.userService.currentUser {
            let whereClause = "recepients.objectId = '\(user.objectId)'"
            let dataQuery = BackendlessDataQuery()
            dataQuery.whereClause = whereClause
            
            backendless.data.of(Messages.ofClass()).find(dataQuery, response: { (result) in
                self.messageArray = result.data as! [Messages]
                print("There are \(self.messageArray.count) messages")
                progressViewManager.hide()
                self.refreshControl.endRefreshing()
                
                if self.messageArray.count == 0 {
                    self.noMessageLabel.text = "You have no messages"
                } else {
                     self.noMessageLabel.text = ""
                }
                
                self.tableView.reloadData()
            }) { (error) in
                print(error)
                progressViewManager.hide()
            }
            
        }
        
    }
    
    
    // #MARK: - NSURLSessionDownloadDelegate
    func storeFileLocally(remoteFileUrl: NSURL, data: NSData?) {
        // create your document folder url
        let documentsUrl =  NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first! as NSURL
        
        // your destination file url
            let fileName = "video.mov"
            let destinationUrl = documentsUrl.URLByAppendingPathComponent(fileName)
            
            if let data = data {
                if data.writeToURL(destinationUrl, atomically: true) {
                    
                    print("file saved at \(destinationUrl)")
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.videoUrl = destinationUrl
                    })
                }
                else {
                    ARSLineProgress.showFail()
                    print("error saving file")
                }
            }
    }

    
    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didFinishDownloadingToURL location: NSURL) {
        // println("download task did finish")
        
        let videoUrl = downloadTask.originalRequest!.URL
        
        if let data = NSData(contentsOfURL: location) {
            storeFileLocally(videoUrl!, data: data)
            
            dispatch_async(dispatch_get_main_queue()) {
                
            }
        }
    }

    
    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        // println("download task did write data")
        dispatch_async(dispatch_get_main_queue()) {
        let progress = (CGFloat(totalBytesWritten) / CGFloat(totalBytesExpectedToWrite)) * 100
        
            print(progress)
            
            ARSLineProgress.updateWithProgress(progress)
        }
    }

    
    // MARK: Segue Methods
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showLogin" {
            self.navigationController?.delegate = logInTransition
            let vc = segue.destinationViewController as! LoginController
            
            vc.transitioningDelegate = logInTransition
            vc.modalPresentationStyle = .Custom
            
        } else if segue.identifier == "showLoginAnimated" {
            self.navigationController?.delegate = logInTransition
            let vc = segue.destinationViewController as! LoginController
            vc.transitioningDelegate = logInTransition
            vc.modalPresentationStyle = .Custom
        } else if segue.identifier == "showImage" {
            let vc = segue.destinationViewController as! ImageViewController
            vc.message = messageToPass
            vc.videoURL = videoUrl
        } else if segue.identifier == "showCamera" {
            let vc = segue.destinationViewController as! CameraViewController
            vc.imagePicker.sourceType = .Camera
        } else if segue.identifier == "showLibrary" {
            let vc = segue.destinationViewController as! CameraViewController
            vc.imagePicker.sourceType = .PhotoLibrary
        } else  if segue.identifier == "showMenu" {
            let vc = segue.destinationViewController as! MenuController
            vc.transitioningDelegate = flowingMenuTransitionManager
            flowingMenuTransitionManager.setInteractiveDismissView(vc.view)
            menu = vc
        }


    }
    
    
    // MARK: IBActions
    
    @IBAction func unwindToMainViewController(sender: UIStoryboardSegue) {
    }
    
        
}
