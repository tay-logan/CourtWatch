//
//  JudgeListViewModel.swift
//  Court Watch
//
//  Created by Taylor Logan, Cian Toole, Tahereh Alamdari,
//  Quang Dang, Nathan Zabloudil, Yamuna Rizal
//  University of Louisville Capstone Project Spring 2023
//

import Foundation
import CloudKit


@MainActor class JudgeListViewModel: ObservableObject
{
    enum CloudKitErrors: Error
    {
        case castFailure
    }
    
    private var database: CKDatabase
    private var container: CKContainer
    
    @Published var judges: [JudgeViewModel] = []
    
    init(container: CKContainer)
    {
        self.container = container
        self.database = self.container.publicCloudDatabase
    }
        
    
    func save(isactive: Int64, judgefirstname: String, judgelastname: String)
    {
        let record = CKRecord(recordType: CourtWatchViewModel.RecordType.JudgeInfo.rawValue)
        let judgeListing = JudgeListing(isactive: isactive, judgefirstname: judgefirstname, judgelastname: judgelastname)
        record.setValuesForKeys(judgeListing.toDictionary())
        self.database.save(record)
        {
            newRecord, error in
            if let error = error
            {
                print(error)
            }
            else
            {
                if let newRecord = newRecord
                {
                    if let judgeListing = JudgeListing.fromRecord(newRecord)
                    {
                        DispatchQueue.main.async {
                            self.judges.append(JudgeViewModel(judgeListing: judgeListing))
                            
                        }
                    }
                }
            }
        }
    }
    
    func populateJudges()
    {
        var judges: [JudgeListing] = []
        
        let query = CKQuery(recordType: CourtWatchViewModel.RecordType.JudgeInfo.rawValue, predicate: NSPredicate(value: true))
        
        database.fetch(withQuery: query)
        { result in
            switch result
            {
            case .success(let result):
                result.matchResults.compactMap { $0.1 }
                    .forEach
                    {
                        switch $0
                        {
                            case .success(let record):
                                if let judgeListing = JudgeListing.fromRecord(record)
                                {
                                    DispatchQueue.main.async
                                    {
                                        judges.append(judgeListing)
                                    }
                                }
                            case .failure(let error):
                                print(error)
                        }
                    }
                DispatchQueue.main.async
                {
                    self.judges = judges.map(JudgeViewModel.init)
                    self.judges = self.judges.filter { $0.isactive > 0 }
//                    print(self.judges)
                }
                
                
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
    func deleteJudge(recordId: CKRecord.ID) -> ()
    {
//        let operation = CKModifyRecordsOperation(recordsToSave: nil, recordIDsToDelete: [recordId])
//
//        operation.savePolicy = .allKeys
//        operation.modifyRecordsResultBlock = { result in
//            switch (result)
//            {
//            case .success(let res):
//                print(res)
//            case.failure(let err):
//                print(err)
//            }
//        }
//        database.add(operation)
        
        let query = CKQuery(recordType: CourtWatchViewModel.RecordType.JudgeInfo.rawValue, predicate: NSPredicate(value: true))
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
                                if(record.recordID == recordId)
                                {
                                    record.setValue(0, forKey: "isactive")
                                    let database = CKContainer.default().publicCloudDatabase
                                    DispatchQueue.main.async {
                                        database.save(record)
                                        {
                                            result, error in
                                            if error != nil
                                            {
                                                print(error?.localizedDescription as Any)
                                            }
                                            else
                                            {
                                                print(result.debugDescription)
                                            }
                                        }
                                    }
                                }
                                case .failure(let error):
                                    print(error)
                            }
                        }
                    
                    
                    
                    
                    
                case .failure(let error):
                    print(error)
                }
            
            
        }
        
    }
    
}

struct JudgeViewModel {
    
    let judgeListing: JudgeListing
    
    var recordId: CKRecord.ID? {
        judgeListing.recordId
    }
    
    var judgefirstname: String {
        judgeListing.judgefirstname
    }
    
    var judgelastname: String {
        judgeListing.judgelastname
    }
    var isactive: Int64
    {
        judgeListing.isactive
    }
}


extension CKRecord: @unchecked Sendable
{
    
}
