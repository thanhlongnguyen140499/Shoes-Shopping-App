//
//  OrderBasketView.swift
//  ShoesShopApp
//
//  Created by Nguyen Thanh Long on 12/15/20.
//  Copyright © 2020 Nguyen Thanh Long. All rights reserved.
//

import SwiftUI

struct OrderBasketView: View {
    
    @ObservedObject var basketListener = BasketListener()
//    @State private var showingCheckout = false
    
    var body: some View {
        NavigationView {
                    
                    List {
                        Section {
                            ForEach(self.basketListener.orderBasket?.items ?? []) {
                                shoes in
                                
                                HStack {
                                    Text(shoes.name)
                                    Spacer()
                                    Text("$\(shoes.price.clean)")
                                } // End of HStack
                            } // End of ForEach
                                .onDelete { (indexSet) in
                                    print("Delete at \(indexSet)")
                                    self.deleteItems(at: indexSet)
                            }
                        }
                        
                        Section {
//                            Text("Place Order")
                            NavigationLink(destination: CheckoutView()) {
                                 Text("Place Order")
                            }
//                            Button(action: {
//                                self.showingCheckout.toggle()
//                            }, label: {
//                                Text("Place Order")
//                            })
//                                .sheet(isPresented: $showingCheckout) {
//                                    CheckoutView()
//                            }
                            
                        }.disabled(self.basketListener.orderBasket?.items.isEmpty ?? true)
                    } // End of List
                    .navigationBarTitle("Order")
                    .listStyle(GroupedListStyle())
                    
                } // End of Navigation View
    }
    func deleteItems(at offsets: IndexSet) {
        self.basketListener.orderBasket.items.remove(at: offsets.first!)
        self.basketListener.orderBasket.saveBasketToFirestore()
    }
}

struct OrderBasketView_Previews: PreviewProvider {
    static var previews: some View {
        OrderBasketView()
    }
}
