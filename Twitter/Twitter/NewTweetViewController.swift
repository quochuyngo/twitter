//
//  NewTweetViewController.swift
//  Twitter
//
//  Created by Quoc Huy Ngo on 10/30/16.
//  Copyright © 2016 Quoc Huy Ngo. All rights reserved.
//

import UIKit
import AFNetworking

class NewTweetViewController: UIViewController {

    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var letterCountLabel: UILabel!
    var tweet:Tweet?
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        // Do any additional setup after loading the view.
    }
  
    func setView(){
        nameLable.text = User.currentUser?.name
        screenNameLabel.text = User.currentUser?.screen_name
        if let profileImage = User.currentUser?.profile_image_url_https{
            profileImageView.setImageWith(URL(string: profileImage)!)
        }
        contentTextView.becomeFirstResponder()
        if let screen_name = tweet?.user?.screen_name!{
            contentTextView.text = "@\(screen_name) "
        }
    }
    
    @IBAction func onTweetButton(_ sender: AnyObject) {
        let content = contentTextView.text
        if tweet == nil{
            //new tweet
            TwitterClient.shareInstance?.new_tweet(content: content!, completion:{ (tweet, error) -> () in
                if tweet != nil{
                    self.dismiss(animated: true, completion: nil)
                }
            })
        }
        else{
            //reply
            TwitterClient.shareInstance?.reply(content: content!, id: (tweet?.id)!, completion: {(tweet, error) -> () in
                if tweet != nil{
                    self.dismiss(animated: true, completion: nil)
                }
                
            })
        }
        
    }
    @IBAction func onCancelButon(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }

}
