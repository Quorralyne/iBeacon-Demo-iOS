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
    
    required convenience init(dictionary:[String:AnyObject]?) {
        self.init()
        guard let dict = dictionary else { return }
        if let userId  = dict["userId"] as? String { self.userId = Int(userId) ?? 0 }
        if let email   = dict["email"]  as? String { self.email = email }
        if let name    = dict["name"]   as? String { self.name = name }
    }
    
    func toDictionary() -> [String:AnyObject] {
        return [
            "userId"    : String(userId),
            "email"     : email,
            "name"      : name
        ]
    }
    
    static func usersFromDictionaryArray(dictArray:[[String:AnyObject]]?) -> [User] {
        var users : [User] = []
        for dict in dictArray ?? [] {
            users.append(User(dictionary: dict))
        }
        return users
    }
}


class LoginResponse : DictionaryConvertible {
    
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
