//
//  CategoryCollectionViewController.swift
//  Market
//
//  Created by ioannis giannakidis on 01/08/2019.
//  Copyright © 2019 ioannis giannakidis. All rights reserved.
//

import UIKit


class CategoryCollectionViewController: UICollectionViewController {
//MARK: Vars
    var categoryArray: [Category] = []
    //mark Vie Lifecyccel
    private let sectionInSets = UIEdgeInsets(top: 20.0, left: 10.0, bottom: 20.0, right: 10.0)
    private let itemsPerRow:CGFloat = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadCategories()
    }

    
    // MARK: UICollectionViewDataSource

   

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return categoryArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CategoryCollectionViewCell
        cell.generateCell(categoryArray[indexPath.row])
    
        return cell
    }
    //MARK: UICollectionView Delegate
      override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
          performSegue(withIdentifier: "categoryToItemsSeg", sender: categoryArray[indexPath.row])
      }
    
    //MARK: Download catgories
    private func loadCategories() {
        downloadCategoriesFromFirebase { (allcatgories) in
            print("We have", allcatgories.count)
            self.categoryArray = allcatgories
            self.collectionView.reloadData()
        }
        
    }
  //MARK: NAvigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "categoryToItemsSeg" {
            let vc = segue.destination as! ItemsTableViewController
            vc.category = sender as! Category
        }
        
        
    }
    
  

    

}
extension CategoryCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInSets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth  / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInSets
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInSets.left
    }
}
