//
//  RoutineDataModel+CoreDataClass.swift
//  Routine
//
//  Created by t2023-m0072 on 12/3/24.
//
//

import Foundation

import CoreData



@objc(RoutineCoreData)
public class RoutineCoreData: NSManagedObject, IDNSManagedObject {
    
    static let classID: String = "RoutineCoreData"
    
    enum Key {
        static let encodedData = "encodedData"
    }
    
    func setRoutine(_ data: Data) {
        setValue(data, forKey: RoutineCoreData.Key.encodedData)
    }
    
    func setRoutineData(_ routine: Routine) {
        let encodedData = routine.json()
        setValue(encodedData, forKey: RoutineCoreData.Key.encodedData)
    }
    
    func json() -> Data? {
        return value(forKey: RoutineCoreData.Key.encodedData) as? Data
    }
    
    func convert() -> Routine? {
        guard let encodedData = self.json(),
              let routine = Routine(from: encodedData) else { return nil}
        
        return routine
    }
}
