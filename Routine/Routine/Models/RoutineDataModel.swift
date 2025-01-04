//
//  RoutineDataModel.swift
//  Routine
//
//  Created by t2023-m0072 on 1/4/25.
//

import Foundation

/// Routine, RoutineResult 에 대한 로직 처리 싱글톤 객체
///
class RoutineDataModel {
    
    static let shared = RoutineDataModel()
    
    private init() {}
    
    private let routineManager = RoutineManager.shared
    private let routineResultManager = RoutineResultManager.shared
    
    /// 루틴 데이터 (Routine, RoutineResult) 불러오기
    func readRoutineDatas(_ date: Date) -> [(routine: Routine, result: RoutineResult)] {
        let routines = readRoutines(date)
        let routineResults = readRoutineResult(routines, date)
        
        let datas = zip(routines, routineResults).map { $0 }
        
        return datas
    }
    
    /// 루틴 업데이트
    func updateRoutine(_ routine: Routine) {
        routineManager.update(routine)
    }
    
    /// 루틴 결과 업데이트
    func updateRoutineResult(_ routineResult: RoutineResult) {
        routineResultManager.update(routineResult)
    }
    
    /// 루틴 생성
    func createRoutine(_ routine: Routine) {
        routineManager.create(routine)
    }
    
    /// 루틴 삭제 및 해당 루틴의 결과 전부 삭제
    func deleteRoutine(_ routine: Routine) {
        routineManager.delete(routine)
        routineResultManager.deleteAll(of: routine.id)
    }
    
}


extension RoutineDataModel {
    
    // 루틴 불러오기
    private func readRoutines(_ date: Date) -> [Routine] {
        let dateID = DateID(date)
        let routines = routineManager.read(date)
        
        return routines
    }
    
    // 루틴 결과 불러오기
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
    
}
