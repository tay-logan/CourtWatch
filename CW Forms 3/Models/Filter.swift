//
//  Filter.swift
//  Court Watch
//
//  Created by Taylor Logan, Cian Toole, Tahereh Alamdari,
//  Quang Dang, Nathan Zabloudil, Yamuna Rizal
//  University of Louisville Capstone Project Spring 2023
//

import Foundation
import CloudKit

struct Filter
{
    var showJudge: Bool
    var showDate: Bool
    var judgename: String
    var startdate: Date
    var enddate: Date
    
    init(showJudge: Bool, showDate: Bool, judgename: String, startdate: Date, enddate: Date) {
        self.showJudge = showJudge
        self.showDate = showDate
        self.judgename = judgename
        self.startdate = startdate
        self.enddate = enddate
    }
}
