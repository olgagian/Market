//
//  Item.swift
//  Market
//
//  Created by ioannis giannakidis on 23/08/2019.
//  Copyright © 2019 ioannis giannakidis. All rights reserved.
//

import Foundation
import UIKit
class Item {
    var id:String!
    var categoryId: String!
    var name:String!
    var description:String!
    var price:Double!
    var imageLinks: [String]!
    
    init() {
        
    }
    init( _dictionary:NSDictionary) {
        id = _dictionary[kOBJECTID] as? String
        categoryId = _dictionary[kCATEGORYID] as? String
        name = _dictionary[kNAME] as? String
        description = _dictionary[kDESCRIPTION] as? String
        price = _dictionary[kPRICE] as? Double
        imageLinks = _dictionary[kIMAGELINKS] as? [String]
    }
    
}
//MARK Save items func
func saveItemToFireStore(_ item: Item){
    FirebaseReference(.Items).document(item.id).setData(itemDictionaryFrom(item) as! [String:Any])
    
}
//MARK: helper functions
func itemDictionaryFrom(_ item:Item) -> NSDictionary {
    return NSDictionary(objects: [item.id,item.categoryId, item.name,item.description,item.price,item.imageLinks], forKeys:  [kOBJECTID as NSCopying,kCATEGORYID as NSCopying, kNAME as NSCopying, kDESCRIPTION as NSCopying, kPRICE as NSCopying, kIMAGELINKS as NSCopying])
}
//MARK: Download Items
func downloadItemsFromfirebase(_ withCategoryId: String,completion: @escaping(_  itemArray:[Item])->Void) {
    var itemArray:[Item] = []
    FirebaseReference(.Items).whereField(kCATEGORYID, isEqualTo: withCategoryId).getDocuments { (snapshot, error) in
        guard let snapshot = snapshot else {
            completion(itemArray)
            return
        }
        if !snapshot.isEmpty {
            for itemDict in snapshot.documents{
                itemArray.append(Item(_dictionary: itemDict.data()as NSDictionary))
            }
        }
        completion(itemArray)
    }
}
