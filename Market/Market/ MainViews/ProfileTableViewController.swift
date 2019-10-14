//
//  ProfileTableViewController.swift
//  Market
//
//  Created by ioannis giannakidis on 14/10/19.
//  Copyright © 2019 ioannis giannakidis. All rights reserved.
//

import UIKit

class ProfileTableViewController: UITableViewController {

    @IBOutlet weak var finishRegistrationButtonOutlet: UIButton!
    @IBOutlet weak var purschaseHistoryButtonOutlet: UIButton!
    //MARK:- vars
    var editBarButtonOutlet: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        
       
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //checkloggin in status
        checkLoginStatus()
    }

    // MARK: - Table view data source

   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }

//MARK: -Helpers
   
    
    private func checkLoginStatus() {
        if MUser.currentUser() == nil {
            createRightBarButton(title: "Login")
        } else {
            createRightBarButton(title: "Edit")
        }
    }
    private func createRightBarButton(title:String){
        editBarButtonOutlet = UIBarButtonItem(title: title, style: .plain, target:self , action: #selector(rightBarButtonItemPressed))
        self.navigationItem.rightBarButtonItem = editBarButtonOutlet
    }
    //MARK IBActions
    @objc func rightBarButtonItemPressed(){
        if editButtonItem.title == "Login" {
            showLoginView()
        }else {
            goToEditProfile()
            
        }
    }
   
    private func showLoginView() {
        let loginView = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier:"loginView")
        self.present(loginView, animated: true, completion: nil)
    }
    private func goToEditProfile() {
        print("edit profile")
    }
}
