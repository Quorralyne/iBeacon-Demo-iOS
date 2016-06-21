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
        if let userId  = dict["userId"] as? String { self.userId = Int(userId) ?? 0 }
        if let email   = dict["email"]  as? String { self.email = email }
        if let name    = dict["name"]   as? String { self.name = name }
    }
    
    func toDictionary() -> [String:AnyObject] {
        var dict = [String:AnyObject]()
        if (userId > 0)  { dict["userId"] = userId }
        if (email != "") { dict["email"] = email }
        if (name  != "") { dict["name"] = name }
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
    
    var key : String = ""
    
    init() {}
    
    required convenience init(dictionary:[String:AnyObject]?) {
        self.init()
        guard let dict = dictionary else { return }
        if let key  = dict["key"]  as? String { self.key = key }
    }
    
    func toDictionary() -> [String:AnyObject] {
        return [
            "key"   : key
        ]
    }
}

class UserLogin : DictionaryConvertible {
    
    var username : String = ""
    var passkey  : String = ""
    
    init() {}
    
    convenience init(username:String, passkey:String) {
        self.init()
        self.username = username
        self.passkey = passkey
    }
    
    required convenience init(dictionary:[String:AnyObject]?) {
        self.init()
        guard let dict = dictionary else { return }
        if let username = dict["username"]  as? String { self.username = username }
        if let passkey  = dict["passkey"]  as? String { self.passkey = passkey }
    }
    
    func toDictionary() -> [String:AnyObject] {
        return [
            "username"  : username,
            "passkey"   : passkey
        ]
    }
}
