//
//  DetailsViewController.swift
//  Twitter
//
//  Created by Quoc Huy Ngo on 10/30/16.
//  Copyright © 2016 Quoc Huy Ngo. All rights reserved.
//

import UIKit
import AFNetworking

class DetailsViewController: UIViewController {

    var tweet:Tweet?
    
    @IBOutlet weak var favoritesLabel: UILabel!
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        // Do any additional setup after loading the view.
    }
    
    func setView(){
        profileImageView.setImageWith(URL(string:(tweet?.user?.profile_image_url_https)!)!)
        nameLabel.text = tweet?.user?.name
        screenNameLabel.text = tweet?.user?.screen_name
        favoritesLabel.text = String(format: "%d", (tweet?.favorite_count)!)
        retweetLabel.text = String(format: "%d", (tweet?.retweet_count)!)
        contentLabel.text = tweet?.text
        setIcon(tweet: tweet!)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nc = segue.destination as! UINavigationController
        let newTweetVC = nc.topViewController as! NewTweetViewController
        newTweetVC.tweet = tweet
    }
    @IBAction func onReplyButton(_ sender: AnyObject) {
        
    }
    
    @IBAction func onRetweetButton(_ sender: AnyObject) {
        TwitterClient.shareInstance?.retweet(id: (tweet?.id)!, isRetweet: (tweet?.isRetweet)!, completion: {(tweet, error) -> () in
            if tweet != nil{
                self.tweet = tweet
                self.retweetLabel.text = String(format:"%d",(tweet?.retweet_count)!)
                self.setIcon(tweet: tweet!)
            }
        })
    
    }
    
    @IBAction func onFavoriteButton(_ sender: AnyObject) {
        TwitterClient.shareInstance?.setFavorite(id: (tweet?.id)!, isFavorite: (tweet?.isFavorite)!, completion: {(tweet, error) -> () in
            if tweet != nil{
                self.tweet = tweet
                self.favoritesLabel.text = String(format:"%d",(tweet?.favorite_count)!)
                self.setIcon(tweet: tweet!)
            }
        })
    }
    
    func setIcon(tweet:Tweet){
        if tweet.isFavorite!{
            self.favoriteButton.setImage(UIImage(named: "favorite_on"), for: .normal)
        }
        else{
            self.favoriteButton.setImage(UIImage(named: "favorite"), for: .normal)
        }
        
        if tweet.isRetweet!{
            self.retweetButton.setImage(UIImage(named: "retweet_on"), for: .normal)
        }
        else{
            self.retweetButton.setImage(UIImage(named: "retweet"), for: .normal)
        }
    }
}
