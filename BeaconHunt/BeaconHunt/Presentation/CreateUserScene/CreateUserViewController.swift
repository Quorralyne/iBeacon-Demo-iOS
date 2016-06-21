//
//  CreateUserViewController.swift
//  BeaconHunt
//
//  Created by Heather Downing on 6/19/16.
//  Copyright © 2016 Quorralyne. All rights reserved.
//

import UIKit

class CreateUserViewController: UIViewController, CreateUserInteractorOutput, UITextFieldDelegate {
    
    @IBOutlet weak var nameField : UITextField!
    @IBOutlet weak var emailField : UITextField!
    @IBOutlet weak var createUserButton : UIButton!
    @IBOutlet weak var activityView : UIActivityIndicatorView!
    
    private let toChallengeListSceneSegueID = "toChallengeListSceneSegueID"
    
    private lazy var createUserInteractor : CreateUserInteractorInput = CreateUserInteractor()
    
    private var nameText : String {
        get { return nameField.text?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()) ?? "" }
    }
    
    private var emailText : String {
        get { return emailField.text?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()) ?? "" }
    }
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.resetFields()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }
    
    
    // MARK: - Actions
    
    @IBAction func createUserButtonButtonAction(sender:AnyObject?) {
        self.doCreateUser()
    }
    
    private func resetFields() {
        self.nameField.enabled = true
        self.emailField.enabled = true
        self.createUserButton.enabled = false
        self.activityView.hidden = true
        self.activityView.stopAnimating()
    }
    
    func conditionallyEnableCreateUserButton() {
        self.createUserButton.enabled = (self.nameText != "" && self.emailText != "")
    }
    
    private func doCreateUser() {
        self.displayCreateUserBegin()
        self.createUserInteractor.createUser(name: self.nameText, email: self.emailText, output: self)
    }
    
    private func displayCreateUserBegin() {
        self.nameField.enabled = false
        self.emailField.enabled = false
        self.createUserButton.enabled = false
        self.activityView.hidden = false
        self.activityView.startAnimating()
}
    
    private func displayCreateUserSuccess() {
        self.resetFields()
        
    }
    
    private func displayCreateUserFailed() {
        self.resetFields()
        self.displayErrorDialog(
            title:"Failed",
            message: "Something went wrong, please check that everything was entered correctly and try again."
        )
    }
    
    private func displayErrorDialog(title title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    private func displayPasskeyDialog(passkey:String) {
        let alert = UIAlertController(
            title: passkey,
            message: "This is your new passkey. Please remember it for future use.",
            preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { [weak self] (alertAction) in
            if let me = self { me.performSegueWithIdentifier(me.toChallengeListSceneSegueID, sender: me) }
        }))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    
    // MARK: - CreateUserInteractorOutput Protocol
    
    func createUserInteractor(createUserInteractor:CreateUserInteractorInput, createUserSuccess response:AddUserResponse) {
        dispatch_async(dispatch_get_main_queue()) {
            self.displayCreateUserSuccess()
        }
    }
    
    func createUserInteractor(createUserInteractor:CreateUserInteractorInput, didError error:NSError) {
        dispatch_async(dispatch_get_main_queue()) {
            self.displayCreateUserFailed()
            print("Create User Failed - Error (\(error.code)): \(error.userInfo)")
        }
    }
    
    
    // MARK: - UITextFieldDelegate
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        self.performSelector(#selector(conditionallyEnableCreateUserButton), withObject: nil, afterDelay: 0.25)
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        self.conditionallyEnableCreateUserButton()
    }
    
    func textFieldShouldClear(textField: UITextField) -> Bool {
        self.conditionallyEnableCreateUserButton()
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.conditionallyEnableCreateUserButton()
        if (textField == nameField) { emailField.becomeFirstResponder() }
        else { textField.resignFirstResponder() }
        return false
    }
    
}
