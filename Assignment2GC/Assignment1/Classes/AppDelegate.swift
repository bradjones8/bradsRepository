//
//  AppDelegate.swift
//  Assignment1
//
//  Created by Bradley Jones on 2019-09-21.
//  Copyright © 2019 Bradley Jones. All rights reserved.
//

import UIKit
import SQLite3

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var avatar = 0
    var databaseName : String? = "MyDatabase.db"
    var databasePath : String?
    var users : [UserClass] = []

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        avatar = 0
        
        let documentPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        
        let documentsDir = documentPaths[0]
        
        databasePath = documentsDir.appending("/" + databaseName!)
        
        
        checkAndCreateDatabase()
        readDataFromDatabase()
        
        
        return true
    }
    
    func insertToDatabase(user : UserClass) -> Bool
    {
        var db :  OpaquePointer? = nil
        var returnCode : Bool = true
        
        if sqlite3_open(self.databasePath, &db) == SQLITE_OK
        {
            var insertStatement : OpaquePointer? = nil
            var insertStatementString : String = "insert into entries values(NULL, ?, ?, ?, ?, ?, ?, ?, ?)"
            if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK
            {
                let nameStr = user.savedName! as NSString
                let addressStr = user.savedAddress! as NSString
                let  phoneStr = user.savedPhone! as NSString
                let emailStr = user.savedEmail! as NSString
                let ageInt  = user.savedAge! as NSInteger
                let genderStr = user.savedGender! as NSString
                let dobStr = user.savedDOB! as NSString
                let  avatarInt = user.savedAvatar! as NSInteger
                
                sqlite3_bind_text(insertStatement, 1, nameStr.utf8String, -1, nil)
                
                sqlite3_bind_text(insertStatement, 2, addressStr.utf8String, -1, nil)
                
                sqlite3_bind_text(insertStatement, 3, phoneStr.utf8String, -1, nil)
                
                sqlite3_bind_text(insertStatement, 4, emailStr.utf8String, -1, nil)
                
                sqlite3_bind_int(insertStatement, 5, Int32(ageInt))
                
                    sqlite3_bind_text(insertStatement, 6, genderStr.utf8String, -1, nil)
                
                sqlite3_bind_text(insertStatement, 7, dobStr.utf8String, -1, nil)
                
                sqlite3_bind_int(insertStatement, 8, Int32(avatarInt))
                
                
                if sqlite3_step(insertStatement) == SQLITE_DONE
                {
                    let  rowID = sqlite3_last_insert_rowid(db)
                  
                }
                else
                {
               
                    returnCode = false
                }
                sqlite3_finalize(insertStatement)
            }
            else
            {
               
                returnCode = false
            }
            sqlite3_close(db)
        }
        else
        {
            
            returnCode = false
        }
        
        
        return returnCode
    }
    
    func readDataFromDatabase()
    {
        users.removeAll()
        
        var db : OpaquePointer? = nil
        
        if  sqlite3_open(self.databasePath,  &db) == SQLITE_OK {
           
            
            var queryStatement : OpaquePointer? = nil
            var queryStatementString : String = "select * from entries"
            
            if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK  {
                while sqlite3_step(queryStatement) == SQLITE_ROW{
                    
                    let id : Int =  Int(sqlite3_column_int(queryStatement, 0))
                    
                    let cname  = sqlite3_column_text(queryStatement, 1)
                    
                    let  caddress = sqlite3_column_text(queryStatement, 2)
                    
                    let cphone = sqlite3_column_text(queryStatement, 3)
                    
                    let cemail = sqlite3_column_text(queryStatement, 4)
                    
                    let age = Int(sqlite3_column_int(queryStatement, 5))
                    
                    let  cgender = sqlite3_column_text(queryStatement, 6)
                    
                    let cdob = sqlite3_column_text(queryStatement, 7)
                    
                    let avatar = Int(sqlite3_column_int(queryStatement, 8))
                    
                    let name = String(cString: cname!)
                    let address = String(cString: caddress!)
                    let phone = String(cString: cphone!)
                    let email = String(cString: cemail!)
                    let gender = String(cString: cgender!)
                    let dob = String(cString: cdob!)
                    
                    let user : UserClass = UserClass.init()
                    user.createUser(theID: id, theName: name, theAddress: address, thePhone: phone, theEmail: email, theAge: age, theGender: gender, theDOB: dob, theAvatar: avatar)
                    
                    users.append(user)
                    
                   
                }
                  sqlite3_finalize(queryStatement)
            }
            else{
           
            }
            
           sqlite3_close(queryStatement)
            
        }
        else{
           
        }
    }
    
    func checkAndCreateDatabase()
    {
       var success = false
        let fileManager = FileManager.default
        
        success = fileManager.fileExists(atPath: databasePath!)
        
        if success
        {
            return
        }
        
        let databasePathFromApp = Bundle.main.resourcePath?.appending("/" + databaseName!)
        
       try? fileManager.copyItem(atPath: databasePathFromApp!, toPath: databasePath!)
        
        return
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

