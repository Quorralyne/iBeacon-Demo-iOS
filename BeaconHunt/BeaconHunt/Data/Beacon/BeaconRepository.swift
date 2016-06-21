//
//  BeaconRepository.swift
//  BeaconHunt
//
//  Created by Heather Downing on 6/19/16.
//  Copyright © 2016 Quorralyne. All rights reserved.
//

import Foundation

class BeaconRepository {
    
    private var dataStore : BeaconDataStore? = nil
    
    required init(dataStore:BeaconDataStore) {
        self.dataStore = dataStore
    }
    
    func getAllBeacons(success success: (([Beacon]) -> ()), failure: ((NSError) -> ())) {
        self.dataStore?.getAllBeacons(
            success: { (dictArray) in success(Beacon.beaconsFromDictionaryArray(dictArray)) },
            failure: { (error) in     failure(error)})
    }
    
    func getBeacon(beaconId beaconId:Int, success: (([Beacon]) -> ()), failure: ((NSError) -> ())) {
        self.dataStore?.getAllBeacons(
            success: { (dictArray) in success(Beacon.beaconsFromDictionaryArray(dictArray)) },
            failure: { (error) in     failure(error)})
    }
    
    func addBeacon(credential credential:Credential, success: ((Beacon) -> ()), failure: ((NSError) -> ())) {
        self.dataStore?.addBeacon(
            credential: credential,
            success: { (dict) in  success(Beacon(dictionary: dict)) },
            failure: { (error) in failure(error)})
    }
    
    func deleteBeacon(beaconId beaconId:Int, credential:Credential, success: (() -> ()), failure: ((NSError) -> ())) {
        self.dataStore?.deleteBeacon(
            beaconId: beaconId,
            credential: credential,
            success: { ( _) in    success() },
            failure: { (error) in failure(error)})
    }
    
    func getAllVisits(beaconId beaconId:Int, success: (([Visit]) -> ()), failure: ((NSError) -> ())) {
        self.dataStore?.getAllVisits(
            beaconId: beaconId,
            success: { (dictArray) in success(Visit.visitsFromDictionaryArray(dictArray)) },
            failure: { (error) in     failure(error)})
    }
    
    func deleteAllVisits(beaconId beaconId:Int, credential:Credential, success: (() -> ()), failure: ((NSError) -> ())) {
        self.dataStore?.deleteAllVisits(
            beaconId: beaconId,
            credential: credential,
            success: { ( _) in    success() },
            failure: { (error) in failure(error)})
    }
}
