//
//  Visit.swift
//  BeaconHunt
//
//  Created by Heather Downing on 6/19/16.
//  Copyright © 2016 Quorralyne. All rights reserved.
//

import Foundation

class Visit : DictionaryConvertible {
    
    var visitId         : Int    = 0
    var beaconMinorId   : Int    = 0
    var userId          : Int    = 0
    var timestamp       : String = ""
    
    init() {}
    
    required convenience init(dictionary:[String:AnyObject]?) {
        self.init()
        guard let dict   = dictionary else { return }
        if let visitId   = dict["visitId"]   as? String { self.visitId   = Int(visitId)  ?? 0 }
        if let beaconMinorId  = dict["beaconMinorId"]  as? String { self.beaconMinorId  = Int(beaconMinorId) ?? 0 }
        if let userId    = dict["userId"]    as? String { self.userId    = Int(userId)   ?? 0 }
        if let timestamp = dict["timestamp"] as? String { self.timestamp = timestamp }
    }
    
    func toDictionary() -> [String:AnyObject] {
        return [
            "visitId"       : String(visitId),
            "beaconMinorId" : String(beaconMinorId),
            "userId"        : String(userId),
            "timestamp"     : timestamp
        ]
    }
    
    static func visitsFromDictionaryArray(dictArray:[[String:AnyObject]]?) -> [Visit] {
        var visits : [Visit] = []
        for dict in dictArray ?? [] {
            visits.append(Visit(dictionary: dict))
        }
        return visits
    }
}
