//
//  TweetCell.swift
//  Twitter
//
//  Created by Pooja Yadav on 6/26/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favButton: UIButton!
    
    
    
    @IBAction func retweet(_ sender: Any) {
        TwitterAPICaller.client?.retweet(tweetId: tweetId, success: {
            self.setRetweeted(_isRetweeted: true)}, failure: {(error) in
                print("Error is retweeting: \(error)")
        })
    }
    
    func setRetweeted(_isRetweeted: Bool)
    {
        retweeted = _isRetweeted
        if(retweeted) {
            retweetButton.setImage(UIImage(named:"retweet-icon-green"), for:UIControl.State.normal)
            retweetButton.isEnabled = false
        }else{
            retweetButton.setImage(UIImage(named:"retweet-icon"), for:UIControl.State.normal)
            retweetButton.isEnabled = true
        }
    }
    
    var favorited: Bool = false
    var tweetId: Int = -1
    var retweeted: Bool = false
    
    
    func setFavorite(_isFavorited : Bool){
        favorited = _isFavorited
        if(favorited){
            favButton.setImage(UIImage(named:"favor-icon-red"), for:UIControl.State.normal)
        }
        else{
            favButton.setImage(UIImage(named:"favor-icon"), for:UIControl.State.normal)
            
        }
    }
    
    @IBAction func favoriteTweet(_ sender: Any) {
        let toBeFavorited = !favorited
        if(toBeFavorited){
            TwitterAPICaller.client?.favoriteTweet(tweetId:tweetId, success: {
                self.setFavorite(_isFavorited: true)
                
            },
                                                  failure: {(error) in
                                                    print("Favorite did not succeed: \(error)")
                
            })
        } else{
            TwitterAPICaller.client?.favoriteTweet(tweetId:tweetId, success: {
                self.setFavorite(_isFavorited: false)
                
            },
                                                  failure: {(error) in
                                                    print("Unfavorite did not succeed: \(error)")
                
            })
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
