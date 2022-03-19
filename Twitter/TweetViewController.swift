//
//  TweetViewController.swift
//  Twitter
//
//  Created by Yelaman Sain on 3/18/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController, UITextViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetTextView.becomeFirstResponder()
        charsLeft.text = "280"
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var tweetTextView: UITextView!
    
    @IBOutlet weak var charsLeft: UILabel!
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tweet(_ sender: Any) {
   
        if (!tweetTextView.text.isEmpty) {
            TwitterAPICaller.client?.postTweet(tweetString: tweetTextView.text, success: {
                self.dismiss(animated: true, completion: nil)
            }, failure: { (error) in
                print("Error posting tweet \(error)")
                self.dismiss(animated: true, completion: nil)
            })
        } else {
            self.dismiss(animated: true, completion: nil)
        }

    }

    func textView(_ textView: UITextView, shouldChangeTextIn range:NSRange, replacementText text: String) -> Bool {
        
        if range.length + range.location > tweetTextView.text.count{
            return false
        }
        let newlength = tweetTextView.text.count + text.count - range.length
        return newlength <= 280
    }
    
    func CheckRemainingChars() {
        let allowedChars = 280
        let charsInTextView = tweetTextView.text.count
        let remainingChars = allowedChars-charsInTextView
        
        if remainingChars <= allowedChars {
            charsLeft.textColor = UIColor.black
        }
        if remainingChars <= 70 {
            charsLeft.textColor = UIColor.orange
        }
        if remainingChars <= 10 {
            charsLeft.textColor = UIColor.red
        }
        
        
        charsLeft.text = String(remainingChars)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        CheckRemainingChars()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
