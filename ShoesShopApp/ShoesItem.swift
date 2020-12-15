//
//  ShoesItem.swift
//  ShoesShopApp
//
//  Created by Nguyen Thanh Long on 12/14/20.
//  Copyright © 2020 Nguyen Thanh Long. All rights reserved.
//

import SwiftUI

struct ShoesItem: View {
    var shoes : Shoes
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 16) {
            Image(shoes.imageName)
                .resizable()
                .renderingMode(.original)
                .aspectRatio(contentMode: .fill)
                .frame(width: 300, height: 170)
                .cornerRadius(10)
                .shadow(radius: 10)
            
            VStack(alignment: .leading, spacing: 5) {
                
                Text(shoes.name)
                    .foregroundColor(.primary)
                    .font(.headline)
                
                Text(shoes.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                    .frame(height: 40)
            }
        }
    }
}

struct ShoesItem_Previews: PreviewProvider {
    static var previews: some View {
        ShoesItem(shoes: shoesData[0])
    }
}
