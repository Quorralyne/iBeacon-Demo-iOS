//
//  ChallengeDataStore.swift
//  BeaconHunt
//
//  Created by Heather Downing on 6/19/16.
//  Copyright © 2016 Quorralyne. All rights reserved.
//

import Foundation

protocol ChallengeDataStore {
    func getAllChallenges(success success: (([[String: AnyObject]]?) -> ()), failure: ((NSError) -> ()))
}
