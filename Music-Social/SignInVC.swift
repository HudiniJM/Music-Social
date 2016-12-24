//
//  ViewController.swift
//  Music-Social
//
//  Created by Jonathan Mitchell on 12/17/16.
//  Copyright © 2016 JDM FZJ. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase
import SwiftKeychainWrapper

class SignInVC: UIViewController {
    
    @IBOutlet weak var emailField: fancyfield!
    @IBOutlet weak var passwordFd: fancyfield!

    override func viewDidLoad() {
        super.viewDidLoad()
        
}
    
    override func viewDidAppear(_ animated: Bool) {
        if let _ = KeychainWrapper.standard.string(forKey: KEY_UID) {
            performSegue(withIdentifier: "GoToFeed", sender: nil)
        }
}

    @IBAction func facebookBtnTapped(_ sender: AnyObject) {
        
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil {
                print("houdini: Unable to authenticate with Facebook - \(error)")
            } else if result?.isCancelled == true {
                print("Houdini: User cancelled Facebook authentication")
            } else {
                print("Houdini: Successfully authenticated with Facebook")
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential)
            }
        }
        
    }
    
    func firebaseAuth(_ credential: FIRAuthCredential) {
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if error != nil {
                print("Houdini: Unable to authenticate with Firebase - \(error)")
            } else {
                print("Houdini: Successfully authenticated with Firebase")
                if let user = user {
                    let userData = ["provider": credential.provider]
                   self.completeSignIn(id: user.uid, userData: userData)
                }
            }
        })
    }
        
    @IBAction func signinTapped(_ sender: Any) {
        
        if let email = emailField.text, let pwd = passwordFd.text {
            FIRAuth.auth()?.signIn(withEmail: email, password: pwd, completion: { (user, error) in
                if error == nil {
                    print("Houdini: Email user authenticated with firebase")
                   if let user = user {
                    let userData = ["provider": user.providerID]
                         self.completeSignIn(id: user.uid, userData: userData)
                    }
                } else {
                    FIRAuth.auth()?.createUser(withEmail: email, password: pwd, completion: { (user, error) in
                        if error != nil {
                            print("Houdini: Unable to authentcate with firebase using email")
                        } else {
                            print("Houdini: Successfully authenticated with firebase")
                            if let user = user {
                                let userData = ["provider": user.providerID]
                                self.completeSignIn(id: user.uid, userData: userData)
                            }
                            
                        }
                    })
                }
            })
        }
    }
    
    func completeSignIn(id: String, userData: Dictionary<String, String>) {
        DataService.ds.createFirebaseDBUser(uid: id, userData: userData)
        let keychainResult = KeychainWrapper.standard.set(id, forKey: KEY_UID)
        print("Houdini: Data saved to keychain \(keychainResult)")
        performSegue(withIdentifier: "GoToFeed", sender: nil)
    }
}
