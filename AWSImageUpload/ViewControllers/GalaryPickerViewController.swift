//
//  GalaryPickerViewController.swift
//  AWSImageUpload
//
//  Created by Saqib Usman on 1/14/16.
//  Copyright © 2016 Saqib Usman. All rights reserved.
//

import UIKit

@objc protocol GalaryPickerControllerDelegate {
    
    optional func didPickImage(path:String)
    optional func didPickVideo(videoUrl:NSURL)
}

extension String {
    
    func stringByAppendingPathComponent(path: String) -> String {
        
        let nsSt = self as NSString
        
        return nsSt.stringByAppendingPathComponent(path)
    }
}

class GalaryPickerViewController : UIViewController , UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    
    var picker:UIImagePickerController!
    
    var delegate:GalaryPickerControllerDelegate!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        picker = UIImagePickerController()
        picker.delegate = self


    }
    
    private func dismiss() {
        picker.dismissViewControllerAnimated(true, completion: nil)
        self.picker = nil
        self.dismissViewControllerAnimated(true,completion: nil)

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if let picker = self.picker {
            picker.allowsEditing = false
            picker.mediaTypes = ["public.movie", "public.image"]
            picker.sourceType  = .SavedPhotosAlbum
            presentViewController(picker, animated: true, completion: nil)
        }
    }
    
    
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject]) {
            
           if let mediaType = info[UIImagePickerControllerMediaType] as? NSString {
            
            
            if(mediaType.isEqualToString("public.image")) {
                
                
                let imageURL = info[UIImagePickerControllerReferenceURL] as! NSURL
                let imageExtension = imageURL.pathExtension!.lowercaseString
                
                //let imageMediaUrl = info[UIImagePickerControllerMediaURL] as? NSURL
                //let imageData = NSData(contentsOfURL: imageMediaUrl!)
                
                let imageName = imageURL.lastPathComponent
                let documentDirectory = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first! as String
                let localPath = documentDirectory.stringByAppendingPathComponent(imageName!)
                
                let image = info[UIImagePickerControllerOriginalImage] as! UIImage
                var data:NSData!
                if(imageExtension == "jpg" || imageExtension == "jpeg") {
                    data = UIImageJPEGRepresentation(image, 1)
                } else if(imageExtension == "png") {
                    data = UIImagePNGRepresentation(image)
                } else {
                    print("no supported extension found for image")
                    return;
                }

                data!.writeToFile(localPath, atomically: true)
//                
//                let imageData = NSData(contentsOfFile: localPath)!
//                let photoURL = NSURL(fileURLWithPath: localPath)
//                let imageWithData = UIImage(data: imageData)!
//                

                
                self.delegate?.didPickImage?(localPath)
                
//                if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
//                    
//                    if let url = info[UIImagePickerControllerReferenceURL] as? NSURL {
//                        
//                        if let pathext = url.pathExtension {
//                            
//                            var path = NSSearchPathForDirectoriesInDomains(directory:NSSearchPathDirectory, domainMask:NSSearchPathDomainMask, expandTilde:true)
//                            
//                                        let data = NSData(contentsOfURL: url)
//                            let path = url.path!
//                            let mediaurl = info[UIImagePickerControllerMediaURL]
//                            self.delegate?.didPickImage?(pickedImage, imageExtension:pathext, path:url)
//
//                            
//                        }
//                    }
//                }
            
            } else if(mediaType == "public.movie") {
                if let pickedVideoUrl = info[UIImagePickerControllerMediaURL] {
                    self.delegate?.didPickVideo?(pickedVideoUrl as! NSURL)
                    
                }
            }
                
           }

            
            dismiss()
            
    }
    
    
    func imagePickerControllerDidCancel(let picker: UIImagePickerController) {
        dismiss()

    }
    
    
    
    
}
