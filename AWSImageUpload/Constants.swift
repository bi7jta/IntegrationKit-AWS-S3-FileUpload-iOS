//
//  Constants.swift
//  AWSImageUpload
//
//  Created by Matthew Hogan on 1/20/16.
//  Copyright © 2016 Saqib Usman. All rights reserved.
//

import Foundation

struct Constants {
    
    static let backend = NSURL(string: "https://immense-mountain-54681.herokuapp.com")!
    //static let backend = NSURL(string: "http://localhost:1337")!
    static let version = "api/v1/"
    
    static var baseURL: NSURL? {
        get {
            return backend.URLByAppendingPathComponent(version)
        }
    }
    
    static var signInURL: NSURL? {
        get {
            return backend.URLByAppendingPathComponent("auth/password/callback/")
        }
    }
    
    static var signOutURL: NSURL? {
        get {
            return backend.URLByAppendingPathComponent("auth/signout/")
        }
    }
    
    static var uploadURL: NSURL? {
        get {
            return backend.URLByAppendingPathComponent("api/uploads/")
        }
    }
    
}
