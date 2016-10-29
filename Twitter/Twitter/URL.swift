//
//  URL.swift
//  Twitter
//
//  Created by Quoc Huy Ngo on 10/28/16.
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
}

class KEYs{
    static let API_KEY = "xP5ncED0NhvByFYxQu0seLUwf"
    static let API_SECRET = "oA2xSASBMBtf4jS6PzKt1Vcgvb7RIZ7Y3isyV8usIlrqt4M7Zp"
}
