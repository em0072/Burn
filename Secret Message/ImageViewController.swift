//
//  ImageViewController.swift
//  Secret Message
//
//  Created by Митько Евгений on 17.03.16.
//  Copyright © 2016 Evgeny Mitko. All rights reserved.
//

import UIKit


class ImageViewController: UIViewController, UINavigationControllerDelegate {
    
    var imageView = UIImageView()

    var message = Messages()
    
    override func viewDidLoad() {
            super.viewDidLoad()
        layoutView()
        downloadImage()
        let senderName = message.senderName
        print("This is recepients for this message \(message.recepients![0].name)")
//        self.navigationItem.title = "From: \(senderName!)"
        

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
//        self.navigationController?.navigationBar.hidden = true
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewWillAppear(true)
//        self.navigationController?.navigationBar.hidden = true
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(true)
//        self.navigationController?.navigationBar.hidden = false
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

