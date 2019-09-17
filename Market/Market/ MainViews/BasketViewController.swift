//
//  BasketViewController.swift
//  Market
//
//  Created by ioannis giannakidis on 16/09/2019.
//  Copyright © 2019 ioannis giannakidis. All rights reserved.
//

import UIKit
import JGProgressHUD
class BasketViewController: UIViewController {
//MARK - IBOutlets
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var basketTotalPriceLabel: UILabel!
    @IBOutlet weak var totalItemsLabel: UILabel!
    @IBOutlet weak var tqbleView: UITableView!
    @IBOutlet weak var ckeckOutButtonOutlet: UIButton!
    //MARK: Vars
    var basket: Basket?
    var allItems: [Item] = []
    var purchasedItemIds: [String] = []
    let hud = JGProgressHUD(style: .dark)
//MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tqbleView.tableFooterView = footerView
        // Do any additional setup after  loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //TODO: check is user is logged in
        loadBasketFromFirestore()
    }
    @IBAction func checkoutButtonPressed(_ sender: Any) {
        
        
        
    }
    //MARK: Download basket
    private func loadBasketFromFirestore() {
        downloadBasketFromFirestore("1234") { (basket) in
            self.basket = basket
        
        }
    }
    
}
extension BasketViewController:UITableViewDelegate,UITableViewDataSource {
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         return UITableViewCell ()
    }
    
   
    
    
    
    
}
