//
//  UserClass.swift
//  Assignment1
//
//  Created by Bradley Jones on 2019-09-21.
//  Copyright © 2019 Bradley Jones. All rights reserved.
//

import UIKit

class UserClass: NSObject {
    
    
   public var savedName : String?
    var savedAddress : String?
    var savedPhone : String?
  public  var savedEmail : String?
    var savedAge : Int?
    var savedGender : String?
    var savedDOB : Date?

    
    
    func createUser(theName : String, theAddress : String, thePhone : String, theEmail : String, theAge : Int, theGender : String, theDOB : Date)
    {
        savedName = theName
        savedAddress = theAddress
        savedPhone = thePhone
        savedEmail = theEmail
        savedAge = theAge
        savedGender = theGender
        savedDOB = theDOB
    }
    
   
    
    
    
    
}
