//
//  SingUpController.swift
//  Secret Message
//
//  Created by Митько Евгений on 14.03.16.
//  Copyright © 2016 Evgeny Mitko. All rights reserved.
//

import UIKit

class SingUpController: UIViewController, UITextFieldDelegate, ElasticMenuTransitionDelegate {
    
    //MARK: Stored Properties
    var logo = UIImageView()
    var logoBubble = UIImageView()
    var logoLabel = UILabel()
    var usernameField = UITextField()
    var passwordField = UITextField()
    var emailField = UITextField()
    var emailFieldBack = UIImageView()
    var passwordFieldBack = UIImageView()
    var emailIcon = UIImageView()
    var passwordIcon = UIImageView()
    var usernameFieldBack = UIImageView()
    var usernameIcon = UIImageView()
    var signupButton = UIButton()
    var goBackLabel = UILabel()
    var loginButton = UIButton()
    
//    let progressViewManager = MediumProgressViewManager.sharedInstance
    var transition = ElasticTransition()
    let panSignUp = UIScreenEdgePanGestureRecognizer()
    var segue:Bool!
    let animateFieldDistance = screenHeight * (70 / 736)
    var editingIsInProgress = false
    

    //MARK: ViewController Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layerSignupView()
        
                NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SingUpController.keyboardDidHide(_:)), name: UIKeyboardDidHideNotification, object: nil)
    
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.hidden = true

    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.navigationBar.hidden = false
    }

    
    
    func panForLogIn(pan:UIPanGestureRecognizer){
        if pan.state == .Began{
            transition.dissmissInteractiveTransition(self, gestureRecognizer: pan, completion: nil)
        }else{
            transition.updateInteractiveTransition(gestureRecognizer: pan)
        }
    }
    
    
    //MARK: IBActions
    
    func showLogin(sender: AnyObject) {
        transition.edge = .Right
        transition.startingPoint = sender.center
        self.navigationController?.popViewControllerAnimated(true)
    }

    
    func singupButtonPressed(sender: AnyObject) {
        let newUser = BackendlessUser()
        newUser.name = usernameField.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        newUser.password = passwordField.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        newUser.email = emailField.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())

        if (newUser.name.characters.count != 0 && newUser.password.characters.count != 0 && newUser.email.characters.count != 0) {
            progressViewManager.show()
            backendless.userService.registering(newUser, response: { (user) in
                //was successful!
                let title = NSLocalizedString("Account Created", comment: "account success note title")
                let message = NSLocalizedString("Welcome to our community! Now you can log in with your email and password!", comment: "account success message body")
                Utility.simpleAlertWithHandler(title, message: message, sender: self, handler: { 
                    self.navigationController?.popViewControllerAnimated(true)
                })

                }, error: { (error) in
                    //there was an error with the update save
                    let title = NSLocalizedString("Oops..", comment: "Create account failed")
                    let message = error.message
                    Utility.simpleAlert(title, message: message, sender: self)
            })
        } else {
            var title = NSLocalizedString("Oooops!", comment: "username is blank title")
            var message = NSLocalizedString("Something is wrong... Try again, please!", comment: "default message for blankField signup error")
            if newUser.name.characters.count == 0 && newUser.password.characters.count == 0 && newUser.email.characters.count == 0{
                title = NSLocalizedString("Everything is blank?!", comment: "username is blank message body")
                message = NSLocalizedString("You know you have to put something in this fields, do you?", comment: "username is blank message body")
            } else if newUser.password.characters.count == 0 {
                title = NSLocalizedString("Password?!", comment: "username is blank message body")
                message = NSLocalizedString("You can use an empty password, but it's not save!", comment: "username is blank message body")
            } else if newUser.email.characters.count == 0 {
                title = NSLocalizedString("Email?!", comment: "username is blank message body")
                message = NSLocalizedString("You have an email, do you?! Everyone have!", comment: "username is blank message body")
            } else if newUser.name.characters.count == 0 {
                title = NSLocalizedString("Username?!", comment: "username is blank message body")
                message = NSLocalizedString("Why don't you use '\(Utility.randomStringWithLength(Utility.randomWithMinAndMax (3, max: 10)))' as a username?!", comment: "username is blank message body")
            }

            Utility.simpleAlert(title, message: message, sender: self)
            
            
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
    
    
    //MARK: Keybord Methodes
    func keyboardDidShow(notification: NSNotification) {
        if editingIsInProgress == false {
            editingIsInProgress = true
            
                        UIView.animateWithDuration(0.5) {
                self.logoLabel.alpha = 0
                self.logoBubble.transform = CGAffineTransformMakeScale( 0.00001, 0.00001)
                self.emailFieldBack.layer.position.y -= self.animateFieldDistance
                self.emailField.layer.position.y -= self.animateFieldDistance
                self.emailIcon.layer.position.y -= self.animateFieldDistance
                self.usernameFieldBack.layer.position.y -= self.animateFieldDistance
                self.usernameField.layer.position.y -= self.animateFieldDistance
                self.usernameIcon.layer.position.y -= self.animateFieldDistance
                self.passwordField.layer.position.y -= self.animateFieldDistance
                self.passwordFieldBack.layer.position.y -= self.animateFieldDistance
                self.passwordIcon.layer.position.y -= self.animateFieldDistance
                self.signupButton.layer.position.y -= self.animateFieldDistance
            }
        }
        
    }
    
    func keyboardDidHide(notification: NSNotification) {
        if editingIsInProgress == true {
            editingIsInProgress = false
            UIView.animateWithDuration(0.5) {
                self.logoLabel.alpha = 1
                self.logoBubble.transform = CGAffineTransformMakeScale( 1.0, 1.0)
                self.emailFieldBack.layer.position.y += self.animateFieldDistance
                self.emailField.layer.position.y += self.animateFieldDistance
                self.emailIcon.layer.position.y += self.animateFieldDistance
                self.usernameFieldBack.layer.position.y += self.animateFieldDistance
                self.usernameField.layer.position.y += self.animateFieldDistance
                self.usernameIcon.layer.position.y += self.animateFieldDistance
                self.passwordField.layer.position.y += self.animateFieldDistance
                self.passwordFieldBack.layer.position.y += self.animateFieldDistance
                self.passwordIcon.layer.position.y += self.animateFieldDistance
                self.signupButton.layer.position.y += self.animateFieldDistance
            }
        }
    }

    
    
    
}
