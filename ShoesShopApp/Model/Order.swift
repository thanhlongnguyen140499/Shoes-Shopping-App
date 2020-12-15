//
//  Order.swift
//  iCoffeeSwiftUI
//
//  Created by Nguyen Thanh Long on 12/12/20.
//  Copyright © 2020 Nguyen Thanh Long. All rights reserved.
//

import Foundation

class Order: Identifiable {
    
    var id: String!
    var customerId: String!
    var orderItems: [Shoes] = []
    var amount: Double!
    
    func saveOrderToFirestore() {
        
        FirebaseReference(.Order).document(self.id).setData(orderDictionaryFrom(self)) {
            error in
            
            if error != nil {
                print("error saving order to firestore: ", error!.localizedDescription)
            }
        }
    }
}

func orderDictionaryFrom(_ order: Order) -> [String: Any] {
    
    var allShoesIds: [String] = []
    
    for shoes in order.orderItems {
        allShoesIds.append(shoes.id)
    }
    
    return NSDictionary(objects: [
        order.id,
        order.customerId,
        allShoesIds,
        order.amount
        ],
        forKeys: [
            kID as NSCopying,
            kCUSTOMERID as NSCopying,
            kSHOESIDS as NSCopying,
            kAMOUNT as NSCopying
    ]) as! [String : Any]
}
