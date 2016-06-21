//
//  ChallengeDataStoreLocal.swift
//  BeaconHunt
//
//  Created by Heather Downing on 6/19/16.
//  Copyright © 2016 Quorralyne. All rights reserved.
//

import UIKit

class ChallengeDataStoreLocal : ChallengeDataStore {
    
    private lazy var errorFileParse = NSError(domain: "ChallengeDataStoreLocal", code: -1, userInfo: ["message":"File parse error."])
    private lazy var errorFileNotFound = NSError(domain: "BChallengeDataStoreLocal", code: -1, userInfo: ["message":"File not found."])
    
    
    func getAllChallenges(success success: (([[String: AnyObject]]?) -> ()), failure: ((NSError) -> ())) {
        if let filepath = NSBundle.mainBundle().pathForResource("get-all-challenges-response", ofType: "json") {
            if let dict = parseJSONDictionaryArrayFile(filepath) { success(dict) }
            else { failure(errorFileParse) }
        } else { failure(errorFileNotFound) }
    }
}
