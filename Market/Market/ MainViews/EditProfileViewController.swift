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
    }
    
    @IBAction func logOutButtonPressed(_ sender: Any) {
        
        
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
    
}
