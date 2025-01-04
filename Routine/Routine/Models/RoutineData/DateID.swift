//
//  DateID.swift
//  Routine
//
//  Created by t2023-m0072 on 12/29/24.
//

import Foundation

/// DateID
struct DateID: Codable, Equatable, Comparable {
    
    let year: Int
    let month: Int
    let day: Int
    
    init(_ date: Date) {
        let calendar = Calendar.current
        self.year = calendar.component(.year, from: date)
        self.month = calendar.component(.month, from: date)
        self.day = calendar.component(.day, from: date)
    }
        
    func equalMonth(_ dateID: DateID) -> Bool {
        year == dateID.year && month == dateID.month
    }
    
    func date() -> Date? {
        let component = DateComponents(year: self.year, month: self.month, day: self.day)
        return Calendar.current.date(from: component)
    }
    
    static func < (lhs: DateID, rhs: DateID) -> Bool {
        compareForm(lhs) < compareForm(rhs)
    }
    
    private static func compareForm(_ dateID: DateID) -> Int {
        let year = "\(dateID.year)"
        let month = dateID.month < 10 ? "0\(dateID.month)" : "\(dateID.month)"
        let day = dateID.day < 10 ? "0\(dateID.day)" : "\(dateID.day)"
        
        return Int(year + month + day) ?? 0
    }
}
