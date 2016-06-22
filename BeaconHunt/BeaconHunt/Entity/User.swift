//
//  User.swift
//  BeaconHunt
//
//  Created by Heather Downing on 6/19/16.
//  Copyright © 2016 Quorralyne. All rights reserved.
//

import Foundation

class User : DictionaryConvertible {
    
    var userId  : Int    = 0
    var email   : String = ""
    var name    : String = ""
    
    init() {}
    
    required convenience init(name:String, email:String) {
        self.init()
        self.name = name
        self.email = email
    }
    
    required convenience init(dictionary:[String:AnyObject]?) {
        self.init()
        guard let dict = dictionary else { return }
        if let userId  = dict["UserId"] as? Int { self.userId = userId }
        if let email   = dict["Email"]  as? String { self.email = email }
        if let name    = dict["Name"]   as? String { self.name = name }
    }
    
    func toDictionary() -> [String:AnyObject] {
        var dict = [String:AnyObject]()
        if (userId > 0)  { dict["UserId"] = userId }
        if (email != "") { dict["Email"] = email }
        if (name  != "") { dict["Name"] = name }
        return dict
    }
    
    static func usersFromDictionaryArray(dictArray:[[String:AnyObject]]?) -> [User] {
        var users : [User] = []
        for dict in dictArray ?? [] {
            users.append(User(dictionary: dict))
        }
        return users
    }
}


class AddUserResponse : DictionaryConvertible {
    
    var userId : Int = 0
    var name : String = ""
    var key : String = ""
    
    init() {}
    
    required convenience init(dictionary:[String:AnyObject]?) {
        self.init()
        guard let dict = dictionary else { return }
        if let userId = dict["UserId"] as? Int { self.userId = userId }
        if let name = dict["Name"]  as? String { self.name = name }
        if let key  = dict["key"]  as? String { self.key = key }
    }
    
    func toDictionary() -> [String:AnyObject] {
        return [
            "UserId": userId,
            "key"   : key
        ]
    }
}

class UserLogin : DictionaryConvertible {
    
    var email : String = ""
    var key   : String = ""
    
    init() {}
    
    convenience init(email:String, key:String) {
        self.init()
        self.email = email
        self.key = key
    }
    
    required convenience init(dictionary:[String:AnyObject]?) {
        self.init()
        guard let dict = dictionary else { return }
        if let email = dict["Email"]  as? String { self.email = email }
        if let key  = dict["Key"]  as? String { self.key = key }
    }
    
    func toDictionary() -> [String:AnyObject] {
        return [
            "Email" : email,
            "Key"   : key
        ]
    }
}
