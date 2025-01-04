//
//  Untitled.swift
//  Routine
//
//  Created by t2023-m0072 on 11/30/24.
//

import UIKit

import CoreData

/*
 루틴 -> 전체 루틴들을 코어데이터에 저장하고 있다
 루틴 결과 -> 날짜별 루틴 결과를 로드하고 저장한다. routineID, DataID 를 통해서.
 문제:
 새로운 날짜의 경우는 루틴 결과가 생성되지 않았을 수 있다.
 그렇다면, 어떻게 루틴 결과를 로드해올지?
 but, 해당 루틴 결과는 수정 불가능하다. -? 그렇다면 따로 데이터가 존재하지 않아도 괜찮은 것 같다.
 루틴 결과는 이전의 날짜들에 대해서만 동작하면 된다. -> 루틴 결과의 생성은 어떤 기준으로 해야할지 재설정하자.
 
 
 
 + ID 를 하나의 형태로 재정의하는 것도 괜찮을 것 같다.
 
 */

///RoutineResult를 관리하는 싱글톤 객체
///
///CRUD 메서드 지원
///
class RoutineResultManager: NSDataManager {
    
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
    func read(_ dateID: Date, _ routineID: UUID) -> RoutineResult? {
        let routineResultCoreDatas = fetchData()
        let checker = RoutineResult(date: dateID, routineID: routineID)
        
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
                return
            }
        }
                
        save()
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
    
    
    func readAll() {
        let routineResultCoreDatas = fetchData()
        let string = routineResultCoreDatas.compactMap { $0.convertTo() }.map { String(describing: $0) }.joined(separator: "\n")
        print(string)
    }
}
