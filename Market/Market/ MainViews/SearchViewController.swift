//
//  SearchViewController.swift
//  Market
//
//  Created by ioannis giannakidis on 10/12/19.
//  Copyright © 2019 ioannis giannakidis. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    //IBOUTLETS
    @IBOutlet weak var searchOptionsView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButtonOutlet: UIButton!
  //MARK - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    //MARK= IBActions
    @IBAction func showSearchBar(_ sender: Any) {
    }
    
    @IBAction func searchButtonPressed(_ sender: Any) {
    }
    


//MARK - helpers
private func emptyTextField() {
    searchTextField.text = ""
}
private func dismissKeyboard() {
    self.view.endEditing(false)
}
}
extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         return UITableViewCell()
    }
    
    
    
}
