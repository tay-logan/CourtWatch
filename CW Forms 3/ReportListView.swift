//
//  ReportListView.swift
//  Court Watch
//
//  Created by Taylor Logan, Cian Toole, Tahereh Alamdari,
//  Quang Dang, Nathan Zabloudil, Yamuna Rizal
//  University of Louisville Capstone Project Spring 2023
//

import Foundation
import SwiftUI



struct ReportListView: View
{
    @StateObject private var vm: CourtWatchViewModel
    let dateFormatter = DateFormatter()

    
    init(vm: CourtWatchViewModel)
    {
        _vm = StateObject(wrappedValue: vm)
        dateFormatter.dateFormat = "MM/dd/yyyy"
    }
    
    @ViewBuilder var header: some View {
        HStack
        {
            Text("Presiding Judge")
            Spacer()
            Text("Outcome")
            Spacer()
            Text("Observation Date")
        }
    }
    
    var body: some View
    {
            Section(header: header)
            {
                ForEach(vm.reports, id: \.recordId)
                {
                    report in
                    NavigationStack {
                        
                        NavigationLink(destination: ReportView(report: Info.fromRecordViewModel(report)))
                        {
                            HStack
                            {
                                Text(report.judgelastname).frame(width: 150, alignment: .leading)
                                Spacer()
                                Text(report.proceedingoutcome).frame(width: 100, alignment: .leading)
                                Spacer()
                                Text(dateFormatter.string(from: report.observationdate)).frame(width: 100)
                            }
                        }
                        
                    }
                }
            }
    }
}
