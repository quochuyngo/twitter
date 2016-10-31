//
//  Constant.swift
//  Twitter
//
//  Created by Quoc Huy Ngo on 10/30/16.
//  Copyright © 2016 Quoc Huy Ngo. All rights reserved.
//

import Foundation

class URLs{
    static let TWITTER_BASE = "https://api.twitter.com"
    static let REQUEST_TOKEN = "oauth/request_token"
    static let ACCESS_TOKEN = "oauth/access_token"
    static let AUTHORIZE = "/oauth/authorize?oauth_token="
    static let FAKE = "twittercs://oauth"
    static let VERIFY_CREDENTIALS = "1.1/account/verify_credentials.json"
    static let HOME_TIMELINE = "1.1/statuses/home_timeline.json"
    static let STATUS_UPDATE = "1.1/statuses/update.json"
    static let FAVOTITE_CREATE = "1.1/favorites/create.json"
    static let FAVOTITE_DESTROY = "1.1/favorites/destroy.json"
    
    static func RETWEET(id:String) -> String{
        return "1.1/statuses/retweet/" + id + ".json"
    }
    static func UNRETWEET(id:String) -> String{
        return "1.1/statuses/unretweet/" + id + ".json"
    }
}

class KEYs{
    static let API_KEY = "JxUiG0fZyXliskmGJZYLjZcc4" //"xP5ncED0NhvByFYxQu0seLUwf"
    static let API_SECRET = "2rW7IMZQ9Iz73JTwm800PGoaRHTPa3Vz59nDRXx2I1NIEaiipo" //"oA2xSASBMBtf4jS6PzKt1Vcgvb7RIZ7Y3isyV8usIlrqt4M7Zp"
    static let CURRENT_USER = "current_user"
}

class SEGUE_IDENTIFIER{
    static let NEW_TWEET = "SegueNewTweet"
    static let DETAILS = "SegueDetails"
}

