//
//  AppDelegate.swift
//  Secret Message
//
//  Created by Митько Евгений on 25.02.16.
//  Copyright © 2016 Evgeny Mitko. All rights reserved.
//

import UIKit

var backendless = Backendless.sharedInstance()
let screenHeight = UIScreen.mainScreen().bounds.size.height
let screenWidth = UIScreen.mainScreen().bounds.size.width


let progressViewManager = MediumProgressViewManager.sharedInstance

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let APP_ID = "B98036D8-4C4B-8D51-FF42-E6C0E74CF800"
    let SECRET_KEY = "B57F0C4D-A9ED-627C-FFA4-C7701AC14300"
    let VERSION_NUM = "v1"
    
    

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        UIApplication.sharedApplication().statusBarStyle = .LightContent
//        let config = KCSClientConfiguration(appKey: "kid_b1hiA_yd1-", secret: "a5b3854c24b3445dabf46ab88ee03542")
//        KCSClient.sharedClient().initializeWithConfiguration(config)
//        application.registerForRemoteNotifications()
//        application.registerUserNotificationSettings(UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil))
        
        backendless.initApp(APP_ID, secret:SECRET_KEY, version:VERSION_NUM)
        //MARK: Progress Bar Properties
        progressViewManager.color = UIColor(red: 46/255, green: 196/255, blue: 182/255, alpha: 1)
        progressViewManager.height = 2
        
        return true
    }
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        let deviceTokenStr = backendless.messagingService.deviceTokenAsString(deviceToken)
        
        
        backendless.messagingService.registerDevice([activeUser.objectId])
          let deviceRegistrationId = backendless.messagingService.registerDeviceToken(deviceTokenStr)
            print("deviceToken = \(deviceTokenStr), deviceRegistrationId = \(deviceRegistrationId))")
        backendless.messagingService.subscribe(activeUser.objectId, response: { (responde) in
            
            }) { (error) in
                print(error.description)
        }
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        NSNotificationCenter.defaultCenter().postNotificationName("newMessage", object: nil)
        print("I have a notification")
        UIApplication.sharedApplication().applicationIconBadgeNumber += 1
     }
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        print(error.description)
    }
        func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

