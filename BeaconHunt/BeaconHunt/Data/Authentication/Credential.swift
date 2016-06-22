//
//  Credential.swift
//  BeaconHunt
//
//  Created by Heather Downing on 6/19/16.
//  Copyright © 2016 Quorralyne. All rights reserved.
//

import Foundation

class Credential {
    
    var username : String = ""
    var password : String = ""
    
    convenience init(username:String, password:String){
        self.init()
        self.username = username
        self.password = password
    }
    
    func getBasicAuthString() -> String {
        let loginString : String = "\(username):\(password)"
        let loginData   : NSData = loginString.dataUsingEncoding(NSUTF8StringEncoding) ?? NSData()
        let encodedLoginString : String = loginData.base64EncodedStringWithOptions([])
        
        return "Basic \(encodedLoginString)"
    }

}
