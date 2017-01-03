//
//  dataServices.swift
//  Music-Social
//
//  Created by Jonathan Mitchell on 12/23/16.
//  Copyright © 2016 JDM FZJ. All rights reserved.
//

import Foundation
import Firebase
import SwiftKeychainWrapper

let DB_BASE = FIRDatabase.database().reference()
let STORAGE_BASE = FIRStorage.storage().reference()

class DataService {
    
    static let ds = DataService()
    
    //DB References
    private var _REF_BASE = DB_BASE
    private var _REF_POSTS = DB_BASE.child("posts")
    private var _REF_USERS = DB_BASE.child("user")
    
    // Storage references
    private var _REF_POST_IMG = STORAGE_BASE.child("Post-Pics")
    
    var REF_BASE: FIRDatabaseReference {
        return _REF_BASE
    }
    
    var REF_POSTS: FIRDatabaseReference {
        return _REF_POSTS
    }
    
    var REF_USERS: FIRDatabaseReference {
        return _REF_USERS
    }
//    var REF_USER_CURRENT: FIRDatabaseReference {
//        let uid = KeychainWrapper.defaultKeychainWrapper.string(forKey: KEY_UID)
//        let user = REF_USERS.child(uid!)
//        return user
//    }

    
    var REF_POST_IMG: FIRStorageReference {
        return _REF_POST_IMG
    }
    
    func createFirebaseDBUser(uid: String, userData: Dictionary<String, String>) {
        REF_USERS.child(uid).updateChildValues(userData)
    }
}
