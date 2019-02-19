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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let gameScore = PFObject(className:"GameScore")
        gameScore["score"] = 1337
        gameScore["playerName"] = "Sean Plott"
        gameScore["cheatMode"] = false
        gameScore.saveInBackground {
            (success, error) in
            if (success) {
                // The object has been saved.
                print("success")
            } else {
                // There was a problem, check error.description
                print("failed")
            }
        }
        
    }


}

