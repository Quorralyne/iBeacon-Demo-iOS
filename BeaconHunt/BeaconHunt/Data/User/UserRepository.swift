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
    
    func loginUser(user user:User, credential:Credential, success: ((LoginResponse) -> ()), failure: ((NSError) -> ())) {
        self.dataStore?.loginUser(
            userDict: user.toDictionary(),
            credential: credential,
            success: { (dict) in  success(LoginResponse(dictionary: dict)) },
            failure: { (error) in failure(error)})
    }
    
    func getAllUsers(success success: (([User]) -> ()), failure: ((NSError) -> ())) {
        dataStore?.getAllUsers(
            success: { (dictArray) in  success( User.usersFromDictionaryArray(dictArray) ) },
            failure: { (error) in failure(error) })
    }
    
    func getUser(userId userId:Int, success: ((User) -> ()), failure: ((NSError) -> ())) {
        self.dataStore?.getUser(
            userId: userId,
            success: { (dict) in success(User(dictionary: dict)) },
            failure: { (error) in     failure(error)})
    }
    
    func addUser(user user:User, credential:Credential, success: (() -> ()), failure: ((NSError) -> ())) {
        self.dataStore?.addUser(
            userDict: user.toDictionary(),
            credential: credential,
            success: { (dict) in  success() },
            failure: { (error) in failure(error)})
    }
    
    func deleteUser(userId userId:Int, credential:Credential, success: (() -> ()), failure: ((NSError) -> ())) {
        self.dataStore?.deleteUser(
            userId: userId,
            credential: credential,
            success: { ( _) in    success() },
            failure: { (error) in failure(error)})
    }
    
    func getAllVisits(userId userId:Int, success: (([Visit]) -> ()), failure: ((NSError) -> ())) {
        self.dataStore?.getAllVisits(
            userId: userId,
            success: { (dictArray) in success(Visit.visitsFromDictionaryArray(dictArray)) },
            failure: { (error) in     failure(error)})
    }
    
    func getVisit(userId userId:Int, visitId:Int, success: ((Visit) -> ()), failure: ((NSError) -> ())) {
        self.dataStore?.getVisit(
            userId: userId,
            visitId: visitId,
            success: { (dict) in success(Visit(dictionary: dict)) },
            failure: { (error) in     failure(error)})
    }
    
    func deleteAllVisits(userId userId:Int, credential:Credential, success: (() -> ()), failure: ((NSError) -> ())) {
        self.dataStore?.deleteAllVisits(
            userId: userId,
            credential: credential,
            success: { (dictArray) in success() },
            failure: { (error) in     failure(error)})
    }
    
    func deleteVisit(userId userId:Int, visitId:Int, credential:Credential, success: (() -> ()), failure: ((NSError) -> ())) {
        self.dataStore?.deleteVisit(
            userId: userId,
            visitId: visitId,
            credential: credential,
            success: { ( _) in    success() },
            failure: { (error) in failure(error)})
    }
}
