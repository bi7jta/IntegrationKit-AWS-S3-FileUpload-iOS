//
//  APLoginProtocol.swift
//  SampleProject
//
//  Created by Saqib Usman on 10/7/15.
//  Copyright © 2015 Shamas Shahid. All rights reserved.
//
protocol APLoginProtocol {
    
    func APLoginSuccess(object:AnyObject)
    func APLoginFail(error: NSError)
}