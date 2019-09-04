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
        //tableView.tableFooterView = UIView()
        self.title = category?.name
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //self.tableView.reloadData()

        if category != nil {
            //download items
            loadItems()
            
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        return 1
        
        
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return itemArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ItemTableViewCell
        cell.generateCell(itemArray[indexPath.row])
        

    

        return cell
    }
   //MARK:TableView Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        showItemView(itemArray[indexPath.row])
        
    }

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "itemToAddItemSeg" {
            let vc = segue.destination as! AddItemViewController
            vc.category = category!
            
        }
        
    }
    private func showItemView(_ item:Item){
        let itemVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "itemView") as! ItemViewController
        itemVC.item = item
        self.navigationController?.pushViewController(itemVC, animated: true)
    }
    //MARK: Load Items
    private func loadItems(){
        downloadItemsFromfirebase(category!.id) { (allItems) in
            
            self.itemArray = allItems
           
            self.tableView.reloadData()
        }
    }

}
