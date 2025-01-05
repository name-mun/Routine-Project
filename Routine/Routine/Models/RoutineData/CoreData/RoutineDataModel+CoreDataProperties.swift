//
//  RoutineDataModel+CoreDataProperties.swift
//  Routine
//
//  Created by t2023-m0072 on 12/3/24.
//
//

import Foundation

import CoreData


extension RoutineCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RoutineCoreData> {
        return NSFetchRequest<RoutineCoreData>(entityName: "RoutineCoreData")
    }

    @NSManaged public var encodedData: Data?

}

extension RoutineCoreData : Identifiable {

}
