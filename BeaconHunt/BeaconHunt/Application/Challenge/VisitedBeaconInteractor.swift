//
//  VisitedBeaconInteractor.swift
//  BeaconHunt
//
//  Created by Heather Downing on 6/19/16.
//  Copyright © 2016 Quorralyne. All rights reserved.
//

import Foundation

protocol VisitedBeaconInteractorInput {
    func addVisit(visit: Visit, output:VisitedBeaconInteractorOutput)
}

protocol VisitedBeaconInteractorOutput {
    func visitedBeaconInteractor(visitedBeaconInteractor:VisitedBeaconInteractorInput, didAddVisit:Void)
    func visitedBeaconInteractor(visitedBeaconInteractor:VisitedBeaconInteractorInput, didError error:NSError)
}

class VisitedBeaconInteractor: VisitedBeaconInteractorInput {
    
    private lazy var userRepository : UserRepository = UserRepository(dataStore: UserDataStoreNetwork())
    
    // MARK: - VisitedBeaconInteractorInput Protocol
    
    func addVisit(visit: Visit, output:VisitedBeaconInteractorOutput) {
        userRepository.addVisit(
            userId: GetLoggedInUserID(),
            visit: visit,
            credential: AppCredential(),
            success: { ( _) in output.visitedBeaconInteractor(self, didAddVisit: ()) },
            failure: { (error) in output.visitedBeaconInteractor(self, didError: error) })
    }
    
}
