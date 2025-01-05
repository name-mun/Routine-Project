//
//  MainVIewDateCollectionView.swift
//  Routine
//
//  Created by t2023-m0072 on 11/17/24.
//

import UIKit

import SnapKit

// MARK: - MainDateCollectionViewCell

final class MainViewDateCollectionViewCell: UICollectionViewCell {
    
    //루틴 실행 결과 반영 필요.
    private var date: Date?
    
    private let dateButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    private let dateLabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .black
        label.backgroundColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setDate(_ date: Date) {
        self.date = date
    }
}

// MARK: - Set Up UI

extension MainViewDateCollectionViewCell {
    
    private func setUpUI() {
        
    }
    
    private func setUpButton() {
        self.addSubview(dateButton)
        
        dateButton.snp.makeConstraints { button in
            button.centerX.centerY.equalToSuperview()
            
        }
    }
    
    private func buttonCornerRound() {
        let width = dateButton.frame.size.width
        
        dateButton.clipsToBounds = true
        dateButton.layer.cornerRadius = width / 2
    }
}
