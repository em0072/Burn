//
//  LoginController.swift
//  Secret Message
//
//  Created by Митько Евгений on 14.03.16.
//  Copyright © 2016 Evgeny Mitko. All rights reserved.
//

import UIKit

class LoginController: UIViewController, UITextFieldDelegate {

    //MARK: Stored Properties
    var emailField = UITextField()
    var passwordField = UITextField()
    var logoDown = UIImageView()
    var logoContainerView = UIView()
    var logoUp = UIImageView()
    var logoUpBack = UIImageView()
    var logoLabel = UILabel()
    var emailFieldBack = UIImageView()
    var passwordFieldBack = UIImageView()
    var emailIcon = UIImageView()
    var passwordIcon = UIImageView()
    var background = UIImageView()
    var loginButton = UIButton()
    var forgotPasswordButton = UIButton()
    var dontHaveAccountLabel = UILabel()
    var signupButton = UIButton()
//    let progressViewManager = MediumProgressViewManager.sharedInstance
    let signUpTransition = ElasticTransition()
    var emailForForgotPasswordField = UITextField()
//    let logInTransition = BubbleTransition()
    
    let animateFieldDistance = screenHeight * (90 / 736)
    var editingIsInProgress = false
    
    

    
    //MARK: ViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        layerLoginView()
        
        
        //Listen for keybord
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardDidShow:", name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LoginController.keyboardDidHide(_:)), name: UIKeyboardDidHideNotification, object: nil)
       
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.hidden = true
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        progressViewManager.hide()
        self.navigationController?.navigationBar.hidden = true
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.navigationBar.hidden = false
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showSignup" {
            self.navigationController?.delegate = signUpTransition
            let vc = segue.destinationViewController as! SingUpController
            vc.transitioningDelegate = signUpTransition
            vc.modalPresentationStyle = .Custom
            vc.segue = true
        }
        
    }

    func panForSignUp(pan:UIPanGestureRecognizer) {
        if pan.state == .Began{
        // Here, you can do one of two things
        // 1. show a viewcontroller directly
            let nextViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("SignUp") as! SingUpController
            nextViewController.segue = false
            nextViewController.transition = signUpTransition
            nextViewController.transitioningDelegate = signUpTransition
            nextViewController.modalPresentationStyle = .Custom
            signUpTransition.edge = .Right
            signUpTransition.startInteractiveTransition(self, toViewController: nextViewController, gestureRecognizer: pan)
        
        }else{
        signUpTransition.updateInteractiveTransition(gestureRecognizer: pan)
        }
    }
    
 
    
    
    //MARK: IBActions
    
   func loginButtonPressed() {
    
        let username = emailField.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        let password = passwordField.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
       
        if (username.characters.count != 0 && password.characters.count != 0) {
            progressViewManager.show()
            //Peform login
            backendless.userService.login(username, password: password, response: { (user) in
                //SUCCESSFUL LOGIN
                //CASH USERNAME AND PASSWORD
                backendless.userService.setStayLoggedIn( true )
                activeUser = backendless.userService.currentUser
                progressViewManager.hide()
//                self.performSegueWithIdentifier("showInbox", sender: self)
                self.navigationController?.popToRootViewControllerAnimated(true)
                }, error: { (error) in
                    let title = NSLocalizedString("Oooops!", comment: "username is blank title")
                    let message = NSLocalizedString(error.message, comment: "default message for blankField login error")
                    Utility.simpleAlert(title, message: message, sender: self)
            })
            } else {
                var title = NSLocalizedString("Oooops!", comment: "username is blank title")
                var message = NSLocalizedString("Something is wrong... Try again, please!", comment: "default message for blankField login error")
                            
                if username.characters.count == 0 && password.characters.count == 0{
                    
                    title = NSLocalizedString("Email and password?!", comment: "username is blank title")
                    message = NSLocalizedString("This is not working like this! I can spend a whole day tring to gess who you are... But i wouldn't!", comment: "username is blank message body")
                } else if password.characters.count == 0 {
                    title = NSLocalizedString("Password?", comment: "username is blank title")
                    message = NSLocalizedString("You know that you need to enter password, right?!", comment: "password is blank message body")
                } else if username.characters.count == 0 {
                    title = NSLocalizedString("Email?", comment: "username is blank title")
                    message = NSLocalizedString("Without email you can't burn messages! Sorry for that!", comment: "username is blank message body")
                }
            Utility.simpleAlert(title, message: message, sender: self)            
                
            }

    }
    
    
    func forgotPassword() {
        var title = NSLocalizedString("Forgot your password?", comment: "username is blank title")
        var message = NSLocalizedString("Enter your email and we will send a 'restore' link to you.", comment: "")
        
        let yesButtonTitle = NSLocalizedString("Ok", comment: "OK")
        let noButtonTitle = NSLocalizedString("Cancel", comment: "OK")
        
        let question = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        question.addTextFieldWithConfigurationHandler(configurationTextField)
        let yesAction = UIAlertAction(title: yesButtonTitle, style: .Default , handler: { (action) in
            progressViewManager.show()
            print(self.emailForForgotPasswordField.text!)
            backendless.userService.restorePassword( "\(self.emailForForgotPasswordField.text!)",
                response:{ ( result : AnyObject!) -> () in
                    title = NSLocalizedString("Succes!", comment: "username is blank title")
                    message = NSLocalizedString("Check your email for 'restore password' link!", comment: "username is blank title")
                    Utility.simpleAlert(title, message: message, sender: self)
                },
                error: { ( fault : Fault!) -> () in
                    title = NSLocalizedString("Ooops!", comment: "username is blank title")
                    message = NSLocalizedString("\(fault.message)", comment: "username is blank title")
                    Utility.simpleAlert(title, message: message, sender: self)
                }
            )
        })
        
        let noAction = UIAlertAction(title: noButtonTitle, style: .Destructive, handler: { (action) in
            print(action)
        })
        
        question.addAction(yesAction)
        question.addAction(noAction)
        
        Utility.simpleAlertWithTextFieldAndHandler(title, message: message, sender: self) { (email) in
            progressViewManager.show()
            print(self.emailForForgotPasswordField.text!)
            print(email.text!)
            backendless.userService.restorePassword( "\(email.text!)",
                                                     response:{ ( result : AnyObject!) -> () in
                                                        title = NSLocalizedString("Succes!", comment: "username is blank title")
                                                        message = NSLocalizedString("Check your email for 'restore password' link!", comment: "username is blank title")
                                                        Utility.simpleAlert(title, message: message, sender: self)
                },
                                                     error: { ( fault : Fault!) -> () in
                                                        title = NSLocalizedString("Ooops!", comment: "username is blank title")
                                                        message = NSLocalizedString("\(fault.message)", comment: "username is blank title")
                                                        Utility.simpleAlert(title, message: message, sender: self)
            })
        }
    }
    
    
    
    func showSignup(sender: AnyObject) {
        signUpTransition.edge = .Right
        signUpTransition.startingPoint = sender.center
        performSegueWithIdentifier("showSignup", sender: self)
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
            
            UIView.transitionWithView(logoContainerView, duration: 0.5, options: .TransitionFlipFromTop, animations: {
                self.logoUp.removeFromSuperview()
                self.logoContainerView.addSubview(self.logoUpBack)
                }, completion: { (true) in
            })
            UIView.animateWithDuration(0.5) {
                self.logoLabel.alpha = 0
                self.emailFieldBack.layer.position.y -= self.animateFieldDistance
                self.emailField.layer.position.y -= self.animateFieldDistance
                self.emailIcon.layer.position.y -= self.animateFieldDistance
                self.passwordField.layer.position.y -= self.animateFieldDistance
                self.passwordFieldBack.layer.position.y -= self.animateFieldDistance
                self.passwordIcon.layer.position.y -= self.animateFieldDistance
                self.loginButton.layer.position.y -= self.animateFieldDistance
            }
        }
       
    }
    
    func keyboardDidHide(notification: NSNotification) {
        if editingIsInProgress == true {
            editingIsInProgress = false
            UIView.transitionWithView(logoContainerView, duration: 0.5, options: .TransitionFlipFromTop, animations: {
                self.logoUpBack.removeFromSuperview()
                self.logoContainerView.addSubview(self.logoUp)
                }, completion: { (true) in
            })
            UIView.animateWithDuration(0.5) {
                self.logoLabel.alpha = 1
                self.emailFieldBack.layer.position.y += self.animateFieldDistance
                self.emailField.layer.position.y += self.animateFieldDistance
                self.emailIcon.layer.position.y += self.animateFieldDistance
                self.passwordField.layer.position.y += self.animateFieldDistance
                self.passwordFieldBack.layer.position.y += self.animateFieldDistance
                self.passwordIcon.layer.position.y += self.animateFieldDistance
                self.loginButton.layer.position.y += self.animateFieldDistance
            }
        }
    }

    //MARK: Helper Methods
    
    func configurationTextField(textField: UITextField!)
        {
            print("generating the TextField")
            textField.placeholder = "Enter e-mail"
            emailForForgotPasswordField = textField
            
        }


}
