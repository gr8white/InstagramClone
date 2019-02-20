//
//  ViewController.swift
//  Instagram
//
//  Created by Derrick White on 2/18/19.
//  Copyright © 2019 Derrick White. All rights reserved.
//  ec2-3-16-15-43.us-east-2.compute.amazonaws.com // derrick, derrick1995!

import UIKit
import Parse

class ViewController: UIViewController {

    var signUpModeActive = true
    
    func displayAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            
            self.dismiss(animated: true, completion: nil)
            
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var signupOrLoginButton: UIButton!
    
    @IBOutlet weak var switchLogInModeButton: UIButton!
    
    @IBOutlet weak var banner: UILabel!
    
    @IBAction func signupOrLogin(_ sender: Any) {
       
        if email.text == "" || password.text == "" {
            
            displayAlert(title:"Error in form", message: "Please enter an email and password")
            
        } else {
            
            let activityInidicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            
            activityInidicator.center = self.view.center
            
            activityInidicator.hidesWhenStopped = true
            
            activityInidicator.style = UIActivityIndicatorView.Style.gray
            
            view.addSubview(activityInidicator)
            
            activityInidicator.startAnimating()
            
            UIApplication.shared.beginIgnoringInteractionEvents()
            
            if (signUpModeActive) {
                
                print("Signing up...")
                
                let user = PFUser()
            
                user.username = email.text
                user.password = password.text
                user.email = email.text
            
                user.signUpInBackground(block: { (success, error) in
                    
                    activityInidicator.stopAnimating()
                    
                    UIApplication.shared.endIgnoringInteractionEvents()
                    
                    if let error = error {
                        
                        self.displayAlert(title:"Could not sign you up" , message: error.localizedDescription)
                        // let errorString = error.userInfo["error"] as? NSString
                        // Show the errorString somewhere and let the user try again.
                        
                        print(error)
                    } else {
                        print("signed up!")
                    }
                    
                })
        
            } else {
                
                PFUser.logInWithUsername(inBackground: email.text!, password: password.text!) { (user, error) in
                    
                    activityInidicator.stopAnimating()
                    
                    UIApplication.shared.endIgnoringInteractionEvents()
                    
                    if user != nil {
                        
                        print("Login successful")
                        
                    } else {
                        
                        var errorText = "Unknown error: Please try again"
                        
                        if let error = error {
                            
                            errorText = error.localizedDescription
                            
                        }
                        
                        self.displayAlert(title:"Could not log you in" , message: errorText)
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
    @IBAction func switchLogInMode(_ sender: Any) {
    
        if (signUpModeActive) {
            
            signUpModeActive = false
            
            signupOrLoginButton.setTitle("Log In", for: [])
            
            switchLogInModeButton.setTitle("Sign Up", for: [])
            
            banner.text = "New to Finstagram?"
            
        } else {
            
            signUpModeActive = true
            
            signupOrLoginButton.setTitle("Sign Up", for: [])
            
            switchLogInModeButton.setTitle("Log In", for: [])
            
            banner.text = "Already have an account?"
            
        }
    
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


}

