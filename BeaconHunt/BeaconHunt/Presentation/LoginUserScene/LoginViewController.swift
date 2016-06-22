//
//  LoginViewController.swift
//  BeaconHunt
//
//  Created by Heather Downing on 6/19/16.
//  Copyright © 2016 Quorralyne. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, LoginInteractorOutput, UITextFieldDelegate {
    
    @IBOutlet weak var emailField : UITextField!
    @IBOutlet weak var passkeyField : UITextField!
    @IBOutlet weak var loginButton : UIButton!
    @IBOutlet weak var createUserButton : UIButton!
    @IBOutlet weak var activityView : UIActivityIndicatorView!
    
    private let toChallengeListSceneSegueID = "toChallengeListSceneSegueID"
    private let toCreateUserSceneSegueID    = "toCreateUserSceneSegueID"
    
    private lazy var loginInteractor : LoginInteractorInput = LoginInteractor()
    
    private var emailText : String {
        get { return emailField.text?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()) ?? "" }
    }
    
    private var passkeyText : String {
        get { return passkeyField.text?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()) ?? "" }
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
    
    private func performSegueToChallengeListScene() {
        self.performSegueWithIdentifier(toChallengeListSceneSegueID, sender: self)
    }
    
    private func performSegueToCreateUserScene() {
        self.performSegueWithIdentifier(toCreateUserSceneSegueID, sender: self)
    }
    
    
    // MARK: - Actions
    
    @IBAction func loginButtonButtonAction(sender:AnyObject?) {
        self.doLogin()
    }
    
    @IBAction func createUserButtonButtonAction(sender:AnyObject?) {
        self.doCreateUser()
    }
    
    private func resetFields() {
        self.emailField.enabled = true
        self.passkeyField.enabled = true
        self.passkeyField.text = ""
        self.loginButton.enabled = false
        self.activityView.hidden = true
        self.activityView.stopAnimating()
    }
    
    func conditionallyEnableLoginButton() {
        self.loginButton.enabled = (self.emailText != "" && self.passkeyText != "")
    }
    
    private func doLogin() {
        self.displayLoginBegin()
        self.loginInteractor.loginUser(email: self.emailText, key: self.passkeyText, output: self)
    }
    
    private func doCreateUser() {
        self.performSegueToCreateUserScene()
    }
    
    private func displayLoginBegin() {
        self.emailField.enabled = false
        self.passkeyField.enabled = false
        self.loginButton.enabled = false
        self.activityView.hidden = false
        self.activityView.startAnimating()
    }
    
    private func displayLoginSuccess() {
        self.resetFields()
        self.performSegueToChallengeListScene()
    }
    
    private func displayLoginFailed() {
        self.resetFields()
        self.displayErrorDialog(
            title:"Failed",
            message: "Either the email address or the passkey were incorrect. Please try again."
        )
    }
    
    private func displayErrorDialog(title title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    
    // MARK: - LoginInteractorOutput Protocol
    
    func loginInteractor(loginInteractor:LoginInteractorInput, loginUserSuccess:Void) {
        dispatch_async(dispatch_get_main_queue()) {
            self.displayLoginSuccess()
        }
    }
    
    
    func loginInteractor(loginInteractor:LoginInteractorInput, didError error:NSError) {
        dispatch_async(dispatch_get_main_queue()) {
            self.displayLoginFailed()
            print("Login Failed - Error (\(error.code)): \(error.userInfo)")
        }
    }
    
    
    // MARK: - UITextFieldDelegate
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        self.performSelector(#selector(conditionallyEnableLoginButton), withObject: nil, afterDelay: 0.25)
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        self.conditionallyEnableLoginButton()
    }
    
    func textFieldShouldClear(textField: UITextField) -> Bool {
        self.conditionallyEnableLoginButton()
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.conditionallyEnableLoginButton()
        if (textField == emailField) { passkeyField.becomeFirstResponder() }
        else { textField.resignFirstResponder() }
        return false
    }
    
}
