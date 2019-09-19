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
            self.getBasketItems()
        }
    }
    private func getBasketItems() {
        if basket != nil {
            downloadItems(basket!.itemIds) { (allItems) in
                self.allItems = allItems
                self.updateTotalLabels(false)
                self.tqbleView.reloadData()
            }
        }
    }
    
    //MARK: -Helper functions
    private func updateTotalLabels(_ isEmpty: Bool) {
        if isEmpty {
            totalItemsLabel.text = "0"
            basketTotalPriceLabel.text = returnBasketTotalPrice()
        }
        else {
            totalItemsLabel.text = "\(allItems.count)"
            basketTotalPriceLabel.text = returnBasketTotalPrice()

        }
        checkoutButtonStatusUpdate()
    }
    private func returnBasketTotalPrice()-> String {
        var totalPrice = 0.0
        
        for item in allItems {
            totalPrice +=  item.price
            
        }
        return "Total price: " + convertToCurrency(totalPrice)
    }
    //MARK - Navgiation
    func showItemView(withItem: Item){

            let itemVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "itemView") as! ItemViewController
            itemVC.item = withItem
            self.navigationController?.pushViewController(itemVC, animated: true)
    
    }
    //MARK: control checkoututton
    private func checkoutButtonStatusUpdate() {
        ckeckOutButtonOutlet.isEnabled = allItems.count  > 0
        if ckeckOutButtonOutlet.isEnabled {
            ckeckOutButtonOutlet.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        }else {
            disableCheckoutButton()
        }
        tqbleView.reloadData()
    }
    private func disableCheckoutButton() {
        ckeckOutButtonOutlet.isEnabled = false
        ckeckOutButtonOutlet.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)

    }
    private func  removeItemFromBasket(itemId: String) {
        
        for i in 0..<basket!.itemIds.count {
            if itemId == basket!.itemIds[i] {
                basket!.itemIds.remove(at: i)
                return
            }
        }
    }
}
extension BasketViewController:UITableViewDelegate,UITableViewDataSource {
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tqbleView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as!  ItemTableViewCell
        cell.generateCell(allItems[indexPath.row])
        
        return cell
    }
    
   //MARK - uitableview Delegata
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let itemToDelete = allItems[indexPath.row]
            allItems.remove(at: indexPath.row)
            tqbleView.reloadData()
            removeItemFromBasket(itemId: itemToDelete.id)
            updateBasketinFirestore(basket!, withValues: [kITEMIDS:basket!.itemIds]) { (error) in
                if error != nil {
                    print("error updating the basket",error!.localizedDescription)
                }
                self.getBasketItems()
            }
            
        }
        }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tqbleView.deselectRow(at: indexPath, animated: true)
        showItemView(withItem: allItems[indexPath.row])

    }


}
    
    
    

