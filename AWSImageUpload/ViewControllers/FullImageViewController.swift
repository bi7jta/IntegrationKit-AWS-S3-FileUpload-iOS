//
//  FullImageViewController.swift
//  AWSImageUpload
//
//  Created by Saqib Usman on 1/13/16.
//  Copyright © 2016 Saqib Usman. All rights reserved.
//

import UIKit

class FullImageViewController : UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var imageUrlString:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        performAssert();
        
        loadImage();
    }
    
    
    private func performAssert() {
        
        assert(imageUrlString != nil , "Image Url is nil");
    }
    
    private func loadImage() {
        
        let url = NSURL(string:imageUrlString);
        
        self.imageView.sd_setImageWithURL(url, placeholderImage: UIImage(named: "placeholder.png")) { (image, error, cacheType, imageURL) -> Void in
            //print("image: \(image)")
            if(image == nil) {
                let alertController = UIAlertController(title: "Error", message: "Link has expired, please refresh list for current link", preferredStyle: .Alert)
                let okAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)
                alertController.addAction(okAction)
                self.presentViewController(alertController, animated: true, completion: nil)
            }
        }
    }
    
    
    
    
    
}
