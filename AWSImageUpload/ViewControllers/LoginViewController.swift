//
//  LoginViewController.swift
//  AWSImageUpload
//
//  Created by Saqib Usman on 1/7/16.
//  Copyright © 2016 Saqib Usman. All rights reserved.
//

import UIKit

class LoginViewController : UIViewController, UITextFieldDelegate, APLoginProtocol {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var api: APLoginAPIController!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        emailTextField.becomeFirstResponder()
        passwordTextField.delegate = self
        api = APLoginAPIController(delegate: self)
        
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        loginButtonPressed(nil)
        return true
    }
    @IBAction func loginButtonPressed(sender: UIButton?) {
        let userObject = User()
        userObject.username = emailTextField.text
        userObject.password = passwordTextField.text
        
        api.doLogin(userObject)
    }

    // MARK: -- APLoginProtocol Methods
    
    func APLoginSuccess(object:AnyObject) {
        print("success")
        
       // let userObject = object as! User
        
        let storyboard = UIStoryboard(name: "ItemsList", bundle: nil);
        guard let navigation = storyboard.instantiateInitialViewController() as? UINavigationController else { fatalError("Initial view controller ust be a Naviagation Controller instance")
        }
        
        
        navigation.modalPresentationStyle = .OverCurrentContext
        navigation.modalTransitionStyle = .CrossDissolve
        presentViewController(navigation, animated: true, completion: nil);
    
    
    }
    
    func APLoginFail(error: NSError) {
        
        if (error.userInfo["resp"] != nil && error.userInfo["resp"]!.statusCode == 401) {
            self.showAlertForError(NSLocalizedString("invalid_login_msg", comment: ""))
        }
        
    }
    
    func showAlertForError(errorString : String) {
        let alertController = UIAlertController(title: "Error", message: errorString, preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)
        alertController.addAction(okAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
}
