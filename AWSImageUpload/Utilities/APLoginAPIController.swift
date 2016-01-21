//
//  APLoginAPIController.swift
//  SampleProject
//
//  Created by Saqib Usman on 10/7/15.
//  Copyright © 2015 Shamas Shahid. All rights reserved.
//

import Foundation

class APLoginAPIController {
    var delegate:APLoginProtocol
    
    init(delegate : APLoginProtocol) {
        self.delegate = delegate
    }
    
    func doLogin(userObject: AnyObject) {
        
        if ( userObject is User) {
            
            AuthManager.defaultManager().signInAs(userObject as! User, async: { (objects, error) -> Void in
                if error == nil {

                    self.delegate.APLoginSuccess(userObject)
                } else {
                    self.delegate.APLoginFail(error)
                }
            })
        
      
        }
        
    }
    
    
    
    
}