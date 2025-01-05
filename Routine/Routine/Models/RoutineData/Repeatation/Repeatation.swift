//
//  Repeatation.swift
//  Routine
//
//  Created by t2023-m0072 on 12/2/24.
//

import Foundation

///반복 주기 열거형
///
///weeklyDay(Set_WeeklyDay) - 주간 반복
///
///monthlyDay(Set_Int) - 월간 반복
///
///default - 주간 전체
///
enum Repeatation: Codable, CustomStringConvertible {
    
    static let `default` = weeklyDay(Set<WeeklyDay>(WeeklyDay.allCases))
    
    case weeklyDay(Set<WeeklyDay>)
    case monthlyDay(Set<Int>)
    
    ///print, String(describing:) 에서 사용될 형태 - 데이터 확인용
    var description: String {
        switch self {
        case .monthlyDay(let monthlyDay):
            return "월간 \(monthlyDay.sorted(by: <))"
        case .weeklyDay(let weeklyDay):
            return "주간 \(weeklyDay.sorted(by: <))"
        }
    }
    
    ///날짜 포함 여부 확인 메서드
    ///
    func contains(_ date: Date) -> Bool {
        switch self {
        case .monthlyDay(let monthlyDays):
            let monthlyDay = Calendar.current.component(.day, from: date)
            return monthlyDays.contains(monthlyDay)
            
        case .weeklyDay(let weeklyDays):
            let weeklyDay = WeeklyDay(date: date)
            return weeklyDays.contains(weeklyDay)
        }
    }
    
}
