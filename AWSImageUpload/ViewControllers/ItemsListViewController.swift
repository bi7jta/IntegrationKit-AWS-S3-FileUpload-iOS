//
//  ItemsListViewController.swift
//  AWSImageUpload
//
//  Created by Saqib Usman on 1/13/16.
//  Copyright © 2016 Saqib Usman. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

extension NSMutableData {
    func appendString(string: String) {
        let data = string.dataUsingEncoding(NSUTF8StringEncoding);//, allowLossyConversion: true)
        appendData(data!)
    }
}

class ItemsListViewController : UIViewController, UITableViewDelegate, UITableViewDataSource ,  LinkActionDelegate , GalaryPickerControllerDelegate {
    
    
    
    var dataSource = [Upload]()
//    
//    let picker =  UIImagePickerController()
//    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func uploadButtonPressed(sender: UIBarButtonItem) {

        let galaryController = GalaryPickerViewController();
        galaryController.modalPresentationStyle = .OverCurrentContext
        galaryController.modalTransitionStyle = .CrossDissolve
        galaryController.delegate = self
        presentViewController(galaryController, animated: true, completion: nil)

//        picker.allowsEditing = true
//        picker.sourceType  = .PhotoLibrary
//        
//        presentViewController(picker, animated: true, completion: nil)
//        
    }
    var refreshControl:UIRefreshControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: "handleRefresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl)
