//
//  TimeLineViewController.swift
//  Twitter
//
//  Created by Quoc Huy Ngo on 10/28/16.
//  Copyright © 2016 Quoc Huy Ngo. All rights reserved.
//

import UIKit
import MBProgressHUD

class TimeLineViewController: UIViewController {

    @IBOutlet weak var tweetsTableView: UITableView!
    var tweets:[Tweet]?
    var refreshControl:UIRefreshControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set row height dynamic
        tweetsTableView.rowHeight = UITableViewAutomaticDimension
        tweetsTableView.estimatedRowHeight = 120
        
        tweetsTableView.delegate = self
        tweetsTableView.dataSource = self
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(TimeLineViewController.refreshTweets(refreshControl:)), for: UIControlEvents.valueChanged)
        tweetsTableView.insertSubview(refreshControl, at: 0)
        MBProgressHUD.showAdded(to: self.view, animated: true)
        getTweets()
        // Do any additional setup after loading the view.
    }
    
    func getTweets(){
        
        TwitterClient.shareInstance?.getHomeTimeline(completion: {(tweets, error) -> () in
            if tweets != nil{
                self.tweets = tweets
                self.tweetsTableView.reloadData()
                MBProgressHUD.hide(for: self.view, animated: true)
                self.refreshControl.endRefreshing()
            }
        })
    }
    
    func refreshTweets(refreshControl:UIRefreshControl){
        getTweets()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //let nc = segue.destination as! UINavigationController
        let identifier = segue.identifier
        if identifier == SEGUE_IDENTIFIER.DETAILS{
            let vc = segue.destination as! DetailsViewController
            vc.tweet = tweets?[(tweetsTableView.indexPathForSelectedRow?.row)!]
        }
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
