//
//  JudgeList.swift
//  Court Watch
//
//  Created by Taylor Logan, Cian Toole, Tahereh Alamdari,
//  Quang Dang, Nathan Zabloudil, Yamuna Rizal
//  University of Louisville Capstone Project Spring 2023
//

import Foundation
import CloudKit

struct JudgeListing
{
    var recordId: CKRecord.ID?
    let isactive: Int64
    let judgefirstname: String
    let judgelastname: String
    let id: UUID
    
    init(recordId: CKRecord.ID? = nil, isactive: Int64, judgefirstname: String, judgelastname: String)
    {
        self.isactive = isactive
        self.judgefirstname = judgefirstname
        self.judgelastname = judgelastname
        self.recordId = CKRecord.ID(recordName: UUID().uuidString)
        self.id = UUID()
    }
    
    func toDictionary() -> [String:Any]
    {
        return ["isactive": isactive, "judgefirstname": judgefirstname, "judgelastname": judgelastname]
    }
    static func fromRecord(_ record: CKRecord) -> JudgeListing?
    {
        guard let isactive = record.value(forKey: "isactive") as? Int64 , let judgefirstname = record.value(forKey: "judgefirstname") as? String, let judgelastname = record.value(forKey: "judgelastname") as? String
                else
                {
                    return nil
                }
        
        return JudgeListing(isactive: isactive, judgefirstname: judgefirstname, judgelastname: judgelastname)
    }
}
