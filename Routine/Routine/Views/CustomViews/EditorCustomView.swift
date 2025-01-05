//
//  EditorCustomView.swift
//  Routine
//
//  Created by mun on 12/21/24.
//

import UIKit

import SnapKit

class EditorCustomView: UIView {

    // 토글 Button
    var toggleSwitch: UISwitch = {
        let switchButton = UISwitch()
        switchButton.onTintColor = .black
        switchButton.isOn = false
        return switchButton
    }()

    // 이름 Label
    var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "알림"
        label.font = .systemFont(ofSize: 15)
        return label
    }()

    // 상세보기 모달 Button - 선택
    var detailModalButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("?", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        return button
    }()

    // 세부 Label
    var detailLabel: UILabel = {
        let label = UILabel()
        label.text = "오전 12시 00분"
        label.font = .systemFont(ofSize: 15)
        return label
    }()

    // 변경 Button
    var editButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrowtriangle.down.circle.fill"), for: .normal)
        button.tintColor = .black
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - 레이아웃 설정

    private func configureUI() {
        [toggleSwitch, titleLabel,detailModalButton, detailLabel, editButton].forEach {
            addSubview($0)
        }

        toggleSwitch.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(15)
        }

        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(toggleSwitch.snp.trailing).offset(10)
        }

        detailModalButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(titleLabel.snp.trailing).offset(10)
            $0.height.width.equalTo(20)
        }

        detailLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(editButton.snp.leading).offset(-10)
        }

        editButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(15)
        }
    }

}
