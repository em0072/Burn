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

