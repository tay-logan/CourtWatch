//
//  ManageView.swift
//  Court Watch
//
//  Created by Taylor Logan, Cian Toole, Tahereh Alamdari,
//  Quang Dang, Nathan Zabloudil, Yamuna Rizal
//  University of Louisville Capstone Project Spring 2023
//

import SwiftUI
import CloudKit

struct ManageView: View
{
    @StateObject private var vm: JudgeListViewModel
    
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    let container = CKContainer(identifier: "iCloud.courtWatch")

    init(vm: JudgeListViewModel)
    {
        _vm = StateObject(wrappedValue: vm)
    }
    
    @MainActor func deleteJudge(_ indexSet: IndexSet)
    {
        DispatchQueue.main.async {
            indexSet.forEach { index in
                let judge = vm.judges[index]
                print(judge)
                if let recordId = judge.recordId {
                    vm.deleteJudge(recordId: recordId)
                }
            }
        }
    }
    
    var body: some View
    {

        NavigationView
        {
            VStack
            {
                List
                {
                    
                    Section {
                        
                        ForEach(vm.judges, id: \.recordId)
                        {
                            judge in
                            HStack
                            {
                                Text(judge.judgefirstname + " " + judge.judgelastname)
                            }
                        }
// TODO: Fix deletion. Currently, permission to the database are not allowing for deletion or editing of records.
//
//                        .onDelete(perform: deleteJudge)
                        
                    }
                }.refreshable {
                    vm.populateJudges()
                }
                
            }.onAppear
            {
                vm.populateJudges()
            }
            
        }.navigationTitle(Text("Judges")).navigationViewStyle(StackNavigationViewStyle())
            .toolbar {
            ToolbarItemGroup {
                
                    NavigationLink(destination: AlertView(vm: JudgeListViewModel(container: container)))
                    {
                        HStack {
                            Image(systemName: "plus").resizable().frame(width: 20, height: 20)
                        }
                    }
                
                    Button() {
                        vm.populateJudges()
                    } label: {
                        Image(systemName: "arrow.clockwise").resizable().frame(width: 20, height: 20)
                    }.frame(alignment: .trailing)
            }
            
        }
            
    };

    
}

struct ManageView_Previews: PreviewProvider
{
    static var previews: some View
    {
        let container = CKContainer.default()
        ManageView(vm: JudgeListViewModel(container: container))
    }
}
