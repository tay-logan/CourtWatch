//
//  ReportViewModel.swift
//  Court Watch
//
//  Created by Taylor Logan, Cian Toole, Tahereh Alamdari,
//  Quang Dang, Nathan Zabloudil, Yamuna Rizal
//  University of Louisville Capstone Project Spring 2023
//

import Foundation
import CloudKit

class ReportViewModel: ObservableObject
{
    private var _report: Info
    
    init(report: Info)
    {
        _report = report
    }
    
    func getReport() -> Info
    {
        return _report
    }
}
