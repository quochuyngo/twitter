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

    var loginCompletion: ((_ user: User?, _ error: Error?) -> ())?
    
    func login(completion: @escaping (_ user:User?, _ error:Error?) -> ()){
        self.loginCompletion = completion
        
        TwitterClient.shareInstance?.deauthorize()
        TwitterClient.shareInstance?.fetchRequestToken(withPath: URLs.REQUEST_TOKEN, method: "POST", callbackURL: URL(string: URLs.FAKE), scope: nil, success: {(response:BDBOAuth1Credential?) -> Void in
                let url = URL(string: URLs.TWITTER_BASE + URLs.AUTHORIZE + (response?.token)!)
                UIApplication.shared.openURL(url!)
            
            }){(error: Error?) -> Void in
                self.loginCompletion?(nil, error)
            }
    }
    
    func handleOpenUrl(url: URL){
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        
        self.fetchAccessToken(withPath: URLs.ACCESS_TOKEN, method: "POST", requestToken: requestToken, success: {(access_token: BDBOAuth1Credential?) -> Void in
            print(access_token?.secret)
            print(access_token?.token)
            self.requestSerializer.saveAccessToken(access_token)
            self.getCurrentAccount(completion: {(user, error) -> () in
                if user != nil{
                    self.loginCompletion?(user, nil)
                }
                else{
                      self.loginCompletion?(nil, error)
                }
            })
        })
        {(error: Error?) -> Void in
            self.loginCompletion?(nil, error)
        }
    }
    
    func getCurrentAccount(completion: @escaping (_ user: User?, _ error: Error?) -> ()){
         self.get(URLs.VERIFY_CREDENTIALS, parameters: nil, progress: nil, success: {(task:URLSessionDataTask, response) in
            let userDic = response as? NSDictionary
            let user = User(dictionary: userDic!, accessToken: self.requestSerializer.accessToken)
            User.currentUser = user
            completion(user, nil)
        }){ (task:URLSessionDataTask?, error: Error?) -> Void in
            completion(nil, error)
        }
    }
    //success: @escaping ([Tweet]) -> (), failure: @escaping (Error) -> ()
    func getHomeTimeline(completion: @escaping (_ tweets:[Tweet]?, _ error: Error?) -> ()){
        self.get(URLs.HOME_TIMELINE, parameters: nil, progress: nil, success: {(task, response) in
            let dictionaries = response as? [NSDictionary]
            let tweets = Tweet.tweetsWithArray(dictionaries: dictionaries!)
            completion(tweets, nil)
        }){(task, error:Error)  in
           completion(nil, error)
        }
    }
    
    func new_tweet(content:String, completion: @escaping (_ tweet: Tweet?, _ error:Error?) -> ()){
        let params = ["status" : content]
        self.post(URLs.STATUS_UPDATE, parameters: params, progress: nil, success:
            {(task, response) in
                let dic = response as! NSDictionary
                completion(Tweet(dictionary: dic), nil)
        }){(task, error:Error) in
            completion(nil, error)
        }
    }
    
    func reply(content:String, id:String ,completion: @escaping (_ tweet: Tweet?, _ error:Error?) -> ()){
        let params = ["status" : content, "in_reply_to_status_id" : id]
        self.post(URLs.STATUS_UPDATE, parameters: params, progress: nil, success:
            {(task, response) in
                let dic = response as! NSDictionary
                completion(Tweet(dictionary: dic), nil)
        }){(task, error:Error) in
            completion(nil, error)
        }
    }

    func setFavorite(id: String, isFavorite:Bool, completion: @escaping (_ tweet:Tweet?, _ error:Error?) -> ()){
        var urlFavorite:String!
        if isFavorite{
            urlFavorite = URLs.FAVOTITE_DESTROY
        }
        else{
            urlFavorite = URLs.FAVOTITE_CREATE
        }
        
        let params = ["id": id]
        print(params)
        self.post(urlFavorite, parameters: params, progress: nil, success: { (task, response) in
            
            let dictionary = response as! NSDictionary
            let tweet = Tweet(dictionary: dictionary)
            completion(tweet, nil)
        }, failure: { (task, error) in
            print(error.localizedDescription)
            completion(nil, error)
        })
    }
    
    func retweet(id:String, isRetweet: Bool,  completion: @escaping (_ tweet:Tweet?, _ error:Error?) -> ()){
        var urlReTweet:String!
        if isRetweet{
            urlReTweet = URLs.UNRETWEET(id: id)
        }
        else{
            urlReTweet = URLs.RETWEET(id: id)
        }
        self.post(urlReTweet, parameters: nil, progress: nil, success: {(task, response) in
            let dictionary = response as! NSDictionary
            let tweet = Tweet(dictionary: dictionary)
            completion(tweet, nil)
        }
        ,failure: {(task, error) in
            completion(nil, error)
        })
    }
}
