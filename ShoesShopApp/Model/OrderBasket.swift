//
//  OrderBasket.swift
//  ShoesShopApp
//
//  Created by Nguyen Thanh Long on 12/15/20.
//  Copyright © 2020 Nguyen Thanh Long. All rights reserved.
//

import Foundation
import Firebase

class OrderBasket: Identifiable {
    
    var id: String!
    var ownerId: String!
    var items: [Shoes] = []
    
    var total: Double {
        if items.count > 0 {
            return items.reduce(0) {
                $0 + $1.price
            }
        } else {
            return 0.0
        }
    }
    
    func add(_ item: Shoes) {
        items.append(item)
    }
    
    func remove(_ item: Shoes) {
        
        if let index = items.firstIndex(of: item) {
            items.remove(at: index)
        }
    }
    
    func emptyBasket() {
        self.items = []
        // save to firebase
        saveBasketToFirestore()
    }
    
    func saveBasketToFirestore() {
        FirebaseReference(.Basket).document(self.id).setData(basketDictionaryFrom(self))
    }
}

func basketDictionaryFrom(_ basket: OrderBasket) -> [String: Any] {
    
    var allShoesIds: [String] = []
    
    for shoes in basket.items {
        allShoesIds.append(shoes.id)
    }
    
    return NSDictionary(objects: [basket.id,
                                 basket.ownerId,
                                 allShoesIds
                                ],
                        forKeys: [ kID as NSCopying,
                                  kOWNERID as NSCopying,
                                  kSHOESIDS as NSCopying
                                ]
    ) as! [String : Any]
    
}

