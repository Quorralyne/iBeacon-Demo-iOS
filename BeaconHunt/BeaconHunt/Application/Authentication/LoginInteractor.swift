//
//  LoginInteractor.swift
//  BeaconHunt
//
//  Created by Heather Downing on 6/19/16.
//  Copyright © 2016 Quorralyne. All rights reserved.
//

import Foundation

protocol LoginInteractorInput {
    func loginUser(email email:String, key:String, output:LoginInteractorOutput)
}

protocol LoginInteractorOutput {
    func loginInteractor(loginInteractor:LoginInteractorInput, loginUserSuccess:Void)
    func loginInteractor(loginInteractor:LoginInteractorInput, didError error:NSError)
}

class LoginInteractor: LoginInteractorInput {
    
    private lazy var userRepository : UserRepository = UserRepository(dataStore: UserDataStoreNetwork())
    
    // MARK: - LoginInteractorInput Protocol
    
    func loginUser(email email:String, key:String, output:LoginInteractorOutput) {
        userRepository.loginUser(
            userLogin: UserLogin(email: email, key: key),
            credential: AppCredential(),
            success: { (user) in
                SetLoggedInUserID(user.userId)
                output.loginInteractor(self, loginUserSuccess: ())
            },
            failure: { (error) in output.loginInteractor(self, didError: error) })
    }
}
