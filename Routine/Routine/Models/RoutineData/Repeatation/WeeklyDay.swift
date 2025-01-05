//
//  WeeklyDay.swift
//  Routine
//
//  Created by t2023-m0072 on 12/6/24.
//

import Foundation

///요일 데이터 형식
///
///monday = 0, sunday = 6
enum WeeklyDay: Int, Codable, CaseIterable, CustomStringConvertible, Comparable {
    
    case monday = 0
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
    case sunday = 6
    
    var description: String {
        switch self {
        case .monday: return "월"
        case .tuesday: return "화"
        case .wednesday: return "수"
        case .thursday: return "목"
        case .friday: return "금"
        case .saturday: return "토"
        case .sunday: return "일"
        }
    }
            
    static func < (lhs: WeeklyDay, rhs: WeeklyDay) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
    
    init(date: Date) {
        let dayOfWeekIndex = (Calendar.current.component(.weekday, from: date) + 5) % 7
        
        guard let dayOfWeek = WeeklyDay.init(rawValue: dayOfWeekIndex) else {
            self = .sunday
            return
        }
        self = dayOfWeek
    }
}
