//
//  AppCredential.swift
//  BeaconHunt
//
//  Created by Heather Downing on 6/19/16.
//  Copyright © 2016 Quorralyne. All rights reserved.
//

// Hard-coded web service credential for demonstration purposes

func AppCredential() -> Credential {
    return Credential(username: "BeaconBacon", password: "T3sterMcGee!")
}


private var _loggedInUserID : Int = 0
func GetLoggedInUserID() -> Int { return _loggedInUserID }
func SetLoggedInUserID(uid:Int) { _loggedInUserID = uid  }
