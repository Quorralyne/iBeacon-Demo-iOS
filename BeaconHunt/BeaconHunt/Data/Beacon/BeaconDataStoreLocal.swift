//
//  BeaconDataStoreLocal.swift
//  BeaconHunt
//
//  Created by Heather Downing on 6/19/16.
//  Copyright © 2016 Quorralyne. All rights reserved.
//

import Foundation

class BeaconDataStoreLocal : BeaconDataStore {
    
    private lazy var errorFileParse = NSError(domain: "BeaconDataStoreLocal", code: -1, userInfo: ["message":"File parse error."])
    private lazy var errorFileNotFound = NSError(domain: "BeaconDataStoreLocal", code: -1, userInfo: ["message":"File not found."])
    
    
    func getAllBeacons(success success: (([[String: AnyObject]]?) -> ()), failure: ((NSError) -> ())) {
        if let filepath = NSBundle.mainBundle().pathForResource("beacon-list-response", ofType: "json") {
            if let dict = parseJSONDictionaryArrayFile(filepath) { success(dict) }
            else { failure(errorFileParse) }
        } else { failure(errorFileNotFound) }
    }
    
    func getBeacon(beaconMinorId beaconMinorId:Int, success: (([String: AnyObject]?) -> ()), failure: ((NSError) -> ())) {
        if let filepath = NSBundle.mainBundle().pathForResource("get-beacon-response", ofType: "json") {
            if let dict = parseJSONDictionaryFile(filepath) { success(dict) }
            else { failure(errorFileParse) }
        } else { failure(errorFileNotFound) }
    }
    
    func addBeacon(beaconDict beaconDict:[String:AnyObject], credential:Credential, success: (() -> ()), failure: ((NSError) -> ())) {
        success()
    }
    
    func deleteBeacon(beaconMinorId beaconMinorId:Int, credential:Credential, success: (() -> ()), failure: ((NSError) -> ())) {
        success()
    }
    
    func getAllVisits(beaconMinorId beaconMinorId:Int, success: (([[String: AnyObject]]?) -> ()), failure: ((NSError) -> ())) {
        if let filepath = NSBundle.mainBundle().pathForResource("get-all-visits-response", ofType: "json") {
            if let dict = parseJSONDictionaryArrayFile(filepath) { success(dict) }
            else { failure(errorFileParse) }
        } else { failure(errorFileNotFound) }
    }
    
    func deleteAllVisits(beaconMinorId beaconMinorId:Int, credential:Credential, success: (() -> ()), failure: ((NSError) -> ())) {
        success()
    }
}
