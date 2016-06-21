//
//  ChallengeDataStoreNetwork.swift
//  BeaconHunt
//
//  Created by Heather Downing on 6/19/16.
//  Copyright © 2016 Quorralyne. All rights reserved.
//

import UIKit

class ChallengeDataStoreNetwork : ChallengeDataStore {
    
    func getAllChallenges(success success: (([[String: AnyObject]]?) -> ()), failure: ((NSError) -> ())) {
        WebServiceManager.sendRequest(
            endpoint: ChallengeEndpoint.GetAll,
            success: { (data) in  success( parseJSONDictionaryArray(data: data)) },
            failure: { (error) in failure(error) })
    }
}
