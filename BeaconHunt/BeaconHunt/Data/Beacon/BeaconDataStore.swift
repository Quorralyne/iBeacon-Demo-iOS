//
//  BeaconDataStore.swift
//  BeaconHunt
//
//  Created by Heather Downing on 6/19/16.
//  Copyright © 2016 Quorralyne. All rights reserved.
//

import Foundation

protocol BeaconDataStore {
    func addBeacon(credential credential:Credential, success: (([String: AnyObject]?) -> ()), failure: ((NSError) -> ()))
    func getAllBeacons(success success: (([[String: AnyObject]]?) -> ()), failure: ((NSError) -> ()))
}
