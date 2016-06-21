//
//  UserRepository.swift
//  BeaconHunt
//
//  Created by Heather Downing on 6/19/16.
//  Copyright © 2016 Quorralyne. All rights reserved.
//

import Foundation

class UserRepository {
    
    private var dataStore : UserDataStore? = nil
    
    required init(dataStore:UserDataStore) {
        self.dataStore = dataStore
    }
    
    
}
