//
//  UserDataStoreLocal.swift
//  BeaconHunt
//
//  Created by Heather Downing on 6/19/16.
//  Copyright © 2016 Quorralyne. All rights reserved.
//

import Foundation

class UserDataStoreLocal : UserDataStore {
    
    private lazy var errorFileParse = NSError(domain: "UserDataStoreLocal", code: -1, userInfo: ["message":"File parse error."])
    private lazy var errorFileNotFound = NSError(domain: "UserDataStoreLocal", code: -1, userInfo: ["message":"File not found."])
    
    
    func loginUser(userLoginDict userLoginDict:[String:AnyObject], credential:Credential, success: (([String: AnyObject]?) -> ()), failure: ((NSError) -> ())) {
        if let filepath = NSBundle.mainBundle().pathForResource("login-user-response", ofType: "json") {
            if let dict = parseJSONDictionaryFile(filepath) { success(dict) }
            else { failure(errorFileParse) }
        } else { failure(errorFileNotFound) }
    }
    
    func getAllUsers(success success: (([[String: AnyObject]]?) -> ()), failure: ((NSError) -> ())) {
        if let filepath = NSBundle.mainBundle().pathForResource("get-all-users-response", ofType: "json") {
            if let dict = parseJSONDictionaryArrayFile(filepath) { success(dict) }
            else { failure(errorFileParse) }
        } else { failure(errorFileNotFound) }
    }
    
    func getUser(userId userId:Int, success: (([String: AnyObject]?) -> ()), failure: ((NSError) -> ())) {
        if let filepath = NSBundle.mainBundle().pathForResource("get-user-response", ofType: "json") {
            if let dict = parseJSONDictionaryFile(filepath) { success(dict) }
            else { failure(errorFileParse) }
        } else { failure(errorFileNotFound) }
    }
    
    func addUser(userDict userDict:[String:AnyObject], credential:Credential, success: (([String: AnyObject]?) -> ()), failure: ((NSError) -> ())) {
        if let filepath = NSBundle.mainBundle().pathForResource("add-user-response", ofType: "json") {
            if let dict = parseJSONDictionaryFile(filepath) { success(dict) }
            else { failure(errorFileParse) }
        } else { failure(errorFileNotFound) }
    }
    
    func deleteUser(userId userId:Int, credential:Credential, success: (() -> ()), failure: ((NSError) -> ())) {
        success()
    }
    
    func getAllVisits(userId userId:Int, success: (([[String: AnyObject]]?) -> ()), failure: ((NSError) -> ())) {
        if let filepath = NSBundle.mainBundle().pathForResource("get-all-visits-response", ofType: "json") {
            if let dict = parseJSONDictionaryArrayFile(filepath) { success(dict) }
            else { failure(errorFileParse) }
        } else { failure(errorFileNotFound) }
    }
    
    func getVisit(userId userId:Int, beaconMinorId:Int, success: (([String: AnyObject]?) -> ()), failure: ((NSError) -> ())) {
        success(nil)
    }
    
    func deleteAllVisits(userId userId:Int, credential:Credential, success: (() -> ()), failure: ((NSError) -> ())) {
        success()
    }
    
    func deleteVisit(userId userId:Int, beaconMinorId:Int, credential:Credential, success: (() -> ()), failure: ((NSError) -> ())) {
        success()
    }
}
