//
//  ItemsTableViewController.swift
//  Market
//
//  Created by ioannis giannakidis on 23/08/2019.
//  Copyright © 2019 ioannis giannakidis. All rights reserved.
//

import UIKit

class ItemsTableViewController: UITableViewController {
    //MARK: Vars
    var category:Category?
    var itemArray:[Item]=[]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //removes empty cells from tableview
        tableView.tableFooterView = UIView()
        self.title = category?.name
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if category != nil {
            //download items
            loadItems()
            
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return itemArray.count
        
        
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        // Configure the cell...

        return cell
    }
   

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "itemToAddItemSeg" {
            let vc = segue.destination as! AddItemViewController
            vc.category = category!
            
        }
        
    }
    //MARK: Load Items
    private func loadItems(){
        
    }

}
