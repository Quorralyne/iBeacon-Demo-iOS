//
//  ViewController.swift
//  LAB-Closest-Beacon
//
//  Created by Heather Downing on 6/20/16.
//  Copyright © 2016 Quorralyne. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    
//    let region = CLBeaconRegion(proximityUUID: NSUUID(UUIDString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D")!, identifier: "Estimotes")
    
//    let colors = [
//        40961: UIColor(red: 84/255, green: 77/255, blue: 160/255, alpha: 1),
//        56065: UIColor(red: 142/255, green: 212/255, blue: 220/255, alpha: 1),
//        52137: UIColor(red: 162/255, green: 213/255, blue: 181/255, alpha: 1),
//        52924: UIColor(red: 84/255, green: 77/255, blue: 160/255, alpha: 1),
//        9231: UIColor(red: 142/255, green: 212/255, blue: 220/255, alpha: 1),
//        26227: UIColor(red: 162/255, green: 213/255, blue: 181/255, alpha: 1)
//    ]
    
//    let region = CLBeaconRegion(proximityUUID: NSUUID(UUIDString: "f7826da6-4fa2-4e98-8024-bc5b71e0893e")!, identifier: "Kontakts")
//    
//    let colors = [
//        44700: UIColor(red:0.92, green:0.03, blue:0.03, alpha:1.0), //Tl0y - RED
//        7002: UIColor(red:0.92, green:0.83, blue:0.03, alpha:1.0), //eGri - YELLOW
//        62749: UIColor(red:0.90, green:0.03, blue:0.92, alpha:1.0), //QsBE - PINK
//        25234: UIColor(red:0.92, green:0.51, blue:0.03, alpha:1.0) //xb6T - ORANGE
//    ]
    
    let region = CLBeaconRegion(proximityUUID: NSUUID(UUIDString: "684BC3D2-2C4B-4E4B-9D68-A2EF548B203D")!, identifier: "Custom UUID")
    
    let colors = [
        9231: UIColor(red: 142/255, green: 212/255, blue: 220/255, alpha: 1), //Estimote - Blue
        62749: UIColor(red:0.90, green:0.03, blue:0.92, alpha:1.0), //Kontakt QsBE - PINK
    ]
    
    @IBOutlet weak var myLabel: UILabel!
    
    func changeText(beaconMinor : Int) {
        self.myLabel.text = String(beaconMinor)
    }
    
    func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
        let knownBeacons = beacons.filter{ $0.proximity != CLProximity.Unknown }
        if (knownBeacons.count > 0) {
            let closestBeacon = knownBeacons[0] as CLBeacon
            
            self.view.backgroundColor = self.colors[closestBeacon.minor.integerValue]
            self.changeText(closestBeacon.minor.integerValue)
        }
    }

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

}

