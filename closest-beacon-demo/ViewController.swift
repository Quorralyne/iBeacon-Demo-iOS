//
//  ViewController.swift
//  closest-beacon-demo
//
//  Created by Will Dages on 10/11/14.
//  @willdages on Twitter
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    let region = CLBeaconRegion(proximityUUID: NSUUID(UUIDString: "f7826da6-4fa2-4e98-8024-bc5b71e0893e")!, identifier: "Kontakt")
    
    @IBOutlet weak var myLabel: UILabel!
    
    func changeText(beaconMinor : Int) {
        self.myLabel.text = String(beaconMinor)
    }
    
    let colors = [
        44700: UIColor(red:0.92, green:0.03, blue:0.03, alpha:1.0), //Tl0y - RED
        7002: UIColor(red:0.92, green:0.83, blue:0.03, alpha:1.0), //eGri - YELLOW
        62749: UIColor(red:0.90, green:0.03, blue:0.92, alpha:1.0), //QsBE - PINK
        25234: UIColor(red:0.92, green:0.51, blue:0.03, alpha:1.0) //xb6T - ORANGE
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManager.delegate = self
        if (CLLocationManager.authorizationStatus() != CLAuthorizationStatus.AuthorizedWhenInUse) {
            locationManager.requestWhenInUseAuthorization()
        }
        locationManager.startRangingBeaconsInRegion(region)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
        let knownBeacons = beacons.filter{ $0.proximity != CLProximity.Unknown }
        if (knownBeacons.count > 0) {
            let closestBeacon = knownBeacons[0] as CLBeacon
            self.view.backgroundColor = self.colors[closestBeacon.minor.integerValue]
            self.changeText(closestBeacon.minor.integerValue)
        }
    }
    
}

