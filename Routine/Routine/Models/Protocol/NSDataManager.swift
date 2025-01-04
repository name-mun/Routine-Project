//
//  NSDataManager.swift
//  Routine
//
//  Created by t2023-m0072 on 12/29/24.
//

import UIKit

import CoreData


protocol IDNSManagedObject: NSManagedObject {
    static var classID: String { get }
}

protocol NSDataManager: AnyObject {
    
    associatedtype CoreData: IDNSManagedObject
    
    var container: NSPersistentContainer? { get set }
    var entity: NSEntityDescription? { get set }
}

extension NSDataManager {
    
    func reset() {
        let useDatas = fetchData()
        useDatas.forEach { useData in
            deleteData(useData)
        }
        save()
    }
    
    
    func configure() {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            self.container = appDelegate.persistentContainer
        }
        
        if let container = self.container,
           let entity = NSEntityDescription.entity(forEntityName: CoreData.classID, in: container.viewContext) {
            self.entity = entity
        }
    }
    
    // CoreData 에서 데이터 로드
    func fetchData() -> [CoreData] {
        guard let container else { return [] }
        do {
            let results = try container.viewContext.fetch(CoreData.fetchRequest())
            guard let useDatas = results as? [CoreData] else { return [] }
            
            return useDatas
        } catch {
            print("불러오기 실패")
            return []
        }
        
    }
    
    func deleteData(_ useData: CoreData) {
        guard let container else { return }
        container.viewContext.delete(useData)
    }
    
    func save() {
        guard let container else {
            print("save 실패")
                  return }
        if container.viewContext.hasChanges {
            do {
                try container.viewContext.save()
            } catch {
                print("데이터 저장 실패")
            }
        }
    }
}
