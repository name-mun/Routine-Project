//
//  CalendarViewController.swift
//  Routine
//
//  Created by mun on 12/1/24.
//

import UIKit

import SnapKit

/// 날짜 선택 화면 ViewController
final class CalendarViewController: UIViewController {
    
    // dismiss 시 실행 클로저
    var onDismiss: ((Date) -> Void)?
    
    // 데이터 피커
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        
        datePicker.preferredDatePickerStyle = .inline
        datePicker.datePickerMode = .date
        datePicker.contentMode = .scaleAspectFill
        
        return datePicker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        let date = self.datePicker.date
        onDismiss?(date)
    }
    
}

// MARK: - UI 설정

extension CalendarViewController {

    // 전체 UI 설정
    private func configureUI() {
        self.view.backgroundColor = .white
        
        [
            datePicker
        ].forEach { view.addSubview($0) }
        
        datePicker.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.top.equalToSuperview()
            $0.height.equalTo(400)
        }
    }

}

// MARK: - 외부 사용 메서드

extension CalendarViewController {
    
    func setDate(_ date: Date) {
        self.datePicker.date = date
    }
    
}
