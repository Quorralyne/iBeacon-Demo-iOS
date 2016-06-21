//
//  UserDataStore.swift
//  BeaconHunt
//
//  Created by Heather Downing on 6/19/16.
//  Copyright © 2016 Quorralyne. All rights reserved.
//

import Foundation

protocol UserDataStore {
    func getAllUsers(success success: (([[String: AnyObject]]?) -> ()), failure: ((NSError) -> ()))
    func getUser(userId userId:Int, success: (([String: AnyObject]?) -> ()), failure: ((NSError) -> ()))
    func addUser(userDict userDict:[String:AnyObject], credential:Credential, success: (() -> ()), failure: ((NSError) -> ()))
    func deleteUser(userId userId:Int, credential:Credential, success: (() -> ()), failure: ((NSError) -> ()))
    func getAllVisits(userId userId:Int, success: (([[String: AnyObject]]?) -> ()), failure: ((NSError) -> ()))
    func getVisit(userId userId:Int, visitId:Int, success: (([String: AnyObject]?) -> ()), failure: ((NSError) -> ()))
    func deleteAllVisits(userId userId:Int, credential:Credential, success: (() -> ()), failure: ((NSError) -> ()))
    func deleteVisit(userId userId:Int, visitId:Int, credential:Credential, success: (() -> ()), failure: ((NSError) -> ()))
}
