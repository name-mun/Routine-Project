//
//  RoutineDataModel.swift
//  Routine
//
//  Created by t2023-m0072 on 1/4/25.
//

import Foundation

/// Routine, RoutineResult 에 대한 로직 처리 객체
/// 
class RoutineDataModel {
    
    static let shared = RoutineDataModel()
    
    private init() {}
    
    private let routineManager = RoutineManager.shared
    private let routineResultManager = RoutineResultManager.shared
    
    private func readRoutines(_ date: Date) -> [Routine] {
        let dateID = DateID(date)
        let routines = routineManager.read(date)
        
        return routines
    }
    
    private func readRoutineResult(_ routines: [Routine], _ date: Date) -> [RoutineResult] {
        let dateID = DateID(date)
        
        var routineResults = [RoutineResult]()
        
        routines.forEach { routine in
            let routineID = routine.id
            if let result = routineResultManager.read(dateID, routineID) {
                routineResults.append(result)
            } else {
                let result = RoutineResult(dateID: dateID, routineID: routineID)
                routineResultManager.create(result)
                routineResults.append(result)
            }
        }
        
        return routineResults
    }
    
    func readRoutineDatas(_ date: Date) -> [(routine: Routine, result: RoutineResult)] {
        let routines = readRoutines(date)
        let routineResults = readRoutineResult(routines, date)
        
        let datas = zip(routines, routineResults).map { $0 }
        
        return datas
    }
    
    func updateRoutine(_ routine: Routine) {
        routineManager.update(routine)
    }
    
    func updateRoutineResult(_ routineResult: RoutineResult) {
        routineResultManager.update(routineResult)
    }
    
    func createRoutine(_ routine: Routine) {
        routineManager.create(routine)
    }
    
    func deleteRoutine(_ routine: Routine) {
        routineManager.delete(routine)
        routineResultManager.deleteAll(of: routine.id)
    }
    
}
