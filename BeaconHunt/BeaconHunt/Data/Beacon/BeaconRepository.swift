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
    
    func getBeacon(beaconMinorId beaconMinorId:Int, success: ((Beacon) -> ()), failure: ((NSError) -> ())) {
        self.dataStore?.getBeacon(
            beaconMinorId: beaconMinorId,
            success: { (dict) in success(Beacon(dictionary: dict)) },
            failure: { (error) in     failure(error)})
    }
    
    func addBeacon(beacon:Beacon, credential:Credential, success: (() -> ()), failure: ((NSError) -> ())) {
        self.dataStore?.addBeacon(
            beaconDict: beacon.toDictionary(),
            credential: credential,
            success: { (dict) in  success() },
            failure: { (error) in failure(error)})
    }
    
    func deleteBeacon(beaconMinorId beaconMinorId:Int, credential:Credential, success: (() -> ()), failure: ((NSError) -> ())) {
        self.dataStore?.deleteBeacon(
            beaconMinorId: beaconMinorId,
            credential: credential,
            success: { ( _) in    success() },
            failure: { (error) in failure(error)})
    }
    
    func getAllVisits(beaconMinorId beaconMinorId:Int, success: (([Visit]) -> ()), failure: ((NSError) -> ())) {
        self.dataStore?.getAllVisits(
            beaconMinorId: beaconMinorId,
            success: { (dictArray) in success(Visit.visitsFromDictionaryArray(dictArray)) },
            failure: { (error) in     failure(error)})
    }
    
    func deleteAllVisits(beaconMinorId beaconMinorId:Int, credential:Credential, success: (() -> ()), failure: ((NSError) -> ())) {
        self.dataStore?.deleteAllVisits(
            beaconMinorId: beaconMinorId,
            credential: credential,
            success: { ( _) in    success() },
            failure: { (error) in failure(error)})
    }
}
