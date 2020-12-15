//
//  ShoesRow.swift
//  ShoesShopApp
//
//  Created by Nguyen Thanh Long on 12/14/20.
//  Copyright © 2020 Nguyen Thanh Long. All rights reserved.
//

import SwiftUI

struct ShoesRow: View {
    
    var categoryName: String
    var shoeses: [Shoes]
    
    var body: some View {
        
        NavigationView {
            VStack(alignment: .leading) {
                
                Text(self.categoryName)
                    .font(.title)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    
                    HStack {
                        ForEach(self.shoeses) { shoes in
                            
                            NavigationLink(destination: ShoesDetail(shoes: shoes)) {
                                ShoesItem(shoes: shoes)
                                        .frame(width: 300)
                                        .padding(.trailing, 30)
                            }
                            
                            
                        }
                    }
                }
            }
        }
    }
}

struct ShoesRow_Previews: PreviewProvider {
    static var previews: some View {
        ShoesRow(categoryName: "Adidas", shoeses: shoesData)
    }
}
