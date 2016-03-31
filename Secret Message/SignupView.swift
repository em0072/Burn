//
//  SignupView.swift
//  Secret Message
//
//  Created by Митько Евгений on 20.03.16.
//  Copyright © 2016 Evgeny Mitko. All rights reserved.
//

import UIKit

extension SingUpController {
    
    
    
    func layerSignupView() {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "BackgroundSignup")!)
        
        //MARK: Logo
        
        var layer = Size(x: 147, y: 35, width: 148, height: 113)
        logo = UIImageView(frame: CGRect(x: layer.x, y: layer.y, width: layer.width, height: layer.height))
        logo.image = UIImage(named: "IconSignup")!
        view.addSubview(logo)
        
        layer = Size(x: 239, y: 35, width: 56, height: 57)
        logoBubble = UIImageView(frame: CGRect(x: layer.x, y: layer.y, width: layer.width, height: layer.height))
        logoBubble.image = UIImage(named: "LogoSignupBubble")!
        view.addSubview(logoBubble)
        
        layer = Size(x: 149, y: 148, width: 117, height: 67)
        logoLabel = UILabel(frame: CGRect(x: layer.x, y: layer.y, width: layer.width, height: layer.height))
        logoLabel.text = "Burn"
        logoLabel.textColor = UIColor.whiteColor()
        logoLabel.font = UIFont(name: "Lato-Light", size: 56)
        logoLabel.textAlignment = .Center
        logoLabel.adjustsFontSizeToFitWidth = true
        view.addSubview(logoLabel)
        
        //MARK: Username Field
        layer = Size(x: 65, y: 234, width: 285, height: 53)
        usernameFieldBack = UIImageView(frame: CGRect(x: layer.x, y: layer.y, width: layer.width, height: layer.height))
        usernameFieldBack.image = UIImage(named: "Field")!
        view.addSubview(usernameFieldBack)
        
        layer = Size(x: 65, y: 251, width: 16, height: 19)
        usernameIcon = UIImageView(frame: CGRect(x: layer.x, y: layer.y, width: layer.width, height: layer.height))
        usernameIcon.image = UIImage(named: "UsernameIcon")!
        view.addSubview(usernameIcon)
        
        layer = Size(x: 100, y: 238, width: 250, height: 47)
        usernameField = UITextField(frame: CGRect(x: layer.x, y: layer.y, width: layer.width, height: layer.height))
        usernameField.tag = 0
        usernameField.delegate = self
        usernameField.addTarget(self, action: #selector(SingUpController.keyboardDidShow(_:)), forControlEvents: .EditingDidBegin)
//        usernameField.autocapitalizationType = .None
        usernameField.attributedPlaceholder = NSAttributedString(string:"Username:", attributes:[NSForegroundColorAttributeName: UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1)])
        usernameField.textColor = UIColor.whiteColor()
        usernameField.font = UIFont(name: "Lato-Light", size: 16)
        usernameField.returnKeyType = .Next
        view.addSubview(usernameField)
        
        //MARK: Email Field
        layer = Size(x: 65, y: 288, width: 285, height: 53)
        emailFieldBack = UIImageView(frame: CGRect(x: layer.x, y: layer.y, width: layer.width, height: layer.height))
        emailFieldBack.image = UIImage(named: "Field")!
        view.addSubview(emailFieldBack)
        
        layer = Size(x: 65, y: 309, width: 17, height: 12)
        emailIcon = UIImageView(frame: CGRect(x: layer.x, y: layer.y, width: layer.width, height: layer.height))
        emailIcon.image = UIImage(named: "EmailIcon")!
        view.addSubview(emailIcon)
        
        layer = Size(x: 100, y: 292, width: 250, height: 47)
        emailField = UITextField(frame: CGRect(x: layer.x, y: layer.y, width: layer.width, height: layer.height))
        emailField.tag = 1
        emailField.delegate = self
        emailField.addTarget(self, action: #selector(SingUpController.keyboardDidShow(_:)), forControlEvents: .EditingDidBegin)
        emailField.autocapitalizationType = .None
        emailField.attributedPlaceholder = NSAttributedString(string:"Email address:", attributes:[NSForegroundColorAttributeName: UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1)])
        emailField.textColor = UIColor.whiteColor()
        emailField.font = UIFont(name: "Lato-Light", size: 16)
        emailField.returnKeyType = .Next
        view.addSubview(emailField)
        
        
        //MARK: Password Field
        layer = Size(x: 65, y: 342, width: 285, height: 53)
        passwordFieldBack = UIImageView(frame: CGRect(x: layer.x, y: layer.y, width: layer.width, height: layer.height))
        passwordFieldBack.image = UIImage(named: "Field")!
        view.addSubview(passwordFieldBack)
        
        layer = Size(x: 67, y: 359, width: 13, height: 19)
        passwordIcon = UIImageView(frame: CGRect(x: layer.x, y: layer.y, width: layer.width, height: layer.height))
        passwordIcon.image = UIImage(named: "PasswordIcon")!
        view.addSubview(passwordIcon)
        
        layer = Size(x: 100, y: 346, width: 250, height: 47)
        passwordField = UITextField(frame: CGRect(x: layer.x, y: layer.y, width: layer.width, height: layer.height))
        passwordField.tag = 2
        passwordField.delegate = self
        passwordField.addTarget(self, action: #selector(SingUpController.keyboardDidShow(_:)), forControlEvents: .EditingDidBegin)
//        passwordField.secureTextEntry = true
        passwordField.autocapitalizationType = .None
        //        passwordField.addTarget(self, action: "keyboardDidHide:", forControlEvents: .EditingDidEnd)
        passwordField.attributedPlaceholder = NSAttributedString(string:"Password:", attributes:[NSForegroundColorAttributeName: UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1)])
        passwordField.textColor = UIColor.whiteColor()
        passwordField.font = UIFont(name: "Lato-Light", size: 16)
        passwordField.returnKeyType = .Done
        passwordField.keyboardType = .EmailAddress
        view.addSubview(passwordField)
        
        
        //MARK: Sign Up Button
        layer = Size(x: 65, y: 430, width: 285, height: 52)
        signupButton = UIButton(frame: CGRect(x: layer.x, y: layer.y, width: layer.width, height: layer.height))
        signupButton.backgroundColor = UIColor(red: 46/255, green: 196/255, blue: 182/255, alpha: 1)
        signupButton.tintColor = UIColor.whiteColor()
        signupButton.setTitle("Sign Up", forState: .Normal)
        signupButton.addTarget(self, action: #selector(SingUpController.singupButtonPressed(_:)), forControlEvents: .TouchUpInside)
        signupButton.setTitleColor(UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1), forState: .Highlighted)
        signupButton.setBackgroundImage(UIImage.imageWithColor(UIColor(red: 39/255, green: 171/255, blue: 158/255, alpha: 1)), forState: .Highlighted)
        signupButton.titleLabel?.font = UIFont(name: "Lato-Light", size: 25)
        signupButton.titleLabel?.adjustsFontSizeToFitWidth = true
        view.addSubview(signupButton)
        
        layer = Size(x: 65, y: 489, width: 283, height: 16)
        termsLabel = UILabel(frame: CGRect(x: layer.x, y: layer.y, width: layer.width, height: layer.height))
        termsLabel.text = "By creating an account you agree with"
        termsLabel.textColor = UIColor.whiteColor()
        termsLabel.font = UIFont(name: "Lato-Thin", size: 12)
        termsLabel.textAlignment = .Center
        termsLabel.adjustsFontSizeToFitWidth = true
        view.addSubview(termsLabel)
        
        layer = Size(x: 106, y: 504, width: 201, height: 15)
        termsButton = UIButton(frame: CGRect(x: layer.x, y: layer.y, width: layer.width, height: layer.height))
        termsButton.tintColor = UIColor.whiteColor()
        termsButton.setTitle("terms of  End ­User License Agreement", forState: .Normal)
        termsButton.setTitleColor(UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1), forState: .Highlighted)
        termsButton.titleLabel?.font = UIFont(name: "Lato-Regular", size: 12)
        termsButton.titleLabel?.adjustsFontSizeToFitWidth = true
        termsButton.addTarget(self, action: #selector(SingUpController.showTerms(_:)), forControlEvents: .TouchUpInside)
        view.addSubview(termsButton)

        
        
        
        
        //MARK: Log In Button
        layer = Size(x: 134, y: 699, width: 105, height: 18)
        goBackLabel = UILabel(frame: CGRect(x: layer.x, y: layer.y, width: layer.width, height: layer.height))
        goBackLabel.text = "Wanna go back?"
        goBackLabel.textColor = UIColor.whiteColor()
        goBackLabel.font = UIFont(name: "Lato-Thin", size: 14)
        goBackLabel.textAlignment = .Center
        goBackLabel.adjustsFontSizeToFitWidth = true
        view.addSubview(goBackLabel)
        
        layer = Size(x: 243, y: 701, width: 45, height: 17)
        loginButton = UIButton(frame: CGRect(x: layer.x, y: layer.y, width: layer.width, height: layer.height))
        loginButton.tintColor = UIColor.whiteColor()
        loginButton.setTitle("Log In!", forState: .Normal)
        loginButton.setTitleColor(UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1), forState: .Highlighted)
        loginButton.titleLabel?.font = UIFont(name: "Lato-Regular", size: 14)
        loginButton.titleLabel?.adjustsFontSizeToFitWidth = true
        loginButton.addTarget(self, action: #selector(SingUpController.showLogin(_:)), forControlEvents: .TouchUpInside)
        view.addSubview(loginButton)
        
        
        
        //MARK: Elastic Transition Config
        transition.panThreshold = 0.5
        transition.transformType = .TranslateMid
        
        //MARK: PanRecogniser For Elastic Menu
        if !(segue) {
            let panSignUp = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(SingUpController.panForLogIn(_:)))
            panSignUp.edges = .Left
            view.addGestureRecognizer(panSignUp)
        }
    }

    
    
}
