//
//  TestSceneViewController.swift
//  BeaconHunt
//
//  Created by Heather Downing on 6/19/16.
//  Copyright © 2016 Quorralyne. All rights reserved.
//

import UIKit

class TestSceneViewController: UIViewController, TestServiceInteractorOutput {

    @IBOutlet weak var testLabel : UILabel!
    @IBOutlet weak var testButton : UIButton!
    
    private lazy var testInteractor : TestServiceInteractorInput = TestServiceInteractor()
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

    
    // MARK: - Actions
    
    @IBAction func testButtonAction(sender:AnyObject?) {
        self.requestBeaconIds()
    }
    
    func requestBeaconIds() {
        self.testInteractor.getBeaconIds(output: self)
    }
    
    // MARK: - TestServiceInteractorOutput Protocol
    func outputBeaconIds(beaconMinorIds: [String]){
        dispatch_async(dispatch_get_main_queue()) {
            self.testLabel.text = "BEACONS:\n\(beaconMinorIds.joinWithSeparator(", "))"
        }
    }
    func outputError(error:NSError){
        dispatch_async(dispatch_get_main_queue()) {
            self.testLabel.text = "Error: \(error.code)"
        }
    }
}
