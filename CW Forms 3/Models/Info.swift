//
//  ObserverInfo.swift
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

struct Info: Identifiable
{
    
    var recordId: CKRecord.ID?
    let firstname: String
    let lastname: String
    let email: String
    let timestamp: Date
    let gender: String
    let race: String
    let disability: String
    let representation: String
    let attorneyname: String
    let charge: String
    let pretrialriskassessment: String
    let observationdate: Date
    let proceedingtype: String
    let scheduledproceedingtime: Date
    let judgelastname: String
    let proceedingoutcome: String
    let monetarybailamount: String
    let atmosphere: String
    let notes: String
    let id = UUID()
    
    
    
    init(recordId: CKRecord.ID? = nil, firstname: String, lastname: String, email: String, timestamp: Date,gender: String, race: String, disability: String, representation: String, attorneyname: String, charge: String, pretrialriskassessment: String, observationdate: Date, proceedingtype: String, scheduledproceedingtime: Date, judgelastname: String, proceedingoutcome: String, monetarybailamount: String, atmosphere: String, notes: String)
    {
        self.recordId = CKRecord.ID(recordName: UUID().uuidString)
        self.firstname = firstname
        self.lastname = lastname
        self.email = email
        self.timestamp = timestamp
        self.recordId = recordId
        self.gender = gender
        self.race = race
        self.disability = disability
        self.representation = representation
        self.attorneyname = attorneyname
        self.charge = charge
        self.pretrialriskassessment = pretrialriskassessment
        self.observationdate = observationdate
        self.proceedingtype = proceedingtype
        self.scheduledproceedingtime = scheduledproceedingtime
        self.judgelastname = judgelastname
        self.proceedingoutcome = proceedingoutcome
        self.monetarybailamount = monetarybailamount
        self.atmosphere = atmosphere
        self.notes = notes
    }
    
    //used in the CourtWatchViewModel
    func toDictionary() -> [String: Any] {
        return ["firstname": firstname, "lastname": lastname, "email": email, "timestamp": timestamp, "gender": gender, "race": race, "disability": disability, "representation": representation, "attorneyname": attorneyname, "charge": charge, "pretrialriskassessment": pretrialriskassessment, "observationdate": observationdate, "proceedingtype": proceedingtype, "scheduledproceedingtime": scheduledproceedingtime, "judgelastname": judgelastname, "proceedingoutcome": proceedingoutcome, "monetarybailamount": monetarybailamount, "atmosphere": atmosphere, "notes": notes ]
    }
    
