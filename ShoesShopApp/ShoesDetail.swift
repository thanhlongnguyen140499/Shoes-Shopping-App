//
//  ShoesDetail.swift
//  ShoesShopApp
//
//  Created by Nguyen Thanh Long on 12/15/20.
//  Copyright © 2020 Nguyen Thanh Long. All rights reserved.
//

import SwiftUI

struct ShoesDetail: View {
    
    var shoes: Shoes
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            
            ZStack(alignment: .bottom) {
                
                Image(shoes.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                Rectangle()
                    .frame(height: 80)
                    .foregroundColor(.black)
                    .opacity(0.35)
                    .blur(radius: 10)
                
                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(shoes.name)
                            .foregroundColor(.white)
                            .font(.largeTitle)
                    }
                    .padding(.leading)
                    .padding(.bottom)
                    
                    Spacer()
                } // End of HStack
                
            } // End of ZStack
            .listRowInsets(EdgeInsets())
            
            Text(shoes.description)
                .foregroundColor(.primary)
                .font(.body)
                .lineLimit(5)
                .padding()
            HStack {
                Spacer()
                // Button
                OrderButton(shoes: self.shoes)
                Spacer()
            }
            .padding(.top, 50)
        } // End of Scroll View
        .edgesIgnoringSafeArea(.top)
        .navigationBarHidden(true)
    }
}

struct ShoesDetail_Previews: PreviewProvider {
    static var previews: some View {
        ShoesDetail(shoes: shoesData.first!)
    }
}

struct OrderButton : View {
    
//    @Binding var showAlert: Bool
    
    var shoes: Shoes
    
    var body : some View {
        
        Button(action: {
//            self.showAlert.toggle()
            print("Add to basket, \(self.shoes.name)")
            
        }) {
            Text("Add to basket")
        }
        .frame(width: 200, height: 50)
        .foregroundColor(.white)
        .font(.headline)
        .background(Color.blue)
        .cornerRadius(10)
    }
    
}
