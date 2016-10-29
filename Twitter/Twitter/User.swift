//
//  User.swift
//  Twitter
//
//  Created by Quoc Huy Ngo on 10/28/16.
//  Copyright © 2016 Quoc Huy Ngo. All rights reserved.
//
import UIKit

var _currentUser: User?
let currentUserKey = "kCurrentUserKey"
class User : NSObject{
    var name:String?
    var screen_name:String?
    var profile_image_url_https:String?
    //var description:String?
    var dictionary: NSDictionary?
    override init(){
        
    }
    
    init(dictionary: NSDictionary){
        self.dictionary = dictionary
        self.name = dictionary["name"] as? String
        self.screen_name = dictionary["screen_name"] as? String
        self.profile_image_url_https = dictionary["profile_image_url_https"] as? String
        //self.description = dictionary["description"]
    }
    
    class var currentUser: User? {
        get {
            TwitterClient.shareInstance?.requestSerializer.saveAccessToken(<#T##accessToken: BDBOAuth1Credential!##BDBOAuth1Credential!#>)
            if _currentUser == nil {
                var data = UserDefaults.standard.object(forKey: currentUserKey) as? NSData
                if data != nil {
                    var dictionary = JSONSerialization.jsonObject(with: data!, options: nil) as NSDictionary
                    _currentUser = User(dictionary: dictionary)
                }
            }
            return _currentUser
        }
        set(user) {
            _currentUser = user
            
            if _currentUser != nil {
                var data = JSONSerialization.data(withJSONObject: user!.dictionary, options: nil)
                UserDefaults.standardUserDefaults().setObject(data, forKey: currentUserKey)
            } else {
                UserDefaults.standard.set(nil, forKey: currentUserKey)
            }
            UserDefaults.standard.synchronize()
        }
    }

}
