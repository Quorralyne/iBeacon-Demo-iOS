//
//  ChallengeListViewController.swift
//  BeaconHunt
//
//  Created by James Hall on 6/21/16.
//  Copyright © 2016 Quorralyne. All rights reserved.
//

import UIKit


protocol ChallengeListDetailPresenter {
    func setChallengeData(challengeData:[String:AnyObject])
}

class ChallengeListViewController : UITableViewController, ChallengeListInteractorOutput {
    
    private let tableCellId = "ChallengeListTableCell"
    
    var tableData : [[String:AnyObject]] = [] {
        didSet { self.tableDataCount = tableData.count }
    }
    
    private var tableDataCount : Int = 0
    
    private var selectedRow : Int = -1
    
    private let toChallengeSceneSegueID = "toChallengeSceneSegueID"
    
    private lazy var challengeListInteractor : ChallengeListInteractorInput = ChallengeListInteractor()
    
    
    func reload(animated animated:Bool) {
        if (animated) { self.tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: .Top) }
        else { self.tableView.reloadData() }
    }
    
    private func displayErrorDialog(title title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    private func refreshData() {
        self.challengeListInteractor.getChallengeList(output: self)
    }
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.clearsSelectionOnViewWillAppear = false
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.refreshData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destVC = segue.destinationViewController as? ChallengeListDetailPresenter {
            destVC.setChallengeData(tableData[selectedRow])
        }
    }
    
    private func performSegueToChallengeScene() {
        self.performSegueWithIdentifier(toChallengeSceneSegueID, sender: self)
    }
    
    
    // MARK: - ChallengeListInteractorOutput Protocol
    
    func challengeListInteractor(challengeListInteractor:ChallengeListInteractorInput, didGetChallengeList challengeList:[[String:AnyObject]]) {
        dispatch_async(dispatch_get_main_queue()) {
            self.tableData = challengeList
            self.reload(animated:true)
        }
    }
    
    func challengeListInteractor(challengeListInteractor:ChallengeListInteractorInput, didError error:NSError) {
        dispatch_async(dispatch_get_main_queue()) {
            let m : String = error.userInfo["message"]?.string ?? "Something went wrong."
            self.displayErrorDialog(title:"Error: \(error.code)", message: m)
        }
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableDataCount
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(tableCellId, forIndexPath: indexPath)
        let row = indexPath.row
        cell.textLabel?.text        =   tableData[row]["Title"] as? String
        cell.detailTextLabel?.text  =   tableData[row]["Description"] as? String
        cell.accessoryType          = ((tableData[row]["isFound"] as? Bool) ?? false) ? .Checkmark : .None
        return cell
    }
    
    
    // MARK: - Table view delegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        self.selectedRow = indexPath.row
        self.performSegueToChallengeScene()
    }

}