    static func fromRecord(_ record: CKRecord) -> Info?
    {
        var firstname: String
        var lastname: String
        var email: String
        var timestamp: Date
        var gender: String
        var race: String
        var disability: String
        var representation: String
        var attorneyname: String
        var charge: String
        var pretrialriskassessment: String
        var observationdate: Date
        var proceedingtype: String
        var scheduledproceedingtime: Date
        var judgelastname: String
        var proceedingoutcome: String
        var monetarybailamount: String
        var atmosphere: String
        var notes: String
        
        
        if let _fn = record.value(forKey: "firstname") as? String
        {
            firstname = _fn
        }
        else
        {
            firstname = ""
        }
        
        
        if let _ln = record.value(forKey: "lastname") as? String
        {
            lastname = _ln
        }
        else
        {
            lastname = ""
        }
        
        
        if let _email = record.value(forKey: "email") as? String
        {
            email = _email
        }
        else
        {
            email = ""
        }
        
        
        if let _ts = record.value(forKey: "timestamp") as? Date
        {
            timestamp = _ts
        }
        else
        {
            timestamp = Date()
        }
        
        
        if let _gender = record.value(forKey: "gender") as? String
        {
            gender = _gender
        }
        else
        {
            gender = ""
        }
        
        
        if let _race = record.value(forKey: "race") as? String
        {
            race = _race
        }
        else
        {
            race = ""
        }
        
        
        if let _disability = record.value(forKey: "disability") as? String
        {
            disability = _disability
        }
        else
        {
            disability = ""
        }
        
        
        if let _rep = record.value(forKey: "representation") as? String
        {
            representation = _rep
        }
        else
        {
            representation = ""
        }
        
        
        if let _attorneyname = record.value(forKey: "attorneyname") as? String
        {
            attorneyname = _attorneyname
        }
        else
        {
            attorneyname = ""
        }
        
        
        if let _charge = record.value(forKey: "charge") as? String
        {
            charge = _charge
        }
        else
        {
            charge = ""
        }
        
        
        if let _pretrialriskassessment = record.value(forKey: "pretrialriskassessment") as? String
        {
            pretrialriskassessment = _pretrialriskassessment
        }
        else
        {
            pretrialriskassessment = ""
        }
        
        
        if let _observationdate = record.value(forKey: "observationdate") as? Date
        {
            observationdate = _observationdate
        }
        else
        {
            observationdate = Date()
        }
        
        
        if let _proceedingtype = record.value(forKey: "proceedingtype") as? String
        {
            proceedingtype = _proceedingtype
        }
        else
        {
            proceedingtype = ""
        }
        
        
        if let _spt = record.value(forKey: "scheduledproceedingtime") as? Date
        {
            scheduledproceedingtime = _spt
        }
        else
        {
            scheduledproceedingtime = Date()
        }
        
        
        if let _judgelastname = record.value(forKey: "judgelastname") as? String
        {
            judgelastname = _judgelastname
        }
        else
        {
            judgelastname = ""
        }
        
        
        if let _proceedingoutcome = record.value(forKey: "proceedingoutcome") as? String
        {
            proceedingoutcome = _proceedingoutcome
        }
        else
        {
            proceedingoutcome = ""
        }
        
        
        if let _mba = record.value(forKey: "monetarybailamount") as? String
        {
            monetarybailamount = _mba
        }
        else
        {
            monetarybailamount = ""
        }
        
        
        if let _atmo = record.value(forKey: "atmosphere") as? String
        {
            atmosphere = _atmo
        }
        else
        {
            atmosphere = ""
        }
        
        if let _notes = record.value(forKey: "notes") as? String
        {
            notes = _notes
        }
        else
        {
            notes = ""
        }
        
        let result = Info(recordId: record.recordID, firstname: firstname, lastname: lastname, email: email, timestamp: timestamp, gender: gender, race: race, disability: disability, representation: representation, attorneyname: attorneyname, charge: charge, pretrialriskassessment: pretrialriskassessment, observationdate: observationdate, proceedingtype: proceedingtype, scheduledproceedingtime: scheduledproceedingtime, judgelastname: judgelastname, proceedingoutcome: proceedingoutcome, monetarybailamount: monetarybailamount, atmosphere: atmosphere, notes: notes)
        
        firstname = ""
        lastname = ""
        email = ""
        timestamp = Date(timeIntervalSince1970: 0)
        gender = ""
        race = ""
        disability = ""
        representation = ""
        attorneyname = ""
        charge = ""
        pretrialriskassessment = ""
        observationdate = Date(timeIntervalSince1970: 0)
        proceedingtype = ""
        scheduledproceedingtime = Date(timeIntervalSince1970: 0)
        judgelastname = ""
        proceedingoutcome = ""
        monetarybailamount = ""
        atmosphere = ""
        notes = ""
        
        
        return result
    }
    
    static func fromRecordViewModel(_ record: RecordViewModel) -> Info
    {
        return Info(recordId: record.recordId, firstname: record.firstname, lastname: record.lastname, email: record.email, timestamp: record.timestamp, gender: record.gender, race: record.race, disability: record.disability, representation: record.representation, attorneyname: record.attorneyname, charge: record.charge, pretrialriskassessment: record.pretrialriskassessment, observationdate: record.observationdate, proceedingtype: record.proceedingtype, scheduledproceedingtime: record.scheduledproceedingtime, judgelastname: record.judgelastname, proceedingoutcome: record.proceedingoutcome, monetarybailamount: record.monetarybailamount, atmosphere: record.atmosphere, notes: record.notes)
    }
}

extension Info
{
    var obersvationDateString: String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter.string(from: observationdate)
    }
}
