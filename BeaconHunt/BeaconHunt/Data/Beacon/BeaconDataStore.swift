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
    func getBeacon(beaconMinorId beaconMinorId:Int, success: (([String: AnyObject]?) -> ()), failure: ((NSError) -> ()))
    func addBeacon(beaconDict beaconDict:[String:AnyObject], credential:Credential, success: (() -> ()), failure: ((NSError) -> ()))
    func deleteBeacon(beaconMinorId beaconMinorId:Int, credential:Credential, success: (() -> ()), failure: ((NSError) -> ()))
    func getAllVisits(beaconMinorId beaconMinorId:Int, success: (([[String: AnyObject]]?) -> ()), failure: ((NSError) -> ()))
    func deleteAllVisits(beaconMinorId beaconMinorId:Int, credential:Credential, success: (() -> ()), failure: ((NSError) -> ()))
}
