//
//  ChallengeSceneViewController.swift
//  BeaconHunt
//
//  Created by Heather Downing on 6/20/16.
//  Copyright © 2016 Quorralyne. All rights reserved.
//

import UIKit
import CoreLocation

class ChallengeSceneViewController: UIViewController, CLLocationManagerDelegate, VisitedBeaconInteractorOutput, ChallengeListDetailPresenter {
    
    private var selectedChallenge: [String:AnyObject] = [:]

    @IBOutlet weak var statusLabel: UILabel? = nil
    @IBOutlet weak var titleLabel: UILabel? = nil
    @IBOutlet weak var descriptionLabel: UILabel? = nil
    @IBOutlet weak var hintLabel: UILabel? = nil
    @IBOutlet weak var hintButton: UIButton? = nil
    
    private lazy var visitedBeaconInteractor : VisitedBeaconInteractorInput = VisitedBeaconInteractor()
    
    let locationManager = CLLocationManager()
    
    let region = CLBeaconRegion(proximityUUID: NSUUID(UUIDString: "684BC3D2-2C4B-4E4B-9D68-A2EF548B203D")!, identifier: "Custom UUID")

    func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
        let knownBeacons = beacons.filter{ $0.proximity != CLProximity.Unknown }
        if (knownBeacons.count > 0) {
            let closestBeacon = knownBeacons[0] as CLBeacon
            if(closestBeacon.minor.integerValue == selectedChallenge["BeaconMinorId"] as? Int){
                
                visitedBeaconInteractor.addVisit(closestBeacon.minor.integerValue, output: self)
                
                self.changeStatusText("You found it! " + String(closestBeacon.minor.integerValue))
                self.view.backgroundColor = UIColor.greenColor()
            }
        }
    }
    
    func changeStatusText(text : String) {
        self.statusLabel?.text = String(text)
    }
    
    func showHintLabel(shouldShow:Bool){
        self.hintLabel?.hidden = !shouldShow
    }
    
    func hintLabelIsShown() -> Bool {
        return !(self.hintLabel?.hidden ?? true)
    }
    
    
    // MARK: - ChallengeListDetailPresenter Protocol
    
    func setChallengeData(challengeData:[String:AnyObject]) {
        self.selectedChallenge = challengeData
    }
    
    private func updateUIForSelectedChallengeData() {
        dispatch_async(dispatch_get_main_queue()) {
            let challengeData = self.selectedChallenge
            self.titleLabel?.text = challengeData["Title"] as? String
            self.descriptionLabel?.text = challengeData["Description"] as? String
            self.hintLabel?.text = challengeData["Note"] as? String
            self.showHintLabel(false)
        }
    }
    
    
    // MARK: - Actions
    
    @IBAction func hintButtonAction(sender:AnyObject?) {
        self.showHintLabel( !(hintLabelIsShown()) )
    }
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocationManager()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.startLocationManager()
        self.updateUIForSelectedChallengeData()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        stopLocationManager()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    private func setupLocationManager(){
        locationManager.delegate = self;
        
        if (CLLocationManager.authorizationStatus() != CLAuthorizationStatus.AuthorizedWhenInUse) {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    private func startLocationManager(){
        locationManager.startRangingBeaconsInRegion(region)
    }
    
    private func stopLocationManager(){
        locationManager.stopRangingBeaconsInRegion(region)
    }
    
    func visitedBeaconInteractor(visitedBeaconInteractor:VisitedBeaconInteractorInput, didAddVisit:Void){
        dispatch_async(dispatch_get_main_queue()) {
            print("Beacon visit recorded successfully.")
        }
    }
    
    func visitedBeaconInteractor(visitedBeaconInteractor:VisitedBeaconInteractorInput, didError error:NSError){
        dispatch_async(dispatch_get_main_queue()) {
            print("Error: \(error.code)")
        }
    }

}
