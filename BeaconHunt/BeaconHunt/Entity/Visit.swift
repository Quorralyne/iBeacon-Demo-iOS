//
//  Visit.swift
//  BeaconHunt
//
//  Created by Heather Downing on 6/19/16.
//  Copyright © 2016 Quorralyne. All rights reserved.
//

import Foundation

class Visit : DictionaryConvertible {
    
    var beaconMinorId   : Int    = 0
    var userId          : Int    = 0
    var timestamp       : String = ""
    
    init() {}
    
    convenience init(beaconMinorId:Int, userId:Int, timestamp:String) {
        self.init()
        self.beaconMinorId = beaconMinorId
        self.userId = userId
        self.timestamp = timestamp
    }
    
    required convenience init(dictionary:[String:AnyObject]?) {
        self.init()
        guard let dict   = dictionary else { return }
        if let beaconMinorId  = dict["BeaconMinorId"]  as? Int { self.beaconMinorId  = beaconMinorId }
        if let userId         = dict["UserId"]    as? Int { self.userId    = userId }
        if let timestamp      = dict["VisitedTimestamp"] as? String { self.timestamp = timestamp }
    }
    
    func toDictionary() -> [String:AnyObject] {
        return [
            "BeaconMinorId"     : beaconMinorId,
            "UserId"            : userId,
            "VisitedTimestamp"  : timestamp
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
