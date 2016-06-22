//
//  CreateUserInteractor.swift
//  BeaconHunt
//
//  Created by Heather Downing on 6/19/16.
//  Copyright © 2016 Quorralyne. All rights reserved.
//

import Foundation

protocol CreateUserInteractorInput {
    func createUser(name name:String, email:String, output:CreateUserInteractorOutput)
}

protocol CreateUserInteractorOutput {
    func createUserInteractor(createUserInteractor:CreateUserInteractorInput, createUserSuccess response:AddUserResponse)
    func createUserInteractor(createUserInteractor:CreateUserInteractorInput, didError error:NSError)
}

class CreateUserInteractor: CreateUserInteractorInput {
    
    private lazy var userRepository : UserRepository = UserRepository(dataStore: UserDataStoreNetwork())
    
    // MARK: - LoginInteractorInput Protocol
    
    func createUser(name name:String, email:String, output:CreateUserInteractorOutput) {
        userRepository.addUser(
            user: User(name: name, email: email),
            credential: AppCredential(),
            success: { (addUserResponse) in
                SetLoggedInUserID(addUserResponse.userId)
                output.createUserInteractor(self, createUserSuccess: addUserResponse) },
            failure: { (error) in output.createUserInteractor(self, didError: error) })
    }
}
