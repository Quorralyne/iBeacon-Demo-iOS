//
//  TestServiceInteractor.swift
//  BeaconHunt
//
//  Created by Heather Downing on 6/19/16.
//  Copyright © 2016 Quorralyne. All rights reserved.
//

import Foundation

protocol TestServiceInteractorInput {
    func getBeaconIds(output output:TestServiceInteractorOutput)
}

protocol TestServiceInteractorOutput {
    func outputBeaconIds(beaconIds: [String])
    func outputError(error:NSError)
}

class TestServiceInteractor: TestServiceInteractorInput {
    
    private lazy var repo : BeaconsRepository = BeaconsRepository(dataStore: BeaconDataStoreNetwork())
    
    // MARK: - TestServiceInteractorInput Protocol
    
    func getBeaconIds(output output:TestServiceInteractorOutput) {
        repo.getAllBeacons(
            success: { (beacons) in
                var ids : [String] = []
                for beacon in beacons {
                    ids.append(String(beacon.beaconId))
                }
                output.outputBeaconIds(ids)
            },
            failure: { (error) in output.outputError(error) })
    }
}
