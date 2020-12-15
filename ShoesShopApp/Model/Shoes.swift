//
//  Shoes.swift
//  ShoesShopApp
//
//  Created by Nguyen Thanh Long on 12/14/20.
//  Copyright © 2020 Nguyen Thanh Long. All rights reserved.
//

import Foundation
import SwiftUI

enum Category: String, CaseIterable, Codable, Hashable {
    
    case nike
    case adidas
    case bitis
}

struct Shoes: Identifiable, Hashable{
    var id: String
    var name: String
    var imageName: String
    var category: Category
    var description: String
    var price: Double
}

func shoesDictionaryFrom(shoes: Shoes) -> [String: Any] {
    
    return NSDictionary(objects: [shoes.id,
                                  shoes.name,
                                  shoes.imageName,
                                  shoes.category.rawValue,
                                  shoes.description,
                                  shoes.price
                                ],
                        forKeys: [kID as NSCopying,
                                 kNAME as NSCopying,
                                 kIMAGENAME as NSCopying,
                                 kCATEGORY as NSCopying,
                                 kDESCRIPTION as NSCopying,
                                 kPRICE as NSCopying
    ]) as! [String : Any]
}

func createMenu() {
    for shoes in shoesData {
        FirebaseReference(.Menu).addDocument(data: shoesDictionaryFrom(shoes: shoes))
    }
}

let shoesData = [
    // NIKE
    Shoes(id: UUID().uuidString, name: "nike 1", imageName: "nike-1", category: Category.nike, description: "Perfect Nike 1.", price: 2.50),
    Shoes(id: UUID().uuidString, name: "nike 2", imageName: "nike-2", category: Category.nike, description: "Perfect Nike 2.", price: 3.50),
    Shoes(id: UUID().uuidString, name: "nike 3", imageName: "nike-3", category: Category.nike, description: "Perfect Nike 3.", price: 2.75),
    // ADIDAS
    Shoes(id: UUID().uuidString, name: "adidas 1", imageName: "adidas-1", category: Category.adidas, description: "Perfect Adidas 1.", price: 2.50),
    Shoes(id: UUID().uuidString, name: "adidas 2", imageName: "adidas-2", category: Category.adidas, description: "Perfect adidas 2.", price: 3.50),
    Shoes(id: UUID().uuidString, name: "adidas 3", imageName: "adidas-3", category: Category.adidas, description: "Perfect adidas 3.", price: 2.75),
    // BITIS
    Shoes(id: UUID().uuidString, name: "bitis 1", imageName: "bitis-1", category: Category.bitis, description: "Perfect bitis 1.", price: 2.50),
    Shoes(id: UUID().uuidString, name: "bitis 2", imageName: "bitis-2", category: Category.bitis, description: "Perfect bitis 2.", price: 3.50),
    Shoes(id: UUID().uuidString, name: "bitis 3", imageName: "bitis-3", category: Category.adidas, description: "Perfect bitis 3.", price: 2.75),
]
