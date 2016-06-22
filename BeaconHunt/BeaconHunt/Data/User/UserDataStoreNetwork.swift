//
//  UserDataStoreNetwork.swift
//  BeaconHunt
//
//  Created by Heather Downing on 6/19/16.
//  Copyright © 2016 Quorralyne. All rights reserved.
//

import Foundation

class UserDataStoreNetwork : UserDataStore {
    
    func loginUser(userLoginDict userLoginDict:[String:AnyObject], credential:Credential, success: (([String: AnyObject]?) -> ()), failure: ((NSError) -> ())) {
        WebServiceManager.sendRequest(
            endpoint: UserEndpoint.Login,
            credential: credential,
            data: JSONDataFromDictionary(userLoginDict),
            success: { (data) in  
                success( parseJSONDictionary(data: data) ) },
            failure: { (error) in 
                failure(error) })
    }
    
    func getAllUsers(success success: (([[String: AnyObject]]?) -> ()), failure: ((NSError) -> ())) {
        WebServiceManager.sendRequest(
            endpoint: UserEndpoint.GetAll,
            success: { (data) in  success( parseJSONDictionaryArray(data: data)) },
            failure: { (error) in failure(error) })
    }
    
    func getUser(userId userId:Int, success: (([String: AnyObject]?) -> ()), failure: ((NSError) -> ())) {
        WebServiceManager.sendRequest(
            endpoint: UserEndpoint.Get(userId),
            success: { (data) in  success( parseJSONDictionary(data: data)) },
            failure: { (error) in failure(error) })
    }
    
    func addUser(userDict userDict:[String:AnyObject], credential:Credential, success: (([String: AnyObject]?) -> ()), failure: ((NSError) -> ())) {
        WebServiceManager.sendRequest(
            endpoint: UserEndpoint.Add,
            credential: credential,
            data: JSONDataFromDictionary(userDict),
            success: { (data) in success( parseJSONDictionary(data: data) ) },
            failure: { (error) in failure(error) })
    }
    
    func deleteUser(userId userId:Int, credential:Credential, success: (() -> ()), failure: ((NSError) -> ())) {
        WebServiceManager.sendRequest(
            endpoint: UserEndpoint.Delete(userId),
            credential: credential,
            success: { (data) in  success() },
            failure: { (error) in failure(error) })
    }
    
    func getAllVisits(userId userId:Int, success: (([[String: AnyObject]]?) -> ()), failure: ((NSError) -> ())) {
        WebServiceManager.sendRequest(
            endpoint: UserEndpoint.GetAllVisits(userId),
            success: { (data) in  
                success( parseJSONDictionaryArray(data: data)) },
            failure: { (error) in 
                failure(error) })
    }
    
    func getVisit(userId userId:Int, beaconMinorId:Int, success: (([String: AnyObject]?) -> ()), failure: ((NSError) -> ())) {
        WebServiceManager.sendRequest(
            endpoint: UserEndpoint.GetVisit(userId, beaconMinorId),
            success: { (data) in  success( parseJSONDictionary(data: data)) },
            failure: { (error) in failure(error) })
    }
    
    func addVisit(userId userId:Int, visitDict:[String:AnyObject], credential:Credential, success: (() -> ()), failure: ((NSError) -> ())) {
        WebServiceManager.sendRequest(
            endpoint: UserEndpoint.AddVisit(userId),
            credential: credential,
            data: JSONDataFromDictionary(visitDict),
            success: { (data) in  success() },
            failure: { (error) in failure(error) })
    }
    
    func deleteAllVisits(userId userId:Int, credential:Credential, success: (() -> ()), failure: ((NSError) -> ())) {
        WebServiceManager.sendRequest(
            endpoint: UserEndpoint.DeleteAllVisits(userId),
            credential: credential,
            success: { (data) in  success() },
            failure: { (error) in failure(error) })
    }
    
    func deleteVisit(userId userId:Int, beaconMinorId:Int, credential:Credential, success: (() -> ()), failure: ((NSError) -> ())) {
        WebServiceManager.sendRequest(
            endpoint: UserEndpoint.DeleteVisit(userId, beaconMinorId),
            credential: credential,
            success: { (data) in  success() },
            failure: { (error) in failure(error) })
    }
}
