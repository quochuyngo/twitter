//
//  LoginViewController.swift
//  Twitter
//
//  Created by Quoc Huy Ngo on 10/28/16.
//  Copyright © 2016 Quoc Huy Ngo. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func onLoginButton(_ sender: AnyObject) {
        let client = TwitterClient.shareInstance
        client?.login(success: { () -> () in
            print("logged in")
            self.performSegue(withIdentifier: "SegueTimeLine", sender: self)
        }){(error: Error) ->() in
            Alert.showAlertMessage(userMessage: "Login Problem", vc: self)
            print("\(error.localizedDescription)")
        }
    }
}
