//
//  BeaconDataStore.swift
//  BeaconHunt
//
//  Created by Heather Downing on 6/19/16.
//  Copyright © 2016 Quorralyne. All rights reserved.
//

import Foundation

protocol BeaconDataStore {
    func getAllBeacons(success success: (([[String: AnyObject]]?) -> ()), failure: ((NSError) -> ()))
    func getBeacon(beaconId beaconId:Int, success: (([String: AnyObject]?) -> ()), failure: ((NSError) -> ()))
    func addBeacon(credential credential:Credential, success: (([String: AnyObject]?) -> ()), failure: ((NSError) -> ()))
    func deleteBeacon(beaconId beaconId:Int, credential:Credential, success: (() -> ()), failure: ((NSError) -> ()))
    func getAllVisits(beaconId beaconId:Int, success: (([[String: AnyObject]]?) -> ()), failure: ((NSError) -> ()))
    func deleteAllVisits(beaconId beaconId:Int, credential:Credential, success: (() -> ()), failure: ((NSError) -> ()))
}
