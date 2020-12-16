//
//  ShoesDetail.swift
//  ShoesShopApp
//
//  Created by Nguyen Thanh Long on 12/15/20.
//  Copyright © 2020 Nguyen Thanh Long. All rights reserved.
//

import SwiftUI

struct ShoesDetail: View {
    
    @State private var showingAlert = false
    @State private var showingLogin = false
    
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
//                OrderButton(shoes: self.shoes)
                
//                Button(action: {
//                    self.showingAlert.toggle()
//                }, label: {
//                    Text("Add to basket")
//                })
                OrderButton(showAlert: $showingAlert, showLogin: $showingLogin, shoes: shoes)
                
                Spacer()
            }
            .padding(.top, 50)
        } // End of Scroll View
        .edgesIgnoringSafeArea(.top)
        .navigationBarHidden(true)
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Added to Basket"), dismissButton: .default(Text("OK")))
        }
    }
}

struct ShoesDetail_Previews: PreviewProvider {
    static var previews: some View {
        ShoesDetail(shoes: shoesData.first!)
    }
}

struct OrderButton : View {
    
    @ObservedObject var basketListener = BasketListener()
    
    @Binding var showAlert: Bool
    @Binding var showLogin: Bool
    
    var shoes: Shoes
    
    var body : some View {
        
        Button(action: {
            if FUser.currentUser() != nil && FUser.currentUser()!.onBoarding {
                self.showAlert.toggle()
                self.addItemToBasket()
            } else {
                self.showLogin.toggle()
            }
            
        }) {
            Text("Add to basket")
        }
        .frame(width: 200, height: 50)
        .foregroundColor(.white)
        .font(.headline)
        .background(Color.blue)
        .cornerRadius(10)
        .sheet(isPresented: self.$showLogin) {
            if FUser.currentUser() != nil {
                FinishRegistrationView()
            } else {
                LoginView()
            }
        }

    }
    
    private func addItemToBasket() {
        var orderBasket: OrderBasket!
        
        
        if self.basketListener.orderBasket != nil {
            orderBasket = self.basketListener.orderBasket
        } else {
            orderBasket = OrderBasket()
            orderBasket.ownerId = FUser.currentId()
            orderBasket.id = UUID().uuidString
        }
        
        orderBasket.add(self.shoes)
        orderBasket.saveBasketToFirestore()
    }
}
