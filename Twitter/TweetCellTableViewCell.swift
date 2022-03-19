//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by Yelaman Sain on 3/9/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    
    @IBOutlet weak var retweenBUtton: UIButton!
    @IBOutlet weak var favButton: UIButton!
    
    var favorited:Bool = false
    var tweetID:Int = -1

    
    
    @IBAction func favoriteTweet(_ sender: Any) {
        let tobeFavorited = !favorited
        if (tobeFavorited) {
            TwitterAPICaller.client?.favoriteTweet(tweetID: tweetID, success: {
                self.setFavorite(true)
            }, failure: { (error) in
                print("Favortie did not succeed: \(error)")
            })
        } else {
                TwitterAPICaller.client?.unfavoriteTweet(tweetID: tweetID, success: {
                    self.setFavorite(false)
            }, failure: { (error) in
                print("unFavortie did not succeed: \(error)")
            })
        
        }
    }
    
    
    
    
    @IBAction func retweet(_ sender: Any) {
        TwitterAPICaller.client?.retweet(tweetID: tweetID, success: {
            self.setRetweeted(true)
        }, failure: { (error) in
            print("Error in retweeting: \(error)")
        })
    }
    
    
    
    func setRetweeted(_ isRetweeted:Bool) {
        if (isRetweeted) {
            retweenBUtton.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            retweenBUtton.isEnabled = false
        }
        else {
            retweenBUtton.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
            retweenBUtton.isEnabled = true
        }
    }
    
    
    
    
    func setFavorite (_ isFavorited:Bool) {
        favorited = isFavorited
        if (favorited) {
            favButton.setImage(UIImage(named: "favor-icon-red"), for: UIControl.State.normal)
        }
        else{
            favButton.setImage(UIImage(named: "favor-icon"), for: UIControl.State.normal)
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
