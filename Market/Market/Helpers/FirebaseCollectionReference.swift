//
//  FirebaseCollectionReference.swift
//  Market
//
//  Created by ioannis giannakidis on 01/08/2019.
//  Copyright © 2019 ioannis giannakidis. All rights reserved.
//

import Foundation
import FirebaseFirestore

enum FCollectionReference: String {
    case User
    case Category
    case Items
    case Basket
}

func FirebaseReference(_ collectionReference: FCollectionReference) -> CollectionReference {
    
    return Firestore.firestore().collection(collectionReference.rawValue)
}
