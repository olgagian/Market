//
//  WelcomeViewController.swift
//  Market
//
//  Created by ioannis giannakidis on 19/09/2019.
//  Copyright © 2019 ioannis giannakidis. All rights reserved.
//

import UIKit
import JGProgressHUD
import NVActivityIndicatorView

class WelcomeViewController: UIViewController {
//MARK - IBOutels
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var resendButtonOulet: UIButton!
    //MARK: Vars
    let hud = JGProgressHUD(style: .dark)
    var activityIdicator: NVActivityIndicatorView?
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        activityIdicator=NVActivityIndicatorView(frame: CGRect(x: self.view.frame.width / 2 - 30, y: self.view.frame.height/2 - 30, width: 60, height: 60), type: .ballPulse, color: #colorLiteral(red: 0.9998469949, green: 0.491214727, blue: 0.4734867811, alpha: 1.0), padding: nil)
    }
  //MARKL IBActions
    @IBAction func cancelButtonPressed(_ sender: Any) {
        dismissView()
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        
    }
    
    @IBAction func registerButtonPressed(_ sender: Any) {
        if textFieldsHaveText() {
            registerUser()
        }else {
            hud.textLabel.text = "All fields are required"
            hud.indicatorView = JGProgressHUDErrorIndicatorView()
            hud.show(in: self.view)
            hud.dismiss(afterDelay: 2.0)
            
        }
    }
    @IBAction func forgotPasswordButtonPressed(_ sender: Any) {
        
    }
    
    @IBAction func resendEmailButtomPressed(_ sender: Any) {
        
    }
    //MARK: Register User
    private func registerUser() {
        showLoadingIndicator()
        MUser.registerUserWith(email: emailTextField.text!, password: passwordTextField.text!) { (error) in
            if error == nil {
                self.hud.textLabel.text = "Verification email send"
                self.hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                self.hud.show(in: self.view)
                self.hud.dismiss(afterDelay: 2.0)
            }else {
                print("error registering", error?.localizedDescription)
                self.hud.textLabel.text = error?.localizedDescription
                self.hud.indicatorView = JGProgressHUDErrorIndicatorView()
                self.hud.show(in: self.view)
                self.hud.dismiss(afterDelay: 2.0)
            }
            self.hideLoadinggIdicator()
        }
    }
    //MARk - helpers
    
    private func textFieldsHaveText()-> Bool {
        return emailTextField.text != "" && passwordTextField.text != ""
    }
    
    
    
    private func dismissView() {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK  -Activity Indicator
    private func showLoadingIndicator() {
        if activityIdicator != nil {
            self.view.addSubview(activityIdicator!)
            activityIdicator?.stopAnimating()
        }
    }
    
    private func hideLoadinggIdicator() {
        if activityIdicator != nil {
            activityIdicator!.removeFromSuperview()
            activityIdicator?.stopAnimating()
        }
    }
}
