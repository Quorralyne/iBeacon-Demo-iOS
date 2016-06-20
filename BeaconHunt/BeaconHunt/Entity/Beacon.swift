//
//  Beacon.swift
//  BeaconHunt
//
//  Created by Heather Downing on 6/19/16.
//  Copyright © 2016 Quorralyne. All rights reserved.
//

import Foundation

class Beacon : DictionaryConvertible {

    var beaconId     : Int      = 0
    var majorId      : Int      = 0
    var UUID         : String   = ""
    var manufacturer : String   = ""
    
    init() {}
    
    required convenience init(dictionary:[String:AnyObject]?) {
        self.init()
        guard let dict = dictionary else { return }
        if let beaconId = dict["beaconId"] as? String { self.beaconId = Int(beaconId) ?? 0 }
        if let majorId = dict["majorId"] as? String { self.majorId = Int(majorId) ?? 0 }
        if let UUID = dict["UUID"] as? String { self.UUID = UUID }
        if let manufacturer = dict["Manufacturer"] as? String { self.manufacturer = manufacturer }
    }
    
    func toDictionary() -> [String:AnyObject] {
        return [
            "beaconId"      : String(beaconId),
            "majorId"       : String(majorId),
            "UUID"          : UUID,
            "Manufacturer"  : manufacturer
        ]
    }
    
    static func beaconsFromDictionaryArray(dictArray:[[String:AnyObject]]?) -> [Beacon] {
        
        var beacons : [Beacon] = []
        for dict in dictArray ?? [] {
            beacons.append(Beacon(dictionary: dict))
        }
        return beacons
    }
}
