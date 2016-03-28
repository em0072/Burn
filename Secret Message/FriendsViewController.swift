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
    
    //MARK: View Methods

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
    
    
    //MARK: TableView Delegates
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")!
        let friend = friendsArray[indexPath.row]
        cell.textLabel?.text = friend.name
        return cell
    }
    
    // MARK: Segue Methodes
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showAddFriends" {
            let vc = segue.destinationViewController as! EditFriendsViewController
            vc.friendArray = self.friendsArray
        }
    }
    
    

}

