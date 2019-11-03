//
//  EditProfileViewController.swift
//  Market
//
//  Created by ioannis giannakidis on 26/10/19.
//  Copyright © 2019 ioannis giannakidis. All rights reserved.
//

import UIKit
import JGProgressHUD


class EditProfileViewController: UIViewController {

    //MARK: Iboutlets
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    let hud = JGProgressHUD(style: .dark)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadUserInfo()

    }
    //MARK: IBActions
    
    @IBAction func saveBarButtonPressed(_ sender: Any) {
       dismissKeyboard()
        if textFieldsHaveText() {
            let withValues = [kFIRSTNAME:nameTextField.text!,kLASTNAME:surnameTextField.text!,kFULLNAME: (nameTextField.text! + " " + surnameTextField.text!), kFULLADDRESS:addressTextField.text!]
            updateCurrentUserInFirestore(withValues: withValues) { (error) in
                if error == nil {
                    self.hud.textLabel.text = "Updated!"
                    self.hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                    self.hud.show(in: self.view)
                    self.hud.dismiss(afterDelay: 2.0)
                }else{
                    print("error updating user",error!.localizedDescription)
                    self.hud.textLabel.text = error!.localizedDescription
                    self.hud.indicatorView = JGProgressHUDErrorIndicatorView()
                    self.hud.show(in: self.view)
                    self.hud.dismiss(afterDelay: 2.0)
                }
            }
        }else {
            hud.textLabel.text = "All fields are required"
            hud.indicatorView = JGProgressHUDErrorIndicatorView()
            hud.show(in: self.view)
            hud.dismiss(afterDelay: 2.0)
            
        }
        
        
    }
    
    @IBAction func logOutButtonPressed(_ sender: Any) {
        logOutUser()
        
    }
    
    //MARK: UpdateUI
    private func loadUserInfo() {
        
        if MUser.currentUser() != nil {
            
            let currentUser = MUser.currentUser()!
            nameTextField.text = currentUser.firstName
            surnameTextField.text = currentUser.lastName
            addressTextField.text = currentUser.fullAddress
            
        }
        
        
    }
    //MARK: Helper func
    private func dismissKeyboard() {
        self.view.endEditing(false)
    }
    private func textFieldsHaveText() ->Bool {
        return (nameTextField.text != "" && surnameTextField.text != "" && addressTextField.text != "")
        
    }
    private func logOutUser(){
        MUser.logOutCurrentUser { (error) in
            if error == nil {
                print("logged out")
                self.navigationController?.popViewController(animated: true)
                
            }else {
                print("error loggint out",error?.localizedDescription)
            }
        }
    }
}
