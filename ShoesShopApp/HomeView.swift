//
//  ContentView.swift
//  ShoesShopApp
//
//  Created by Nguyen Thanh Long on 12/14/20.
//  Copyright © 2020 Nguyen Thanh Long. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var shoesListener = ShoesListener()
    @State private var showingBasket = false
    
    var categories: [String : [Shoes]] {
          .init(
            grouping: shoesListener.shoeses,
              by: {$0.category.rawValue}
          )
      }
    
    var body: some View {
        
        NavigationView {
            
            List(categories.keys.sorted(), id: \String.self) {
                key in
                ShoesRow(categoryName: "\(key) Shoes".uppercased(), shoeses: self.categories[key]!)
                    .frame(height: 320)
                    .padding(.top)
                    .padding(.bottom)
            }
            
            .navigationBarTitle(Text("iShoes"))
            .navigationBarItems(leading:
                Button(action: {
                    //code
                    print("log out")
//                    createMenu()
                }, label: {
                    Text("Log Out")
                }),
                                
                trailing:
                
                Section{
                    if FUser.currentUser() != nil && FUser.currentUser()!.onBoarding {
                        NavigationLink(destination: OrderBasketView()) {
                            Image("basket")
                        }
                    } else if FUser.currentUser() != nil {
                        NavigationLink(destination: FinishRegistrationView()) {
                            Image("basket")
                        }
                    }else {
                        NavigationLink(destination: LoginView()) {
                            Image("basket")
                        }
                    }
                }
                // check login chua de mo basket
//                .sheet(isPresented: $showingBasket) {
//
//                        if FUser.currentUser() != nil && FUser.currentUser()!.onBoarding {
//
//                            OrderBasketView()
//                        } else if FUser.currentUser() != nil {
//
//                            FinishRegistrationView()
//                        } else {
//                            LoginView()
//                        }
//
//                }
                
//                Button(action: {
//                    //code
//                    self.showingBasket.toggle()
//                    print("basket")
//                }, label: {
//                    Image("basket")
//                })

            )
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
