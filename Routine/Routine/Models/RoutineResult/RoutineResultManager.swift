//
//  Untitled.swift
//  Routine
//
//  Created by t2023-m0072 on 11/30/24.
//

import UIKit

import CoreData

///RoutineResult를 관리하는 싱글톤 객체
///
///CRUD 메서드 지원
///
final class RoutineResultManager: NSDataManager {
    
    typealias CoreData = RoutineResultCoreData
    
    var container: NSPersistentContainer? = {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil }
        
        return appDelegate.persistentContainer
    }()
    
    lazy var entity: NSEntityDescription? = {
        guard let container = self.container,
              let entity = NSEntityDescription.entity(forEntityName: CoreData.classID, in: container.viewContext) else { return nil }
        
        return entity
    }()
    
    static let shared = RoutineResultManager()
    
    private init() {}
}

// MARK: - CRUD 메서드

extension RoutineResultManager {
    
    /// RoutineResult 를 생성 및 저장
    func create(_ routineResult: RoutineResult) {
        guard let container,
              let entity,
              let routineResultCoreData = NSManagedObject(entity: entity,
                                                          insertInto: container.viewContext)
                as? RoutineResultCoreData else { return }
        routineResultCoreData.set(routineResult)
        
        save()
    }
    
    /// dateID / routineID 를 통해 RoutineResult? 반환
    func read(_ dateID: DateID, _ routineID: UUID) -> RoutineResult? {
        let routineResultCoreDatas = fetchData()
        let checker = RoutineResult(dateID: dateID, routineID: routineID)
        
        for routineResultCoreData in routineResultCoreDatas {
            if routineResultCoreData.isSame(checker),
               let routineResult = routineResultCoreData.convertTo() {
                return routineResult
            }
        }
        
        return nil
    }
    
    /// routineResults 를 통해 업데이트
    func update(_ routineResult: RoutineResult) {
        let routineResultCoreDatas = fetchData()
        for routineResultCoreData in routineResultCoreDatas {
            if routineResultCoreData.isSame(routineResult) {
                routineResultCoreData.set(routineResult)
                save()
                return
            }
        }
    }
    
    /// routineResults 를 통해 데이터 삭제
    func delete(_ routineResult: RoutineResult) {
        let routineResultCoreDatas = fetchData()
        print("delete",routineResult)

        routineResultCoreDatas.forEach { routineResultCoreData in
            if routineResultCoreData.isSame(routineResult) {
                deleteData(routineResultCoreData)
            }
        }
        
        save()
    }
    
    func deleteAll(of routineID: RoutineID) {
        let routineReusltCoreDatas = fetchData()
        
        routineReusltCoreDatas.forEach { routineResultCoreData in
            if routineResultCoreData.routineID == routineID {
                deleteData(routineResultCoreData)
            }
        }
        
        save()
    }
    
    
    func readAll() {
        let routineResultCoreDatas = fetchData()
        let string = routineResultCoreDatas.compactMap { $0.convertTo() }.map { String(describing: $0) }.joined(separator: "\n")
        print(string)
    }
}
