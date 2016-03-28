//
//  LoginView.swift
//  Secret Message
//
//  Created by Митько Евгений on 19.03.16.
//  Copyright © 2016 Evgeny Mitko. All rights reserved.
//

import UIKit

extension LoginController {
    
    func layerLoginView() {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Background")!)
        
        //MARK: Logo
    
        var layer = Size(x: 147, y: 98, width: 120, height: 84)
        logoDown = UIImageView(frame: CGRect(x: layer.x, y: layer.y, width: layer.width, height: layer.height))
        logoDown.image = UIImage(named: "LogoDown")!
        view.addSubview(logoDown)
        
        layer = Size(x: 149, y: 37, width: 114, height: 119)
        logoContainerView = UIView(frame: CGRect(x: layer.x, y: layer.y, width: layer.width, height: layer.height))
        view.addSubview(logoContainerView)
        
        layer = Size(x: 0, y: 0, width: 116, height: 119)
        logoUp = UIImageView(frame: CGRect(x: layer.x, y: layer.y, width: layer.width, height: layer.height))
        logoUp.image = UIImage(named: "LogoUp")!
        logoContainerView.addSubview(logoUp)
        
        logoUpBack = UIImageView(frame: CGRect(x: layer.x, y: layer.y, width: layer.width, height: layer.height))
        logoUpBack.image = UIImage(named: "LogoUpBack")
        
        
        layer = Size(x: 149, y: 184, width: 117, height: 67)
        logoLabel = UILabel(frame: CGRect(x: layer.x, y: layer.y, width: layer.width, height: layer.height))
        logoLabel.text = "Burn"
        logoLabel.textColor = UIColor.whiteColor()
        logoLabel.font = UIFont(name: "Lato-Light", size: 56)
        logoLabel.textAlignment = .Center
        logoLabel.adjustsFontSizeToFitWidth = true
        view.addSubview(logoLabel)
    
        
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
        emailField.tag = 0
        emailField.delegate = self
        emailField.addTarget(self, action: #selector(LoginController.keyboardDidShow(_:)), forControlEvents: .EditingDidBegin)
//        emailField.addTarget(self, action: "keyboardDidHide:", forControlEvents: .EditingDidEnd)
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
        passwordField.tag = 1
        passwordField.delegate = self
        passwordField.addTarget(self, action: #selector(LoginController.keyboardDidShow(_:)), forControlEvents: .EditingDidBegin)
        passwordField.secureTextEntry = true
        passwordField.autocapitalizationType = .None
//        passwordField.addTarget(self, action: "keyboardDidHide:", forControlEvents: .EditingDidEnd)
        passwordField.attributedPlaceholder = NSAttributedString(string:"Password:", attributes:[NSForegroundColorAttributeName: UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1)])
        passwordField.textColor = UIColor.whiteColor()
        passwordField.font = UIFont(name: "Lato-Light", size: 16)
        passwordField.returnKeyType = .Done
        view.addSubview(passwordField)
        
        
        //MARK: login Button
        layer = Size(x: 65, y: 430, width: 285, height: 52)
        loginButton = UIButton(frame: CGRect(x: layer.x, y: layer.y, width: layer.width, height: layer.height))
        loginButton.backgroundColor = UIColor(red: 46/255, green: 196/255, blue: 182/255, alpha: 1)
        loginButton.tintColor = UIColor.whiteColor()
        loginButton.setTitle("Log In", forState: .Normal)
        loginButton.addTarget(self, action: #selector(LoginController.loginButtonPressed), forControlEvents: .TouchUpInside)
        loginButton.setTitleColor(UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1), forState: .Highlighted)
        loginButton.setBackgroundImage(UIImage.imageWithColor(UIColor(red: 39/255, green: 171/255, blue: 158/255, alpha: 1)), forState: .Highlighted)
        loginButton.titleLabel?.font = UIFont(name: "Lato-Light", size: 25)
        loginButton.titleLabel?.adjustsFontSizeToFitWidth = true
        view.addSubview(loginButton)
        
        
        //MARK: Forgot Password Button
        layer = Size(x: 100, y: 497, width: 214, height: 15)
        forgotPasswordButton = UIButton(frame: CGRect(x: layer.x, y: layer.y, width: layer.width, height: layer.height))
        forgotPasswordButton.tintColor = UIColor.whiteColor()
        forgotPasswordButton.setTitle("Forgot your password?", forState: .Normal)
        forgotPasswordButton.addTarget(self, action: #selector(LoginController.forgotPassword), forControlEvents: .TouchUpInside)
        forgotPasswordButton.setTitleColor(UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1), forState: .Highlighted)
        forgotPasswordButton.titleLabel?.font = UIFont(name: "Lato-Thin", size: 12)
        forgotPasswordButton.titleLabel?.adjustsFontSizeToFitWidth = true
        view.addSubview(forgotPasswordButton)
    
    
        //MARK: Sign Up Button
        layer = Size(x: 100, y: 699, width: 141, height: 17)
        dontHaveAccountLabel = UILabel(frame: CGRect(x: layer.x, y: layer.y, width: layer.width, height: layer.height))
        dontHaveAccountLabel.text = "Don’t have an account?"
        dontHaveAccountLabel.textColor = UIColor.whiteColor()
        dontHaveAccountLabel.font = UIFont(name: "Lato-Thin", size: 14)
        dontHaveAccountLabel.textAlignment = .Center
        dontHaveAccountLabel.adjustsFontSizeToFitWidth = true
        view.addSubview(dontHaveAccountLabel)
        
        layer = Size(x: 245, y: 700, width: 55, height: 18)
        signupButton = UIButton(frame: CGRect(x: layer.x, y: layer.y, width: layer.width, height: layer.height))
        signupButton.tintColor = UIColor.whiteColor()
        signupButton.setTitle("Sign up!", forState: .Normal)
        signupButton.setTitleColor(UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1), forState: .Highlighted)
        signupButton.titleLabel?.font = UIFont(name: "Lato-Regular", size: 14)
        signupButton.titleLabel?.adjustsFontSizeToFitWidth = true
        signupButton.addTarget(self, action: #selector(LoginController.showSignup(_:)), forControlEvents: .TouchUpInside)
        view.addSubview(signupButton)

        
    
    
        
    //MARK: Elastic Transition Config
        signUpTransition.panThreshold = 0.5
        signUpTransition.transformType = .TranslateMid
//    //MARK: PanRecogniser For Elastic Menu
//        let panSignUp = UIPanGestureRecognizer(target: self, action: "panForSignUp:")
//        view.addGestureRecognizer(panSignUp)
    
    }
    
    
    
}
