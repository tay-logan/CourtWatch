//
//  ReportView.swift
//  Court Watch
//
//  Created by Taylor Logan, Cian Toole, Tahereh Alamdari,
//  Quang Dang, Nathan Zabloudil, Yamuna Rizal
//  University of Louisville Capstone Project Spring 2023
//
// This is what allows you to view a single report after pressing one from the ReportsView

import Foundation
import CloudKit
import SwiftUI

struct ReportView: View
{
    
    var report: Info
    
    let dateFormatter = DateFormatter()
    let timeFormatter = DateFormatter()

    
    init(report: Info)
    {
        self.report = report
        dateFormatter.dateFormat = "MM/dd/yyyy"
        timeFormatter.dateFormat = "h:mm a"
    }
    
    var body: some View
    {

        VStack
        {
            Form
            {
                Section(header: Text("Observer Info"))
                {
                    HStack
                    {
                        Text("First Name*")
                        Spacer()
                        Text(report.firstname)
                    }
                    HStack
                    {
                        Text("Last Name*")
                        Spacer()
                        Text(report.lastname)
                    }
                    HStack
                    {
                        Text("Email*")
                        Spacer()
                        Text(report.email)
                    }
                    HStack
                    {
                        Text("Timestamp")
                        Spacer()
                        Text(dateFormatter.string(from:report.timestamp))
                    }
                }
                // Defendant Info section
                Section(header: Text("Defendant Info"))
                {
                    HStack
                    {
                        Text("Gender")
                        Spacer()
                        Text(report.gender)
                    }
                    HStack
                    {
                        Text("Race")
                        Spacer()
                        Text(report.race)
                    }
                    HStack
                    {
                        Text("Obvious Disability?")
                        Spacer()
                        Text(report.disability)
                    }
                    let attnpresent = (report.attorneyname).isEmpty
                    HStack
                    {
                        Text("Attorney Present?")
                        Spacer()
                        if (!attnpresent)
                        {
                            Text("Yes")
                        }
                        else
                        {
                            Text("No")
                        }
                    }
                    if (!attnpresent)
                    {
                        HStack
                        {
                            Text("Attorney Name")
                            Spacer()
                            Text(report.attorneyname)
                        }
                    }
                    HStack
                    {
                        Text("Charges*")
                        Spacer()
                        Text(report.charge)
                    }
                    HStack
                    {
                        Text("Pre-trial Risk Assessment?")
                        Spacer()
                        Text(report.pretrialriskassessment)
                    }
                }
                
                Section(header: Text("Proceeding Info"))
                {
                    HStack
                    {
                        Text("Observation Date")
                        Spacer()
                        Text(dateFormatter.string(from:report.observationdate))
                    }
                    HStack
                    {
                        Text("Proceeding Type")
                        Spacer()
                        Text(report.proceedingtype)
                    }
                    HStack
                    {
                        Text("Scheduled Proceeding Time")
                        Spacer()
                        Text(timeFormatter.string(from:report.scheduledproceedingtime))
                    }
                    HStack
                    {
                        Text("Judge's Last Name*")
                        Spacer()
                        Text(report.judgelastname)
                    }
                    HStack
                    {
                        Text("Proceeding Outcome*")
                        Spacer()
                        Text(report.proceedingoutcome)
                    }
                    HStack
                    {
                        Text("Monetary Bail Amount")
                        Spacer()
                        Text(report.monetarybailamount)
                    }
                    HStack
                    {
                        Text("Court Room Atmosphere")
                        Spacer()
                        Text(report.atmosphere)
                    }
                }
                Section(header: Text("Additional Notes"), footer: Text("* indicates required field."))
                {
                    HStack
                    {
                        Text(report.notes)
                    }
                }
            }
        }
    }
}


struct ReportView_Previews: PreviewProvider {
    static var previews: some View {
        let report = Info.init(firstname: "", lastname: "", email: "", timestamp: Date(), gender: "", race: "", disability: "", representation: "", attorneyname: "", charge: "", pretrialriskassessment: "", observationdate: Date(), proceedingtype: "", scheduledproceedingtime: Date(), judgelastname: "", proceedingoutcome: "", monetarybailamount: "", atmosphere: "", notes: "")
        ReportView(report: report)
    }
}
