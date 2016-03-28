//
//  EditFriendsViewController.swift
//  Secret Message
//
//  Created by Митько Евгений on 14.03.16.
//  Copyright © 2016 Evgeny Mitko. All rights reserved.
//

import UIKit

class EditFriendsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    
    var searchUserField = UITextField()
    var tableView = UITableView()
    var titleLabel = UILabel()
    
    
    var userArray = [BackendlessUser]()
    var friendArray = [BackendlessUser]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layoutView()
        fecthAllContacts()
        
        print(friendArray)
        
    }
    
    //MARK: TableView Delegates
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("friendCell") as! FriendsListCell
        let friend = userArray[indexPath.row]
        cell.setCell(friend)
        
        if self.isFriend(friend) {
//            cell.accessoryType = .Checkmark
            cell.oval.image = UIImage(named: "checkIcon")!
            cell.checked = true
        } else {
//            cell.setCheckIcon()
            cell.oval.image = UIImage(named: "plusIcon")!
            cell.checked = false
//            cell.accessoryType = .None
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! FriendsListCell
        let user = userArray[indexPath.row]
        print(friendArray)
        
        if isFriend(user) {
            cell.oval.image = UIImage(named: "plusIcon")!
            var index = Int()
            for friend in friendArray {
                if friend.objectId == user.objectId {
                    index = friendArray.indexOf(friend)!
                }
            }
            friendArray.removeAtIndex(index)
        } else {
            cell.oval.image = UIImage(named: "checkIcon")!
            friendArray.append(user)
            print("friend \(user.name) added")
        }
        activeUser.updateProperties(["userRelations":friendArray])
                print("row number \(indexPath.row) touched it is - \(userArray[indexPath.row].name)")
        backendless.userService.update(activeUser, response: { (updatedUser) in
            print("\(user.name) is updated in \(activeUser.name) friends")
            }) { (error) in
                print(error.description)
        }
        
    
    }
    
    //MARK: Delegates Methodes
    
    
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        let nextTag: NSInteger = textField.tag + 1;
        // Try to find next responder
        if let nextResponder: UIResponder! = textField.superview!.viewWithTag(nextTag){
            nextResponder.becomeFirstResponder()
        }
        else {
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
        }
        return false // We do not want UITextField to insert line-breaks.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }

    
    //MARK: Helper methods
    
    func isFriend(user: BackendlessUser) -> Bool {
        for friend in friendArray {
            if friend.objectId == user.objectId {
                return true
            }
        }
        return false
    }

    func fecthAllContacts() {
        let dataStore = backendless.data.of(BackendlessUser.ofClass())
        
        dataStore.find(
            { (result: BackendlessCollection!) -> Void in
                let contacts = result.getCurrentPage()
                self.userArray = contacts as! [BackendlessUser]
                
                
                
                
                self.tableView.reloadData()
            },
            error: { (fault: Fault!) -> Void in
                print("Server reported an error: \(fault)")
        })

    }
    
    
    //MARK: IBActions
    
    func closeEdit() {
        NSNotificationCenter.defaultCenter().postNotificationName("dismissMenu", object: nil)
        self.dismissViewControllerAnimated(true) { 
            
        }
        
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        titleLabel.text = "Search"
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        titleLabel.text = "All Contacts"
    }
    
    
    func searchFieldDidEdit(textField: UITextField) {
        let usernameString = searchUserField.text!
        
        let whereClause = "name LIKE '\(usernameString)%'"
        let dataQuery = BackendlessDataQuery()
        dataQuery.whereClause = whereClause
        
        var error: Fault?
        let bc = backendless.data.of(BackendlessUser.ofClass()).find(dataQuery, fault: &error)
        if error == nil {
            print("Contacts have been found: \(bc.data)")
            userArray = bc.getCurrentPage() as! [BackendlessUser]
            self.tableView.reloadData()
        }
        else {
            print("Server reported an error: \(error)")
        }
        
    }

    
}
