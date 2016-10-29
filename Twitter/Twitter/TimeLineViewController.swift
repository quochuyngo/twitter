//
//  TimeLineViewController.swift
//  Twitter
//
//  Created by Quoc Huy Ngo on 10/28/16.
//  Copyright © 2016 Quoc Huy Ngo. All rights reserved.
//

import UIKit

class TimeLineViewController: UIViewController {

    @IBOutlet weak var tweetsTableView: UITableView!
    var tweets:[Tweet]?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set row height dynamic
        tweetsTableView.rowHeight = UITableViewAutomaticDimension
        tweetsTableView.estimatedRowHeight = 120
        
        tweetsTableView.delegate = self
        tweetsTableView.dataSource = self
        
        getTweets()
        // Do any additional setup after loading the view.
    }
    
    func getTweets(){
        TwitterClient.shareInstance?.getHomeTimeline(completion: {(tweets, error) -> () in
            if tweets != nil{
                self.tweets = tweets
                self.tweetsTableView.reloadData()
            }
        })
    }
}

extension TimeLineViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell") as? TweetCell
        cell?.tweet = tweets?[indexPath.row]
        return cell!
    }
}
