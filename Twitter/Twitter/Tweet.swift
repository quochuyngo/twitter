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
    var id:String?
    var text:String?
    var timestamp:NSDate?
    var isFavorite:Bool?
    var favorite_count:Int?
    var isRetweet:Bool?
    var retweet_count:Int?
    override init(){
        
    }
    
    init(dictionary : NSDictionary){
        self.id = dictionary["id_str"] as? String
        self.text = dictionary["text"] as? String
        
        if dictionary["retweeted_status"] != nil {
            isFavorite = dictionary.value(forKeyPath: "retweeted_status.favorited") as? Bool ?? false
            favorite_count = dictionary.value(forKeyPath: "retweeted_status.favorite_count") as? Int ?? 0
        }
        else {
            self.isFavorite = dictionary["favorited"] as? Bool ?? false
            self.favorite_count = dictionary["favorite_count"] as? Int ?? 0
        }

        self.isRetweet = dictionary["retweeted"] as? Bool ?? false
        self.retweet_count = dictionary["retweet_count"] as? Int
        
        let timestampString = dictionary["created_at"] as? String
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        self.timestamp = formatter.date(from: timestampString!)! as NSDate?
        
        self.user = User(dictionary: (dictionary["user"] as? NSDictionary)!, accessToken: nil)
    }
    
    func getTime() -> String{
        let secMin:Double = 60
        let secHour:Double = 60 * 60
        let secDay:Double = 24 * secHour
        let timeInterval = -(timestamp?.timeIntervalSinceNow)!
        let formatterDisplay = DateFormatter()
        
        if timeInterval > secDay {
            formatterDisplay.dateFormat = "MM/dd/yyyy"
            return formatterDisplay.string(from: timestamp! as Date)
        } else if timeInterval > secHour {
            formatterDisplay.dateFormat = "HH"
            return "\(Int(timeInterval/60/60))h"
        } else if timeInterval > secMin {
            formatterDisplay.dateFormat = "mm"
            return "\(Int(timeInterval/60))min"
        } else {
            formatterDisplay.dateFormat = "ss"
            return "\(Int(timeInterval/60))s"
        }
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
