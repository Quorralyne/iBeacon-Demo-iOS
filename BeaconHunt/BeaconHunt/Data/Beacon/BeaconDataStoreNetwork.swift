//
//  BeaconDataStoreNetwork.swift
//  BeaconHunt
//
//  Created by Heather Downing on 6/19/16.
//  Copyright © 2016 Quorralyne. All rights reserved.
//

import Foundation

class BeaconDataStoreNetwork : BeaconDataStore {
    
    func getAllBeacons(success success: (([[String: AnyObject]]?) -> ()), failure: ((NSError) -> ())) {
        WebServiceManager.sendRequest(
            endpoint: BeaconEndpoint.GetAll,
            success: { (data) in  success( parseJSONDictionaryArray(data: data)) },
            failure: { (error) in failure(error) })
    }
    
    func getBeacon(beaconMinorId beaconMinorId:Int, success: (([String: AnyObject]?) -> ()), failure: ((NSError) -> ())) {
        WebServiceManager.sendRequest(
            endpoint: BeaconEndpoint.Get(beaconMinorId),
            success: { (data) in  success( parseJSONDictionary(data: data)) },
            failure: { (error) in failure(error) })
    }
    
    func addBeacon(beaconDict beaconDict:[String:AnyObject], credential:Credential, success: (() -> ()), failure: ((NSError) -> ())) {
        WebServiceManager.sendRequest(
            endpoint: BeaconEndpoint.Add,
            credential: credential,
            data: JSONDataFromDictionary(beaconDict),
            success: { (data) in  success() },
            failure: { (error) in failure(error) })
    }
    
    func deleteBeacon(beaconMinorId beaconMinorId:Int, credential:Credential, success: (() -> ()), failure: ((NSError) -> ())) {
        WebServiceManager.sendRequest(
            endpoint: BeaconEndpoint.Delete(beaconMinorId),
            credential: credential,
            success: { (data) in  success() },
            failure: { (error) in failure(error) })
    }
    
    func getAllVisits(beaconMinorId beaconMinorId:Int, success: (([[String: AnyObject]]?) -> ()), failure: ((NSError) -> ())) {
        WebServiceManager.sendRequest(
            endpoint: BeaconEndpoint.GetAllVisits(beaconMinorId),
            success: { (data) in  success( parseJSONDictionaryArray(data: data)) },
            failure: { (error) in failure(error) })
    }
    
    func deleteAllVisits(beaconMinorId beaconMinorId:Int, credential:Credential, success: (() -> ()), failure: ((NSError) -> ())) {
        WebServiceManager.sendRequest(
            endpoint: BeaconEndpoint.DeleteAllVisits(beaconMinorId),
            credential: credential,
            success: { (data) in  success() },
            failure: { (error) in failure(error) })
    }
    
}
