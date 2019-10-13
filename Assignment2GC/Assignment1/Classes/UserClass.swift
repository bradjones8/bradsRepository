//
//  UserClass.swift
//  Assignment1
//
//  Created by Bradley Jones on 2019-09-21.
//  Copyright © 2019 Bradley Jones. All rights reserved.
//

import UIKit

class UserClass: NSObject {
    
    
    var savedName : String?
    var savedAddress : String?
    var savedPhone : String?
    var savedEmail : String?
    var savedAge : Int?
    var savedGender : String?
    var savedDOB : String?
    var savedAvatar : Int?
    var savedID : Int?

    
    
    func createUser(theID : Int, theName : String, theAddress : String, thePhone : String, theEmail : String, theAge : Int, theGender : String, theDOB : String, theAvatar : Int)
    {
        savedID = theID
        savedName = theName
        savedAddress = theAddress
        savedPhone = thePhone
        savedEmail = theEmail
        savedAge = theAge
        savedGender = theGender
        savedDOB = theDOB
        savedAvatar = theAvatar
    }
    
   
    
    
    
    
}
