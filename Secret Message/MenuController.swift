//
//  MenuController.swift
//  Burn
//
//  Created by Митько Евгений on 23.03.16.
//  Copyright © 2016 Evgeny Mitko. All rights reserved.
//

import UIKit


class MenuController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tableView = UITableView()
    var layer = Size(x: 0, y: 20, width: 276, height: 44)
    var friendsArray: [BackendlessUser] = []
    var blackList: [BackendlessUser] = []
    var wasInFriends: [BackendlessUser] = []
    var noFriendsLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layoutView()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MenuController.openEditFriends(_:)),name:"openEditFriends", object: nil)
        
                
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        progressViewManager.show()
        
        let dataQuery = BackendlessDataQuery()
        dataQuery.whereClause = "Users[userRelations].objectId = \'\(activeUser.objectId)\'"
        
        var error: Fault?
        let bc = backendless.data.of(BackendlessUser.ofClass()).find(dataQuery, fault: &error)
        if error == nil {
            print("Friends have been found: \(bc.data.count)")
            self.friendsArray = bc.data as! [BackendlessUser]
            
            dataQuery.whereClause = "Users[blockList].objectId = \'\(activeUser.objectId)\'"
            var error: Fault?
            let bcTwo = backendless.data.of(BackendlessUser.ofClass()).find(dataQuery, fault: &error)
            if error == nil {
                print("Contacts in BL have been found: \(bc.data.count)")
                self.blackList = bcTwo.data as! [BackendlessUser]
                
                for blockedUser in self.blackList {
                    for user in friendsArray {
                        if blockedUser.email == user.email {
                            let index = friendsArray.indexOf(user)!
                            friendsArray.removeAtIndex(index)
                            wasInFriends.append(user)
                        }
                    }
                    
                }
                progressViewManager.hide()
                self.tableView.reloadData()
            }
        }
        else {
            print("Server reported an error: \(error)")
        }
    }
    
    
    // MARK: TableView Delegate Methods
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return friendsArray.count
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("menuCell", forIndexPath: indexPath) as! MenuCell
        let friend = friendsArray[indexPath.row]
        
        cell.setCell(friend)
        
        return cell
    }
    
    //MARK: Segue Methodes
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showEditFriends" {
            let vc = segue.destinationViewController as! EditFriendsViewController
            vc.friendArray = self.friendsArray
            vc.blockList = self.blackList
            vc.wasInFriends = self.wasInFriends
        }
    }
    
    //MARK: IBActions
    func logoutButtonPressed() {
        backendless.userService.logout(
            { ( user : AnyObject!) -> () in
                print("User logged out.")
//                self.performSegueWithIdentifier("showLoginAnimated", sender: nil)
                self.dismissViewControllerAnimated(true, completion: {
                    NSNotificationCenter.defaultCenter().postNotificationName("logout", object: nil)
                })
                print("segue done")
            },
            error: { ( error : Fault!) -> () in
                print("Server reported an error: \(error)")
                let title = NSLocalizedString("Oh NO!", comment: "account success note title")
                let message = NSLocalizedString("There is a problem with loginOut!/nCheck your internet connection and try again!", comment: "account success message body")
                let cancelButtonTitle = NSLocalizedString("OK", comment: "OK")
                let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
                let cancelAction = UIAlertAction(title: cancelButtonTitle, style: .Cancel, handler: { (action) in
                    self.navigationController?.popViewControllerAnimated(true)
                })
                alert.addAction(cancelAction)
                self.presentViewController(alert, animated: true, completion: {
                })
        })
        

    }
    
    func editFriendsButtonPressed() {
        performSegueWithIdentifier("showEditFriends", sender: self)
        
    }
    
    //MARK: Notification methods
    
    func openEditFriends (notification: NSNotification){
        performSegueWithIdentifier("showEditFriends", sender: self)
    }
    //Helper Method
    
    
    
}
