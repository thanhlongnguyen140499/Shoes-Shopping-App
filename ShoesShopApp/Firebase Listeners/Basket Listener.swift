//
//  Basket Listener.swift
//  ShoesShopApp
//
//  Created by Nguyen Thanh Long on 12/15/20.
//  Copyright © 2020 Nguyen Thanh Long. All rights reserved.
//

import Foundation
import Firebase

class BasketListener: ObservableObject {
    @Published var orderBasket: OrderBasket!
    
    init() {
        downloadBasket()
    }
    
    func downloadBasket() {
        
        if FUser.currentUser() != nil {
            FirebaseReference(.Basket).whereField(kOWNERID, isEqualTo: FUser.currentId()).addSnapshotListener{(
                snapshot, error) in
                
                guard let snapshot = snapshot else {return}
                
                if !snapshot.isEmpty {
                    let basketData = snapshot.documents.first!.data()
                    
                    getShoesesFromFirestore(withIds: basketData[kSHOESIDS] as? [String] ?? []) {
                        (allShoeses) in
                        let basket = OrderBasket()
                        basket.ownerId = basketData[kOWNERID]  as? String
                        basket.id = basketData[kID] as? String
                        basket.items = allShoeses
                        self.orderBasket = basket
                    }
                }
            }
        }
    }
}

func getShoesesFromFirestore(withIds: [String], completion: @escaping (_ shoesArray: [Shoes]) -> Void) {
    
    var count = 0
    
    var shoesArray: [Shoes] = []
    
    if withIds.count == 0 {
        completion(shoesArray)
        return
    }
    for shoesId in withIds {
        FirebaseReference(.Menu).whereField(kID, isEqualTo: shoesId).getDocuments { (snapshot, error) in
            
            guard let snapshot = snapshot else { return }
            
            if !snapshot.isEmpty {
                
                let shoesData = snapshot.documents.first!
                
                shoesArray.append(Shoes(id: shoesData[kID] as? String ?? UUID().uuidString,
                                        name: shoesData[kNAME] as? String ?? "Unknown",
                                        imageName: shoesData[kIMAGENAME] as? String ?? "Unknown",
                    category: Category(rawValue: shoesData[kCATEGORY] as? String ?? "bitis") ?? .bitis,
                                        description: shoesData[kDESCRIPTION] as? String ?? " Descriptin is missing",
                                        price: shoesData[kPRICE] as? Double ?? 0.00 ))
                count += 1
                
            } else {
                print("have no shoes")
                completion(shoesArray)
            }
            
            if count == withIds.count {
                completion(shoesArray)
            }
        }
    }
    
        
}
