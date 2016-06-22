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

    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var hintButton: UIButton!
    
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
        self.statusLabel.text = String(text)
    }
    
    func showHintLabel(){
        self.hintLabel.text = selectedChallenge["Note"] as? String
    }
    
    func setChallengeData(challengeData:[String:AnyObject]){
        self.selectedChallenge = challengeData
        self.titleLabel.text = challengeData["Title"] as? String
        self.descriptionLabel.text = challengeData["Description"] as? String
        self.hintLabel.text = ""
    }
    
    //MARK: - Actions
    
    @IBAction func hintButtonAction(sender:AnyObject?) {
        self.showHintLabel()
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLocationManager()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        startLocationManager()
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
        // do nothing for now
    }
    func visitedBeaconInteractor(visitedBeaconInteractor:VisitedBeaconInteractorInput, didError error:NSError){
        print("Error: \(error.code)")
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    // MARK: - Actions

}
