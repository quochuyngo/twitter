//
//  TweetCell.swift
//  Twitter
//
//  Created by Quoc Huy Ngo on 10/29/16.
//  Copyright © 2016 Quoc Huy Ngo. All rights reserved.
//

import UIKit
import AFNetworking
class TweetCell: UITableViewCell {

    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var timstampLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    
    var tweet:Tweet!{
        didSet{
            nameLabel.text = tweet?.user?.name
            screenNameLabel.text = tweet?.user?.screen_name
            //timstampLabel.text = tweet?.timestamp
            contentLabel.text = tweet?.text
            favoriteCountLabel.text = String(format:"%d", tweet.favorite_count!)
            retweetCountLabel.text = String(format: "%d", tweet.retweet_count!)
            if let profile_image = tweet.user?.profile_image_url_https{
                profileImageView.setImageWith(URL(string: profile_image)!)
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    @IBAction func onFavoriteTouch(_ sender: AnyObject) {
        print("Favorite")
    }
    @IBAction func onRetweetTouch(_ sender: AnyObject) {
    }
    @IBAction func onReplyTouch(_ sender: AnyObject) {
    }
}
