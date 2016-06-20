//
//  BeaconDataStoreNetwork.swift
//  BeaconHunt
//
//  Created by Heather Downing on 6/19/16.
//  Copyright © 2016 Quorralyne. All rights reserved.
//

import Foundation

class BeaconDataStoreNetwork: BeaconDataStore {
    
    func addBeacon(credential credential:Credential, success: (([String: AnyObject]?) -> ()), failure: ((NSError) -> ())) {
        WebServiceManager.sendRequest(
            endpoint: BeaconEndpoint.Add,
            credential: credential,
            success: { (data) in success( parseJSONDictionary(data: data)) },
            failure: { (error) in failure(error) })
        
    }
    
    func getAllBeacons(success success: (([[String: AnyObject]]?) -> ()), failure: ((NSError) -> ())) {
        WebServiceManager.sendRequest(
            endpoint: BeaconEndpoint.GetAll,
            success: { (data) in success( parseJSONDictionaryArray(data: data)) },
            failure: { (error) in failure(error) })
    }

}
