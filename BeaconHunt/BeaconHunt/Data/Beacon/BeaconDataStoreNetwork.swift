//
//  BeaconDataStoreNetwork.swift
//  BeaconHunt
//
//  Created by Heather Downing on 6/19/16.
//  Copyright © 2016 Quorralyne. All rights reserved.
//

import Foundation

class BeaconDataStoreNetwork: BeaconDataStore {
    
    func getAllBeacons(success success: (([[String: AnyObject]]?) -> ()), failure: ((NSError) -> ())) {
        WebServiceManager.sendRequest(
            endpoint: BeaconEndpoint.GetAll,
            success: { (data) in  success( parseJSONDictionaryArray(data: data)) },
            failure: { (error) in failure(error) })
    }
    
    func getBeacon(beaconId beaconId:Int, success: (([String: AnyObject]?) -> ()), failure: ((NSError) -> ())) {
        WebServiceManager.sendRequest(
            endpoint: BeaconEndpoint.Get(beaconId),
            success: { (data) in  success( parseJSONDictionary(data: data)) },
            failure: { (error) in failure(error) })
    }
    
    func addBeacon(credential credential:Credential, success: (([String: AnyObject]?) -> ()), failure: ((NSError) -> ())) {
        WebServiceManager.sendRequest(
            endpoint: BeaconEndpoint.Add,
            credential: credential,
            success: { (data) in  success( parseJSONDictionary(data: data)) },
            failure: { (error) in failure(error) })
    }
    
    func deleteBeacon(beaconId beaconId:Int, credential:Credential, success: (() -> ()), failure: ((NSError) -> ())) {
        WebServiceManager.sendRequest(
            endpoint: BeaconEndpoint.Delete(beaconId),
            credential: credential,
            success: { (data) in  success() },
            failure: { (error) in failure(error) })
    }
    
    func getAllVisits(beaconId beaconId:Int, success: (([[String: AnyObject]]?) -> ()), failure: ((NSError) -> ())) {
        WebServiceManager.sendRequest(
            endpoint: BeaconEndpoint.GetAllVisits(beaconId),
            success: { (data) in  success( parseJSONDictionaryArray(data: data)) },
            failure: { (error) in failure(error) })
    }
    
    func deleteAllVisits(beaconId beaconId:Int, credential:Credential, success: (() -> ()), failure: ((NSError) -> ())) {
        WebServiceManager.sendRequest(
            endpoint: BeaconEndpoint.DeleteAllVisits(beaconId),
            credential: credential,
            success: { (data) in  success() },
            failure: { (error) in failure(error) })
    }
    
}
