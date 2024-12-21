//
//  RoutineResultManagerTester.swift
//  Routine
//
//  Created by t2023-m0072 on 12/21/24.
//

import Foundation

/// RoutineResultManger 테스트
///
/// .wholeTest() 를 통해 테스트 실행
///
struct RoutineResultManagerTester {
    
    private let manager = RoutineResultManager.shared
    
    // 테스트용 데이터
    private let falseResult = MockData.falseRoutineResult
    private let trueResult = MockData.trueRoutineResult
    private let date = MockData.date
    
    // 현재 테스트 데이터
    private var currentResult: [RoutineResult] {
        manager.read(date)
    }
    
    // 전체 데이터 테스트
    func wholeTest() {
        
        // 테스트 시작 전 데이터 초기화
        manager.reset()
        
        // create 테스트
        testStartPrint("create")
        manager.create(falseResult)
        // 동일한 ID 중복 추가 테스트
        manager.create(trueResult)

        currentResultPrint()
        let createResult = currentResult.count == 1 && currentResult[0] == falseResult
        testResultPrint("create", result: createResult)
        
        // update 테스트
        testStartPrint("update")
        manager.update(trueResult)
        currentResultPrint()
        let updateResult = currentResult.count == 1 && currentResult[0] == trueResult
        testResultPrint("update", result: updateResult)
        
        // delete 테스트
        testStartPrint("delete")
        manager.delete(falseResult)
        currentResultPrint()
        let deleteResult = currentResult.isEmpty
        testResultPrint("delete", result: deleteResult)
        
        // 테스트 완료 후 데이터 초기화
        manager.reset()
    }
    
    // 현재의 테스트 데이터 출력
    private func currentResultPrint() {
        guard !currentResult.isEmpty else {
            print("\n currentResult is empty \n")
            return
        }
        
        let currentResultString = currentResult.map { String(describing: $0) }.joined(separator: "\n")
        print("\n\(currentResultString)\n")
    }
    
    // 테스트 시작 메세지 출력
    private func testStartPrint(_ methodName: String) {
        print("\n======================================",
              "🎯 Test RoutineResultManager.\(methodName) 🎯", separator: "\n")
    }
    
    // 테스트 결과 메세지 출력
    private func testResultPrint(_ methodName: String, result: Bool) {
        let result = result ? "✅" : "❌"
        
        print("            \(result) \(methodName) \(result)          ",
              "======================================\n\n", separator: "\n")
    }
}
