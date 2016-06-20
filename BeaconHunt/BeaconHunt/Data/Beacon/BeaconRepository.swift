//
//  BeaconsRepository.swift
//  BeaconHunt
//
//  Created by Heather Downing on 6/19/16.
//  Copyright © 2016 Quorralyne. All rights reserved.
//

import Foundation

class BeaconsRepository {
    
    private var dataStore : BeaconDataStore? = nil
    
    required init(dataStore:BeaconDataStore) {
        self.dataStore = dataStore
    }
    
    func addBeacon(credential credential:Credential, success: (([String: AnyObject]?) -> ()), failure: ((NSError) -> ())){
        
    }
    
    func getAllBeacons(success success: (([Beacon]) -> ()), failure: ((NSError) -> ())){
        self.dataStore?.getAllBeacons(
            success: { (dictArray) in success(Beacon.beaconsFromDictionaryArray(dictArray)) },
            failure: { (error) in failure(error)})
    }
    
}
