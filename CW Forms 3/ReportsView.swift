//
//  ReportsView.swift
//  Court Watch
//
//  Created by Taylor Logan, Cian Toole, Tahereh Alamdari,
//  Quang Dang, Nathan Zabloudil, Yamuna Rizal
//  University of Louisville Capstone Project Spring 2023
//

import SwiftUI
import CloudKit

struct ReportsView: View {
    
    @StateObject private var vm: CourtWatchViewModel
    @StateObject private var jvm: JudgeListViewModel
    @State private var filterShowing: Bool = false
    @State private var showJudge: Bool = false
    @State private var showDate: Bool = false
    @State private var filterToAdd: Int = 2
    @State private var judgeName: String = ""
    @State private var startdate = Date()
    @State private var enddate = Date()
    let persistenceController = PersistenceController.shared
    let container = CKContainer(identifier: "iCloud.courtWatch")
    let dateFormatter = DateFormatter()
    
    init(vm: CourtWatchViewModel, jvm: JudgeListViewModel) {
        _vm = StateObject(wrappedValue: vm)
        _jvm = StateObject(wrappedValue: jvm)
        dateFormatter.dateFormat = "MM/dd/YYYY"

    }
    
    
    
    var body: some View {
        
        
        NavigationView
        {
            VStack
            {
                
                List
                {
                    if (filterShowing)
                    {
                        
                        Section(header: Text("Filtering"))
                        {
                            Picker("Choose Filters", selection: $filterToAdd)
                            {
                                Text("Select Filter").tag(2)
                                Text("Judge").tag(1)
                                Text("Date").tag(0)
                            }
                            .pickerStyle(.menu)
                        }
                        
                        Section()
                        {
                            HStack(spacing: 10)
                            {
                                Button("Add")
                                {
                                    if (filterToAdd == 1)
                                    {
                                        showJudge = true
                                    }
                                    if (filterToAdd == 0)
                                    {
                                        showDate = true
                                    }
                                    
                                }.frame(alignment: .trailing)
                                    .buttonStyle(.borderedProminent)
                            }.frame(minWidth: 2000, alignment: .trailing)
                        }.listRowBackground(Color.clear).frame(minWidth: 400, alignment: .trailing)
                            
                        if (showJudge || showDate)
                        {
                            Section(header: Text("Apply Filters"))
                            {
                                
                                if (showJudge)
                                {
                                    Picker("Presiding Judge", selection: $judgeName)
                                    {
                                        Text("Select Judge").tag("")
                                        ForEach(jvm.judges, id: \.recordId)
                                        {
                                            judge in
                                            Text(judge.judgefirstname + " " + judge.judgelastname).tag(judge.judgelastname)
                                        }
                                    }
                                    .onAppear()
                                    {
                                        jvm.populateJudges()
                                    }
                                    .onChange(of: judgeName, perform:
                                                {
                                        newValue in
                                        print(newValue as String)
                                        vm.populateReports()
                                        
                                    })
                                    .pickerStyle(.menu)
                                }
                                if (showDate) {
                                    
                                    DatePicker("Start Date",
                                               selection: $startdate,
                                               displayedComponents: [.date])
                                    .onChange(of: startdate, perform:
                                                {
                                        newValue in
                                        print(newValue)
                                        vm.populateReports()
                                        
                                    })
                                    
                                    DatePicker("End Date",
                                               selection: $enddate,
                                               displayedComponents: [.date])
                                    .onChange(of: enddate, perform:
                                                {
                                        newValue in
                                        print(newValue)
                                        vm.populateReports()
                                        
                                    })
                                }
                            }
                        }
                        if (showJudge || showDate)
                        {
                            Section
                            {
                                HStack(spacing: 10)
                                {
                                    Button("Clear Filters")
                                    {
                                        judgeName = ""
                                        startdate = Date()
                                        enddate = Date()
                                        showJudge = false
                                        showDate = false
                                        vm.populateReports()
                                    }.frame(alignment: .trailing)
                                    .buttonStyle(.bordered)
                                    
                                    
                                    Button("Apply Filters")
                                    {
                                        // Populate with Filters
                                        vm.populateReportsWithFilter(filter: Filter(showJudge: showJudge, showDate: showDate, judgename: judgeName, startdate: startdate, enddate: enddate))
                                    }
                                    .frame(alignment: .trailing)
                                    .disabled(startdate > enddate)
                                    .buttonStyle(.borderedProminent)
                                }.frame(minWidth: 2000, alignment: .trailing)
                            }.listRowBackground(Color.clear).frame(minWidth: 400, alignment: .trailing)
                        }
                    }
                    ReportListView(vm: vm)
                }
                .refreshable {
                    vm.populateReports()
                }
                .onAppear
                {
                    vm.populateReports()
                }
            }
            
        }.navigationTitle(Text("Reports")).navigationViewStyle(StackNavigationViewStyle())
            .toolbar {
                ToolbarItemGroup {
                    Button() {
                        filterShowing = !filterShowing
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease.circle").resizable().frame(width: 20, height: 20)
                    }.frame(alignment: .trailing)
                }
            }
    }
}

struct ReportsView_Previews: PreviewProvider {
    static var previews: some View
    {
        let container = CKContainer.default()
        ReportsView(vm: CourtWatchViewModel(container: container), jvm: JudgeListViewModel(container: container))
    }
}
