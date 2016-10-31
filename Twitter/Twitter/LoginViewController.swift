//
//  LoginViewController.swift
//  Twitter
//
//  Created by Quoc Huy Ngo on 10/28/16.
//  Copyright © 2016 Quoc Huy Ngo. All rights reserved.
//

import UIKit
import BDBOAuth1Manager
import MBProgressHUD
class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func onLoginButton(_ sender: AnyObject) {
         MBProgressHUD.showAdded(to: self.view, animated: true)
        TwitterClient.shareInstance?.login(completion: { (user, error) -> () in
            if error == nil{
                print("logged in")
                MBProgressHUD.hide(for: self.view, animated: true)
                self.performSegue(withIdentifier: "SegueTimeLine", sender: self)
            }
            else{
                Alert.showAlertMessage(userMessage: "Login Problem", vc: self)
                print("\(error?.localizedDescription)")

            }
        })
    }
}
