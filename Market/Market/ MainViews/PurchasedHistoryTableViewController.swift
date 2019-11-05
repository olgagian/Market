//
//  PurchasedHistoryTableViewController.swift
//  Market
//
//  Created by ioannis giannakidis on 6/11/19.
//  Copyright © 2019 ioannis giannakidis. All rights reserved.
//

import UIKit

class PurchasedHistoryTableViewController: UITableViewController {
//mark-Vars
    var itemArray: [Item] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadItems()
    }
    // MARK: - Table view data source

   

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return  itemArray.count
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ItemTableViewCell

        cell.generateCell(itemArray[indexPath.row])

        return cell
    }
   
  //MARK: Load itemx
    private func loadItems(){
        
        downloadItems(MUser.currentUser()!.purchasedItemIds) { (allItems) in
            self.itemArray = allItems
            print("We have \(allItems.count)  purchased items")
            self.tableView.reloadData()
        }
        
    }
}
