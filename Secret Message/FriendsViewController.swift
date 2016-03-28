//
//  ViewController.swift
//  Secret Message
//
//  Created by Митько Евгений on 25.02.16.
//  Copyright © 2016 Evgeny Mitko. All rights reserved.
//

import UIKit

class FriendsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var friendsArray: [BackendlessUser] = []
    
    
//    var friendsArray = NSArray()

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        let dataQuery = BackendlessDataQuery()
        dataQuery.whereClause = "Users[userRelations].objectId = \'\(activeUser.objectId)\'"
        
        var error: Fault?
        let bc = backendless.data.of(BackendlessUser.ofClass()).find(dataQuery, fault: &error)
        if error == nil {
                print("Contacts have been found: \(bc.data.count)")
                self.friendsArray = bc.data as! [BackendlessUser]
                self.tableView.reloadData()
        }
        else {
            print("Server reported an error: \(error)")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")!
        let friend = friendsArray[indexPath.row]
        cell.textLabel?.text = friend.name
        return cell
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showAddFriends" {
            let vc = segue.destinationViewController as! EditFriendsViewController
            vc.friendArray = self.friendsArray
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func reload(sender: AnyObject) {
        backendless.userService.logout(
            { ( user : AnyObject!) -> () in
                print("User logged out.")
                self.performSegueWithIdentifier("showLoginAnimated", sender: nil)
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

}

