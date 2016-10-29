//
//  Tweet.swift
//  Twitter
//
//  Created by Quoc Huy Ngo on 10/28/16.
//  Copyright © 2016 Quoc Huy Ngo. All rights reserved.
//

import UIKit

class Tweet: NSObject{
    var user:User?
    var text:String?
    var timestamp:NSDate?
    var favorite_count:Int?
    var retweet_count:Int?
    override init(){
        
    }
    
    init(dictionary : NSDictionary){
        self.text = dictionary["text"] as? String
        self.favorite_count = dictionary["favorite_count"] as? Int
        self.retweet_count = dictionary["retweet_count"] as? Int
        
        let timestampString = dictionary["created_at"] as? String
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        self.timestamp = formatter.date(from: timestampString!)! as NSDate?
        
        self.user = User(dictionary: (dictionary["user"] as? NSDictionary)!)
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in dictionaries {
            let tweet = Tweet(dictionary: dictionary)
            tweets.append(tweet)
        }
        
        return tweets
    }
}
