//
//  UploadItemCell.swift
//  AWSImageUpload
//
//  Created by Saqib Usman on 1/13/16.
//  Copyright © 2016 Saqib Usman. All rights reserved.
//

import UIKit

protocol LinkActionDelegate {
    func didSelectLink(linkStr:String?, nameStr:String?)
}

class UploadItemCell : UITableViewCell {
    
    
    var delegate:LinkActionDelegate!
    
    var uploadItem:Upload!
    
    @IBAction func linkButtonPressed(sender: UIButton) {
        
        if let link =  uploadItem.link {
            if let name = uploadItem.name {
                delegate.didSelectLink(link, nameStr: name)
            }
        }
    }
    @IBOutlet weak var linkButton: UIButton!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configureWithUploadItem(uploadItem: Upload, delegate:LinkActionDelegate) {
        self.delegate = delegate
        self.uploadItem = uploadItem
        nameLabel.text = uploadItem.name
        
        
        if let date = uploadItem.createdAt {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"
            let stringDate =  dateFormatter.stringFromDate(date)
            createdAtLabel.text = stringDate
        
        } else {
            createdAtLabel.hidden = true;
        }
        
        
//        let date = uploadItem.createdAt
//        
//        let dateFormatter = NSDateFormatter()
//        dateFormatter.dateStyle = NSDateFormatterStyle.LongStyle
//        dateFormatter.timeStyle = .MediumStyle
       // dateFormatter.dateFormat = "dd-MM-yyyy"
       // let dateString = dateFormatter.stringFromDate(date)

      //  createdAtLabel.text = dateString;
    }
    
    
    
}
