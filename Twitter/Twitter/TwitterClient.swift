//
//  TwitterClient.swift
//  Twitter
//
//  Created by Quoc Huy Ngo on 10/28/16.
//  Copyright © 2016 Quoc Huy Ngo. All rights reserved.
//

import Foundation
import AFNetworking
import BDBOAuth1Manager

class TwitterClient : BDBOAuth1SessionManager{
    
    static let shareInstance = TwitterClient(baseURL: URL(string:URLs.TWITTER_BASE), consumerKey: KEYs.API_KEY, consumerSecret: KEYs.API_SECRET)
    
    var loginSuccess: (() -> ())?
    var loginFailure: ((Error) -> ())?
    
    func handleOpenUrl(url: URL){
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        
        fetchAccessToken(withPath: URLs.ACCESS_TOKEN, method: "POST", requestToken: requestToken, success: {(access_token: BDBOAuth1Credential?) -> Void in
                self.loginSuccess?()
            })
        {(error: Error?) -> Void in
            self.loginFailure?(error!)
        }
    }
    func login( success:@escaping () -> (), failure: @escaping (Error) -> ()){
        loginSuccess = success
        loginFailure = failure
        TwitterClient.shareInstance?.deauthorize()
        TwitterClient.shareInstance?.fetchRequestToken(withPath: URLs.REQUEST_TOKEN, method: "POST", callbackURL: URL(string: URLs.FAKE), scope: nil, success: {(response:BDBOAuth1Credential?) -> Void in
                let url = URL(string: URLs.TWITTER_BASE + URLs.AUTHORIZE + (response?.token)!)
                UIApplication.shared.openURL(url!)
            
            }){(error: Error?) -> Void in
               self.loginFailure?(error!)
            }
    }
    
    func getCurrentAccount(success: @escaping (User) -> (), failure: @escaping (Error) -> ()){
        TwitterClient.shareInstance?.get(URLs.VERIFY_CREDENTIALS, parameters: nil, progress: nil, success: {(task:URLSessionDataTask, response) in
            let userDic = response as? NSDictionary
            let user = User(dictionary: userDic!)
            success(user)
        }){ (task:URLSessionDataTask?, error: Error?) -> Void in
            failure(error!)
        }
    }
    //success: @escaping ([Tweet]) -> (), failure: @escaping (Error) -> ()
    func getHomeTimeline(completion: @escaping (_ tweets:[Tweet]?, _ error: Error?) -> ()){
        TwitterClient.shareInstance?.get(URLs.HOME_TIMELINE, parameters: nil, progress: nil, success: {(task:URLSessionDataTask, response) in
            let dictionaries = response as? [NSDictionary]
            let tweets = Tweet.tweetsWithArray(dictionaries: dictionaries!)
            completion(tweets, nil)
        }){(task:URLSessionDataTask?, error:Error) -> Void in
           completion(nil, error)
        }
    }
}
