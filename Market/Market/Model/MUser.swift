//
//  MUser.swift
//  Market
//
//  Created by ioannis giannakidis on 27/09/2019.
//  Copyright © 2019 ioannis giannakidis. All rights reserved.
//

import Foundation
import FirebaseAuth

class MUser {
    
    let objectId:String
    var email:String
    var firstName:String
    var lastName:String
    var fullName:String
    var purchasedItemIds:[String]
    
    var fullAddress:String?
    var onBoard: Bool
    
    //MArk Initializers
    init(_objectId: String, _email:String, _firstName: String, _lastName: String) {
        
        
        objectId = _objectId
        email = _email
        firstName = _firstName
        lastName = _lastName
        fullName = _firstName + "  " + _lastName
        fullAddress = ""
        onBoard = false
        purchasedItemIds = []
    }
    init(_dictionary: NSDictionary) {
        objectId = _dictionary[kOBJECTID] as! String
        if let mail = _dictionary[kEMAIL] {
            email = mail as! String
        }else {
            email = ""
        }
        if let fname = _dictionary[kFIRSTNAME] {
            firstName = fname as! String
        }else {
            firstName = ""
        }
        if let lname = _dictionary[kLASTNAME] {
            lastName = lname as! String
        } else {
             lastName = ""
        }
        fullName = firstName+ "  " + lastName
        if let mail = _dictionary[kEMAIL] {
            email = mail as! String
        }else {
            email = ""
        }
    }
}
