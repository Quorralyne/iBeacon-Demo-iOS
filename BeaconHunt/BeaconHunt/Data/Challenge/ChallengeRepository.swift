//
//  ChallengeRepository.swift
//  BeaconHunt
//
//  Created by Heather Downing on 6/19/16.
//  Copyright © 2016 Quorralyne. All rights reserved.
//

import Foundation

class ChallengeRepository {
    
    private var dataStore : ChallengeDataStore? = nil
    
    required init(dataStore:ChallengeDataStore) {
        self.dataStore = dataStore
    }
    
    func getAllChallenges(success success: (([Challenge]) -> ()), failure: ((NSError) -> ())) {
        self.dataStore?.getAllChallenges(
            success: { (dictArray) in success(Challenge.challengesFromDictionaryArray(dictArray)) },
            failure: { (error) in     failure(error)})
    }
    
}
