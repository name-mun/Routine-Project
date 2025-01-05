//
//  RoutineResultCoreData+CoreDataProperties.swift
//  Routine
//
//  Created by t2023-m0072 on 12/21/24.
//
//

import Foundation
import CoreData


extension RoutineResultCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RoutineResultCoreData> {
        return NSFetchRequest<RoutineResultCoreData>(entityName: "RoutineResultCoreData")
    }

    @NSManaged public var dateID: Date?
    @NSManaged public var routineID: UUID?
    @NSManaged public var isCompleted: Bool
    
    static let className = "RoutineResultCoreData"
    
    enum Key {
        static let dateID = "dateID"
        static let routineID = "routineID"
        static let isCompleted = "isCompleted"
    }

}

extension RoutineResultCoreData : Identifiable {

}
