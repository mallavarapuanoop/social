//
//  ViewController.swift
//  social
//
//  Created by Anoop Mallavarapu on 4/29/18.
//  Copyright © 2018 AnoopMallavarapu. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var emailField: FancyField!
    
    @IBOutlet weak var pwdField: FancyField!
    
   
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func facebookBtnTapped(_ sender: Any) {
        
        let facebookLogin = FBSDKLoginManager()
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil{
                print("unable to login- \(error)")
                
            }else if result?.isCancelled == true {
                print("user camcelled fb auth")
            }else{
                print("Successfully logged into Facebook")
                let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                
                self.firebaseAuth(credential)
            }
        }
        
    }
    
    func firebaseAuth(_ credential: AuthCredential){
        Auth.auth().signIn(with: credential) { (user, error) in
            if let error = error {
                
                print("unable to auth")
            }else{
                print("Successfully signed in with firebase")
            }
            
        }
        
    }
    
    
    @IBAction func signInTapped(_ sender: Any) {
        
        if let email = emailField.text, let pwd = pwdField.text {
            Auth.auth().signIn(withEmail: email, password: pwd) { (user, error) in
                if error == nil {
                    print("Anoop: Email user authenticated with firebase")
                }else{
                    Auth.auth().createUser(withEmail: email, password: pwd, completion: { (user, error) in
                        if error != nil {
                            print("unable to authenticate with firebase using Email")
                        }else{
                            print("Successfully signed with firebase")
                        }
                    })
                }
            }
        }
        
    }
    
   
    
    


}












