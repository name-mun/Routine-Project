//
//  DateID.swift
//  Routine
//
//  Created by t2023-m0072 on 12/29/24.
//

import Foundation

/// DateID
///
/// year, month, day 를 사용한 식별자
///
struct DateID: Codable, Equatable, Comparable, CustomStringConvertible {
    
    let year: Int
    let month: Int
    let day: Int
    
    init(_ date: Date) {
        let calendar = Calendar.current
        self.year = calendar.component(.year, from: date)
        self.month = calendar.component(.month, from: date)
        self.day = calendar.component(.day, from: date)
    }
    
    var description: String {
        "\(year)년 \(month)월 \(day)일"
    }
        
    // 통계뷰를 위한 식별 메서드
    func equalMonth(_ dateID: DateID) -> Bool {
        year == dateID.year && month == dateID.month
    }
    
    // DateID 를 Date 로 변환
    func date() -> Date? {
        let component = DateComponents(year: self.year, month: self.month, day: self.day)
        return Calendar.current.date(from: component)
    }
    
    static func < (lhs: DateID, rhs: DateID) -> Bool {
        compareForm(lhs) < compareForm(rhs)
    }
    
    // 비교를 위한 형태
    private static func compareForm(_ dateID: DateID) -> Int {
        let year = "\(dateID.year)"
        let month = dateID.month < 10 ? "0\(dateID.month)" : "\(dateID.month)"
        let day = dateID.day < 10 ? "0\(dateID.day)" : "\(dateID.day)"
        
        return Int(year + month + day) ?? 0
    }
}
