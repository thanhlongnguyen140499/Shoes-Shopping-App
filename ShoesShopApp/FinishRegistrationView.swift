//
//  FinishRegistrationView.swift
//  ShoesShopApp
//
//  Created by Nguyen Thanh Long on 12/16/20.
//  Copyright © 2020 Nguyen Thanh Long. All rights reserved.
//

import SwiftUI

struct FinishRegistrationView: View {
    
    @State var name = ""
    @State var surname = ""
    @State var telephone = ""
    @State var address = ""
    
    var body: some View {
        Form {
            Section() {
                
                Text("Finish Registration")
                    .fontWeight(.heavy)
                    .font(.largeTitle)
                    .padding([.top, .bottom], 20)
                
                TextField("Name", text: $name)
                TextField("Surname", text: $surname)
                TextField("Telephone", text: $telephone)
                TextField("Address", text: $address)
            } // End of Section
            
            Section() {
                Button(action: {
                    self.finishRegistrantion()
                }, label: {
                    Text("Finish Registration")
                })
                
            }.disabled(!self.fieldsCompleted())
            // End of Section
        } // End of form
    } // End of body
    
    private func fieldsCompleted() -> Bool {
        return self.name != "" && self.surname != "" && self.telephone != "" && self.address != ""
    }
    
    private func finishRegistrantion() {
        
    }
    
}

struct FinishRegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        FinishRegistrationView()
    }
}
