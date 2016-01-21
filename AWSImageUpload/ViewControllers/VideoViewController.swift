//
//  VideoViewController.swift
//  AWSImageUpload
//
//  Created by Saqib Usman on 1/13/16.
//  Copyright © 2016 Saqib Usman. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class VideoViewController: UIViewController, AVPlayerViewControllerDelegate {
    
    var videoUrlString:String!
    
    
    var playerViewController:AVPlayerViewController?
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        performAssert();
//        
//        if let link = videoUrlString {
//            let url = NSURL(string: link)
//            let player = AVPlayer(URL: url!)
//            let playerViewController = AVPlayerViewController()
//            playerViewController.player = player
//            self.presentViewController(playerViewController, animated: true) {
//                if let validPlayer = playerViewController.player {
//                    validPlayer.play()
//                }
//            }
//        }
//
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playerViewController = AVPlayerViewController()
    
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        performAssert();
        
        if let link = videoUrlString {
            let url = NSURL(string: link)
            let player = AVPlayer(URL: url!)
            
            if let playercontroller = playerViewController {
                
                playercontroller.player = player
                self.presentViewController(playercontroller, animated: true) {
                    if let validPlayer = playercontroller.player {
                        validPlayer.play()
                    }
                }
                
            }
            
        }
        
    }
    
    private func performAssert() {
        
        assert(videoUrlString != nil, " Video url is nil")
    }
}