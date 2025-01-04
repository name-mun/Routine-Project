
import Foundation

struct MockData {
    
    static let uuid = UUID(uuidString: "E621E1F8-C36C-495A-93FC-0C247A3E6E5F")!
    static let date = Date(timeIntervalSince1970: TimeInterval(0))
    
    static let oldRoutine = RoutineData(id: Self.uuid,
                                        title: "1970년 루틴",
                                        color: .pastelPink,
                                        sticker: "goforward.15.ar",
                                        startDate: Self.date,
                                        stopDate: nil,
                                        repeatation: .default ,
                                        alarm: nil)
    
    static let newRoutine = RoutineData(id: Self.uuid,
                                        title: "newRoutine",
                                        color: .pastelYellow,
                                        sticker: "applelogo",
                                        startDate: Self.date,
                                        stopDate: nil,
                                        repeatation: .default,
                                        alarm: nil)
    
    static let currentRoutine = RoutineData(title: "currentRoutine",
                                            color: .pastelPeach,
                                            sticker: "applelogo",
                                            stopDate: nil,
                                            repeatation: .default,
                                            alarm: nil)
    
    static let falseRoutineResult = RoutineResult(dateID: date,
                                                  routineID: uuid,
                                                  isCompleted: false)
    
    static let trueRoutineResult = RoutineResult(dateID: date,
                                                 routineID: uuid,
                                                 isCompleted: true)

}
