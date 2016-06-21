//
//  ChallengeListInteractor.swift
//  BeaconHunt
//
//  Created by Heather Downing on 6/19/16.
//  Copyright © 2016 Quorralyne. All rights reserved.
//

import Foundation

protocol ChallengeListInteractorInput {
    func getChallengeList(output output:ChallengeListInteractorOutput)
}

protocol ChallengeListInteractorOutput {
    func challengeListInteractor(challengeListInteractor:ChallengeListInteractorInput, didGetChallengeList challengeList:[[String:AnyObject]])
    func challengeListInteractor(challengeListInteractor:ChallengeListInteractorInput, didError error:NSError)
}

class ChallengeListInteractor: ChallengeListInteractorInput {
    
    private lazy var challengeRepository : ChallengeRepository = ChallengeRepository(dataStore: ChallengeDataStoreLocal())
    private lazy var userRepository      : UserRepository   = UserRepository(dataStore: UserDataStoreLocal())
    
    // MARK: - ChallengeListInteractorInput Protocol
    
    func getChallengeList(output output:ChallengeListInteractorOutput) {
        challengeRepository.getAllChallenges(
            success: { (challenges) in  self.appendChallengeCompletions(challenges, output:output) },
            failure: { (error) in output.challengeListInteractor(self, didError: error) })
    }
    
    private func appendChallengeCompletions(challenges:[Challenge], output:ChallengeListInteractorOutput) {
        let userId = GetLoggedInUserID()
        userRepository.getAllVisits(
            userId: userId,
            success: {
                
                (visits) in
                var list = [[String:AnyObject]]()
                for challenge in challenges {
                    var dict = challenge.toDictionary()
                    dict["isFound"] = (visits.contains({ $0.beaconMinorId == challenge.beaconMinorId })) ? true : false
                    list.append(dict)
                }
                output.challengeListInteractor(self, didGetChallengeList: list)
                
            },
            failure: { (error) in output.challengeListInteractor(self, didError: error) })
    }
}
