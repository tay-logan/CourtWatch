//
//  AlertView.swift
//  Court Watch
//
//  Created by Taylor Logan, Cian Toole, Tahereh Alamdari,
//  Quang Dang, Nathan Zabloudil, Yamuna Rizal
//  University of Louisville Capstone Project Spring 2023
//

import SwiftUI
import CloudKit

struct AlertView: View {
    
    @StateObject public var vm: JudgeListViewModel
    
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var isActive: Bool = false
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    let container = CKContainer(identifier: "iCloud.courtWatch")
    
    var body: some View {
        
        NavigationView
        {
            VStack
            {
                Form{
                    Section(){
                        TextField("First Name", text: $firstName).disableAutocorrection(true)
                        TextField("Last Name", text: $lastName).disableAutocorrection(true)
                    }
                    
                    Button(action: {
                        isActive = true
                        vm.save(isactive: 1, judgefirstname: firstName, judgelastname: lastName)
                        self.firstName = ""
                        self.lastName = ""
                        vm.objectWillChange.send()
                        self.presentationMode.wrappedValue.dismiss()
                    })
                    {
                        Text("Save")
                    }.frame(maxWidth: .infinity, alignment: .center).disabled(firstName.isEmpty || lastName.isEmpty)
                    
                }
                
                .alert(isPresented: $isActive)
                {
                    Alert(title: Text("Save Successful."))
                }
                
                
            }
        }.navigationTitle(Text("Add Judge")).navigationViewStyle(StackNavigationViewStyle())
        
    }
}

struct AlertView_Previews: PreviewProvider {
    static var previews: some View {
        let container = CKContainer.default()
        AlertView(vm: JudgeListViewModel(container: container))
    }
}
