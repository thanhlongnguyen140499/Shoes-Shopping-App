//
//  ShoesListener.swift
//  ShoesShopApp
//
//  Created by Nguyen Thanh Long on 12/15/20.
//  Copyright © 2020 Nguyen Thanh Long. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore

class ShoesListener: ObservableObject {
    
    @Published var shoeses: [Shoes] = []
    
    init() {
        downloadShoeses()
    }
    
    func downloadShoeses() {
        FirebaseReference(.Menu).getDocuments { (snapshot, error) in
            
            guard let snapshot = snapshot else { return}
            
            if !snapshot.isEmpty {
                self.shoeses = ShoesListener.shoesFromDictionary(snapshot)
            }
        }
    }
    
    static func shoesFromDictionary(_ snapshot: QuerySnapshot) -> [Shoes] {
     
        var allshoeses: [Shoes] = []
        
        for snapshot in snapshot.documents {
            
            let shoesData = snapshot.data()
            
            allshoeses.append(Shoes(id: shoesData[kID] as? String ?? UUID().uuidString,
                                   name: shoesData[kNAME] as? String ?? "Unknown",
                                   imageName: shoesData[kIMAGENAME] as? String ?? "Unknown",
                                   category: Category(rawValue: shoesData[kCATEGORY] as? String ?? "cold") ?? .nike, description: shoesData[kDESCRIPTION] as? String ?? "Description is missing", price: shoesData[kPRICE] as? Double ?? 0.0))
        }
        return allshoeses
    }
}
