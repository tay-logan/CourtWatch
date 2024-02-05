//
//  CourtWatchViewModel.swift
//  CW Forms 3
//
//  Created by Justin Williams, Jacob Langdon, Chuda Dhakal
//  University of Louisville Capstone Project Fall 2022
//
//  Continued by Taylor Logan, Cian Toole, Tahereh Alamdari,
//  Quang Dang, Nathan Zabloudil, Yamuna Rizal
//  University of Louisville Capstone Project Spring 2023
//

import Foundation
import CloudKit



@MainActor class CourtWatchViewModel: ObservableObject
{
    @Published var reports: [RecordViewModel] = []
    
    enum RecordType: String {
        case CourtWatchInfo = "CourtWatchInfo";
        case JudgeInfo = "JudgeInfo";
    }
    private var database: CKDatabase
    private var container: CKContainer
    
    init(container: CKContainer) {
        self.container = container
        // below allows anyone to read, but must be signed into their iCloud account to write (maybe it should be private)
        self.database = self.container.publicCloudDatabase
    }
    
    func saveInfo(firstname: String, lastname: String, email: String, timestamp: Date,gender: String, race: String, disability: String, representation: String, attorneyname: String, charge: String, pretrialriskassessment: String, observationdate: Date, proceedingtype: String, scheduledproceedingtime: Date, judgelastname: String, proceedingoutcome: String, monetarybailamount: String, atmosphere: String, notes: String)
    {
        //gets info from the enum at the top
        let record = CKRecord(recordType: RecordType.CourtWatchInfo.rawValue)
        let Info = Info(firstname: firstname, lastname: lastname, email: email, timestamp: timestamp, gender: gender, race: race, disability: disability, representation: representation, attorneyname: attorneyname, charge: charge, pretrialriskassessment: pretrialriskassessment,  observationdate: observationdate, proceedingtype: proceedingtype, scheduledproceedingtime: scheduledproceedingtime, judgelastname: judgelastname, proceedingoutcome: proceedingoutcome, monetarybailamount: monetarybailamount, atmosphere: atmosphere, notes: notes )
        record.setValuesForKeys(Info.toDictionary())
        
        //saving the record in database
        self.database.save(record) { newRecord, error in
            if let error = error {
                print(error)
            } else {
                if newRecord != nil {
                    print("RECORDS SAVED")
                }
            }
        }
    }
    
    func populateReports()
    {
        var reports: [Info] = []
        
        let query = CKQuery(recordType: CourtWatchViewModel.RecordType.CourtWatchInfo.rawValue, predicate: NSPredicate(value: true))
        
        database.fetch(withQuery: query)
        {
            result in
            switch result
            {
            case .success(let result):
                result.matchResults.compactMap { $0.1 }
                    .forEach
                {
                    switch $0
                    {
                    case .success(let record):
                        if let info = Info.fromRecord(record)
                        {
                            if info.recordId != nil
                            {
                                DispatchQueue.main.async
                                {
                                    print(info)
                                    reports.append(info)
                                }
                            }
                            else
                            {
                                print("nil record id")
                            }
                        }
                    case .failure(let error):
                        print("Error inside: \(error)" )
                    }
                }
                DispatchQueue.main.async {
                    self.reports = reports.map(RecordViewModel.init)
                }
            case .failure(let error):
                print("Error outside: \(error)")
            }
        }
    }
    func populateReportsWithFilter(filter: Filter)
    {
        if filter.showDate && !(filter.showJudge)
        {
            filterDate(filter: filter)
        }
        else if filter.showJudge && !(filter.showDate)
        {
            self.reports = self.reports.filter { $0.judgelastname == filter.judgename }
        }
        else
        {
            filterDate(filter: filter)
            self.reports = self.reports.filter { $0.judgelastname == filter.judgename }
        }
    }
    
    func filterDate(filter: Filter)
    {
        let order = Calendar.current.compare(filter.startdate, to: filter.enddate, toGranularity: .day)
        
        switch order
        {
        case .orderedSame:
            self.reports = self.reports.filter
            {
                Calendar.current.compare($0.observationdate, to: filter.startdate, toGranularity: .day) == .orderedSame
            }
        case .orderedAscending:
            self.reports = self.reports.filter
            {
                Calendar.current.compare($0.observationdate, to: filter.startdate, toGranularity: .day) != .orderedAscending
                &&
                Calendar.current.compare($0.observationdate, to: filter.enddate, toGranularity: .day) != .orderedDescending
            }
        case .orderedDescending:
            print("Error")
        }
    }
}



struct RecordViewModel: Identifiable
{
    let id = UUID()
    let recordlisting: Info
    
    var recordId: CKRecord.ID?
    {
        recordlisting.recordId
    }
    var firstname: String
    {
        recordlisting.firstname
    }
    var lastname: String
    {
        recordlisting.lastname
    }
    var email: String
    {
        recordlisting.email
    }
    var timestamp: Date
    {
        recordlisting.timestamp
    }
    var gender: String
    {
        recordlisting.gender
    }
    var race: String
    {
        recordlisting.race
    }
    var disability: String
    {
        recordlisting.disability
    }
    var representation: String
    {
        recordlisting.representation
    }
    var attorneyname: String
    {
        recordlisting.attorneyname
    }
    var charge: String
    {
        recordlisting.charge
    }
    var pretrialriskassessment: String
    {
        recordlisting.pretrialriskassessment
    }
    var observationdate: Date
    {
        recordlisting.observationdate
    }
    var proceedingtype: String
    {
        recordlisting.proceedingtype
    }
    var scheduledproceedingtime: Date
    {
        recordlisting.scheduledproceedingtime
    }
    var judgelastname: String
    {
        recordlisting.judgelastname
    }
    var proceedingoutcome: String
    {
        recordlisting.proceedingoutcome
    }
    var monetarybailamount: String
    {
        recordlisting.monetarybailamount
    }
    var atmosphere: String
    {
        recordlisting.atmosphere
    }
    var notes: String
    {
        recordlisting.notes
    }
}