//        
//        picker.delegate = self
//        
        
        
        getAllUploads();

        
    }
    func handleRefresh(refreshControl: UIRefreshControl) {
        // Do some reloading of data and update the table view's data source
        // Fetch more objects from a web service, for example...
        
        // Simply adding an object to the data source for this example
        Upload.updateLinksAsync { (objects, error) -> Void in
            if(error != nil) {
                self.showAlertForError("Error occured in fetching upload items");
                
            } else {
                self.dataSource = objects as! [Upload]
                self.tableView.reloadData();
            }
            refreshControl.endRefreshing()
        }
    }
    private func getAllUploads() {
        Upload.allAsync { (objects, error) -> Void in
            if(error != nil) {
                self.showAlertForError("Error occured in fetching upload items");
                
            } else {
                 self.dataSource = objects as! [Upload]
                self.tableView.reloadData();
            }
        }
    }
    
    func showAlertForError(errorString : String) {
        let alertController = UIAlertController(title: "Error", message: errorString, preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)
        alertController.addAction(okAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count;
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("upload_item_cell_identifier") as! UploadItemCell
        cell.configureWithUploadItem(dataSource[indexPath.row],delegate:self)
        return cell;
        
    }
    
    func didSelectLink(linkStr:String?, nameStr:String?) {
        
        if let linkStr = linkStr {
            if let nameStr = nameStr {
                if nameStr.hasSuffix(".jpg") || nameStr.hasSuffix(".png")  ||  nameStr.hasSuffix(".jpeg") || nameStr.hasSuffix(".JPG")  || nameStr.hasSuffix(".PNG") || nameStr.hasSuffix(".JPEG"){
                
                    // jpg image
                    let storyboard = UIStoryboard(name: "FullImageView", bundle: nil)
                
                    guard let controller = storyboard.instantiateInitialViewController() as? FullImageViewController else { fatalError("Initial view controller ust be a FullImageview controller instance")
                    }
                
                    controller.imageUrlString = linkStr;
                
                    showViewController(controller, sender: self)
                
                
                }
                else {
                
                    let url = NSURL(string: linkStr)
                    let player = AVPlayer(URL: url!)
                    
                    let playercontroller = AVPlayerViewController()
                    
                    playercontroller.player = player
                    self.presentViewController(playercontroller, animated: true) {
                        if let validPlayer = playercontroller.player {
                            validPlayer.play()
                        }
                    }
                
                }
            }
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
  
    
    func didPickImage(path:String) {
        print("didPickImage")
    
        let urlSession = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        
        let url = Constants.uploadURL
        
        let userObject = AuthManager.defaultManager().currentCredentials! as! User
        let xSessionId = userObject.xSessionId
        let param = [String:String]()
        let boundary = generateBoundaryString()
        
        let request = NSMutableURLRequest(URL:url!)
        request.HTTPMethod = "POST"
        request.setValue("multipart/form-data; boundary=\"\(boundary)\"", forHTTPHeaderField: "Content-Type")
        request.setValue(xSessionId, forHTTPHeaderField: "xSessionId")

       request.timeoutInterval = 10000
        
//        imageExtension = imageExtension.lowercaseString
////        var imageData:NSData!
////        var fileName:String!
////        var filemimeType:String!
////        if imageExtension == "jpeg" || imageExtension == "jpg" {
////            imageData = UIImageJPEGRepresentation(image,1);
////            fileName = "file.jpg"
////            filemimeType = "image/jpg"
////        } else if imageExtension == "png" {
////            imageData = UIImagePNGRepresentation(image)
////            fileName = "file.png"
////            filemimeType = "image/png"
////        } else {
////            // no extions supported
////            return
////        }
//        
//       // imageData = NSData(contentsOfFile: path)
        
        let imageUrl = NSURL(fileURLWithPath: path)
        guard let fileName = imageUrl.lastPathComponent else {
            print("file name is not found from imageurl :\(imageUrl)")
            return;
        }
        
        guard let filemimeType = mimeTypeForImagePath(imageUrl) else {
            print("No supported mime type found for image url : \(imageUrl)")
            return;
        }
        
        guard let imageData = NSData(contentsOfURL: imageUrl) else {
            print("could not create the nsdata from image url : \(imageUrl)")
            return;
        }
        //imageData = imageData.base64EncodedDataWithOptions(.Encoding64CharacterLineLength);
  
        
        let body = createBodyWithParameters(param, filePathKey: "file", imageDataKey: imageData, boundary: boundary, fileName: fileName, fileMimeType: filemimeType)

        request.HTTPBody = body
        request.setValue("\(body.length)", forHTTPHeaderField:"Content-Length")

        let task = urlSession.dataTaskWithRequest(request) { (data, response, error) -> Void in
            
            if(error != nil) {
                print("error=\(error)")
                return
            }
            
            print("*****response = \(response)")
            do {
                let parsed = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)
                //print ("parsed data:\n \(parsed["error"])");
                let err = parsed["error"] as? String
                if(err != nil) {
                    self.showAlertForError(parsed["error"] as! String)
                }
            } catch let error as NSError {
                print("A JSON parsing error occurred, here are the details:\n \(error)")
            }
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print("****** response dta  = \(responseString!)")
            
            dispatch_async(dispatch_get_main_queue()) { // 2
                self.getAllUploads() // 3
            }
        }
        
        task.resume()
    
    }
    
    
    func didPickVideo(videoUrl:NSURL) {
        print("didPickVideo")
        
        let urlSession = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
    
        let url = Constants.uploadURL
        let userObject = AuthManager.defaultManager().currentCredentials! as! User
        let xSessionId = userObject.xSessionId
        let param = [String:String]()
        let boundary = generateBoundaryString()
        
        let request = NSMutableURLRequest(URL:url!)
        print("request: %@", request)
        
        request.HTTPMethod = "POST"
        request.setValue("multipart/form-data; boundary=\"\(boundary)\"", forHTTPHeaderField: "Content-Type")
        request.setValue(xSessionId, forHTTPHeaderField: "xSessionId")
        request.timeoutInterval = 10000
        
       // var videoData:NSData!
        
        guard let fileName = videoUrl.lastPathComponent else {
            print("file name is not found from Video Url : \(videoUrl)")
            return;
        }
        
        guard let mimeType = mimeTypeForVideoPath(videoUrl) else {
            print("No valid mimeType found for video url : \(videoUrl)")
            return;
        }
   
        guard let videoData = NSData(contentsOfURL: videoUrl) else {
            print("can not convert the data from video url : \(videoUrl)")
            return;
            
        }
        //imageData = imageData.base64EncodedDataWithOptions(.Encoding64CharacterLineLength);

        
        let body = createBodyWithParameters(param, filePathKey: "file", imageDataKey: videoData, boundary: boundary, fileName: fileName, fileMimeType: mimeType)
        
        request.HTTPBody = body
        request.setValue("\(body.length)", forHTTPHeaderField:"Content-Length")
        
        let task = urlSession.dataTaskWithRequest(request) { (data, response, error) -> Void in
            
            if(error != nil) {
                print("error=\(error)")
                return
            }
            
            print("*****response = \(response)")
            do {
                let parsed = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)
                //print ("parsed data:\n \(parsed["error"])");
                let err = parsed["error"] as? String
                if(err != nil) {
                    self.showAlertForError(parsed["error"] as! String)
                }
            } catch let error as NSError {
                print("A JSON parsing error occurred, here are the details:\n \(error)")
            }
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print("****** response dta  = \(responseString!)")
            
            dispatch_async(dispatch_get_main_queue()) { // 2
                self.getAllUploads() // 3
            }
        }
        
        task.resume()
        
        
    }
    
    
    func createBodyWithParameters(parameters: [String: String]?, filePathKey: String?, imageDataKey: NSData, boundary: String, fileName:String, fileMimeType:String) -> NSData {
        let body = NSMutableData();
        
//        if parameters != nil {
//            for (key, value) in parameters! {
//                body.appendString("--\(boundary)\r\n")
//                body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
//                body.appendString("\(value)\r\n")
//            }
//        }
        
        let filename = fileName
        
        
        let mimetype = fileMimeType
        
        body.appendString("\r\n")
        body.appendString("--\(boundary)\r\n")
        body.appendString("Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n")
       //body.appendString("\r\n")
        body.appendString("Content-Type: \(mimetype)\r\n\r\n")
        body.appendData(imageDataKey)
        
        body.appendString("\r\n")
        body.appendString("--\(boundary)--\r\n")
        
        return body
    }
    
    
    func mimeTypeForVideoPath(videoUrl:NSURL) -> String? {
        
        guard let videoFormate =  videoUrl.pathExtension?.lowercaseString else {
            print("Video is not of right formate")
            return nil;
        }
        switch(videoFormate) {
        case "flv":
            return "video/x-flv"
        case "mp4":
            return "video/mp4"
        case "m3u8":
            return "application/x-mpegURL"
        case "ts":
            return "video/MP2T"
        case "3gp":
            return "video/3gpp"
        case "mov":
            return "video/quicktime"
        case "avi":
            return "video/x-msvideo"
        case "wmv":
            return "video/x-ms-wmv"
        default:
            print("video formate \(videoFormate) is not supported")
            return nil

        }

    }
    
    
    func mimeTypeForImagePath(imageUrl:NSURL) -> String? {
        guard let imageformate =  imageUrl.pathExtension?.lowercaseString else {
            print("Image formate/extension is not right")
            return nil
        }
        
        switch(imageformate) {
        case "jpg","jpeg":
            return "image/jpg"
        case "png":
            return "image/png"
        default:
            print("image formate:\(imageformate) is not supported")
            return nil
        }
    }
    
//    func mimeTypeForPath(path: String) -> String {
//        let url = NSURL(fileURLWithPath: path)
//        let pathExtension = url.pathExtension
//        
//        if let uti =  UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, pathExtension! as NSString, nil)?.takeRetainedValue() {
//            if let mimetype = UTTypeCopyPreferredTagWithClass(uti, kUTTagClassMIMEType)?.takeRetainedValue() {
//                return mimetype as String
//            }
//        }
//        return "application/octet-stream";
//    }
//    
    
    func generateBoundaryString() -> String {
    //    return "asdfasdfasdfasdfasdfwerwer"
        return "Boundary-\(NSUUID().UUIDString)"
    }

    

}
