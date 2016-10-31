//
//  User.swift
//  Twitter
//
//  Created by Quoc Huy Ngo on 10/28/16.
//  Copyright © 2016 Quoc Huy Ngo. All rights reserved.
//
import UIKit
import BDBOAuth1Manager

var _currentUser: User?

enum UserKeys:String{
    case name, screen_name, profile_image, access_token
}

class User : NSObject, NSCoding{
    var name:String?
    var screen_name:String?
    var profile_image_url_https:String?
    var accessToken:BDBOAuth1Credential?
    
    override init(){
        
    }
    
    init(dictionary: NSDictionary, accessToken:BDBOAuth1Credential?){
        self.name = dictionary["name"] as? String
        self.screen_name = dictionary["screen_name"] as? String
        self.profile_image_url_https = dictionary["profile_image_url_https"] as? String
        self.accessToken = accessToken
    }
    
    required init(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObject(forKey: UserKeys.name.rawValue) as? String
        self.screen_name = aDecoder.decodeObject(forKey: UserKeys.screen_name.rawValue) as? String
        self.profile_image_url_https = aDecoder.decodeObject(forKey: UserKeys.profile_image.rawValue) as? String
        self.accessToken = aDecoder.decodeObject(forKey: UserKeys.access_token.rawValue) as?BDBOAuth1Credential
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.name, forKey: UserKeys.name.rawValue)
        aCoder.encode(self.screen_name, forKey: UserKeys.screen_name.rawValue)
        aCoder.encode(self.profile_image_url_https, forKey: UserKeys.profile_image.rawValue)
        aCoder.encode(self.accessToken, forKey: UserKeys.access_token.rawValue)
    }
    
    class var currentUser: User? {
        get {
            if _currentUser == nil {
                let data = UserDefaults.standard.object(forKey: KEYs.CURRENT_USER) as? Data
                if data != nil {
                 _currentUser = NSKeyedUnarchiver.unarchiveObject(with: data!) as? User
                }
            }
            return _currentUser
        }
        set(user) {
            _currentUser = user
            
            if _currentUser != nil {
                let data = NSKeyedArchiver.archivedData(withRootObject: user!)
                UserDefaults.standard.set(data, forKey: KEYs.CURRENT_USER)
            } else {
                UserDefaults.standard.set(nil, forKey: KEYs.CURRENT_USER)
            }
            UserDefaults.standard.synchronize()
        }
    }

}
