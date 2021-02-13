//
//  UserProfile.swift
//  MemoKeep
//
//  Created by taima on 2/10/21.
//  Copyright © 2021 mac air. All rights reserved.
//

import Foundation
import FirebaseAuth

class UserProfile {
    static let shared = UserProfile()
    
    // get Phone number from user
    var mobileNumber: String? {
        get {
            return UserDefaults.standard.value(forKey: "mobileNumber") as? String
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "mobileNumber")
            UserDefaults.standard.synchronize()
        }
    }
    
    func isUserLogin() -> Bool {
        return  Auth.auth().currentUser != nil
    }
}
