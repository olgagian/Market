//
//  FinishRegistrationViewController.swift
//  Market
//
//  Created by ioannis giannakidis on 23/10/19.
//  Copyright © 2019 ioannis giannakidis. All rights reserved.
//

import UIKit
import JGProgressHUD

class FinishRegistrationViewController: UIViewController {
//MARk: -IBOutlets
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var surnameTextField: UITextField!
    
    @IBOutlet weak var adressTextField: UITextField!
    
    @IBOutlet weak var doneButtonOutlet: UIButton!
    
    //MARK: - Vars
    let hud  = JGProgressHUD(style: .dark)
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
               surnameTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
               adressTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
           


    }
    //MARK: - IBActions
    @IBAction func doneButtonPressed(_ sender: Any) {
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @objc func textFieldDidChange(_ textField:UITextField) {
        updateDoneButtonStatus()
    }
    
    //MARK - helper
    
    private func updateDoneButtonStatus() {
        if nameTextField.text != "" && surnameTextField.text != "" && adressTextField.text != "" {
            doneButtonOutlet.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.4117647059, blue: 0.4705882353, alpha: 1)
            doneButtonOutlet.isEnabled = true
        }else {
            doneButtonOutlet.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            doneButtonOutlet.isEnabled = false
        }
        
    }
}
