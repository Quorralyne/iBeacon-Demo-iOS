//
//  Challenge.swift
//  BeaconHunt
//
//  Created by James Hall on 6/21/16.
//  Copyright © 2016 Quorralyne. All rights reserved.
//

import UIKit

class Challenge : DictionaryConvertible {
    
    var beaconMinorId   : Int      = 0
    var title           : String   = ""
    var description     : String   = ""
    var hint            : String   = ""
    
    init() {}
    
    required convenience init(dictionary:[String:AnyObject]?) {
        self.init()
        guard let dict = dictionary else { return }
        if let beaconMinorId = dict["BeaconMinorId"] as? Int { self.beaconMinorId = beaconMinorId }
        if let title = dict["Title"] as? String { self.title = title }
        if let description = dict["Description"] as? String { self.description = description }
        if let hint = dict["Note"] as? String { self.hint = hint }
    }
    
    func toDictionary() -> [String:AnyObject] {
        return [
            "BeaconMinorId" : beaconMinorId,
            "Title"         : title,
            "Description"   : description,
            "Note"          : hint
        ]
    }
    
    static func challengesFromDictionaryArray(dictArray:[[String:AnyObject]]?) -> [Challenge] {
        var challenges : [Challenge] = []
        for dict in dictArray ?? [] {
            challenges.append(Challenge(dictionary: dict))
        }
        return challenges
    }
}
