//
//  RoutineEditorView.swift
//  Routine
//
//  Created by mun on 12/1/24.
//

import UIKit

import SnapKit

// 루틴 생성 및 수정(삭제) View
class RoutineEditorView: UIView {

    // MARK: - 프로퍼티 생성

    // 상단 바 view
    private let headerView: UIView = {
        let view = UIView()
        return view
    }()

    // 뒤로가기 Button
    var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        button.tintColor = .black
        return button
    }()

    // 제목 Label
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "루틴 추가"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 25)
        label.textAlignment = .center
        return label
    }()

    // 삭제하기 Button
    var deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "delete.left.fill"), for: .normal)
        button.tintColor = .black
        return button
    }()

    // 컬러, 타이틀, 스티커가 있는 stackView
    var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        return stackView
    }()

    // 컬러 이미지, 이름이 있는 View
    var colorView: UIView = {
        let view = UIView()
        return view
    }()

    // 컬러 View
    var colorButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("", for: .normal)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 35 / 2
        return button
    }()

    // 컬러 label
    private let colorLabel: UILabel = {
        let label = UILabel()
        label.text = "컬러"
        label.textColor = .black
        label.font = .systemFont(ofSize: 15)
        return label
    }()

    // 타이틀 입력 View
    var titleInputView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        return view
    }()

    // 타이틀 입력 textField
    var titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "타이틀 입력"
        textField.font = .systemFont(ofSize: 15)
        return textField
    }()

    // 타이틀 입력 이미지
    private let titleInputImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "gamecontroller")?.withRenderingMode(.alwaysOriginal)
        imageView.contentMode = .scaleAspectFill

        return imageView
    }()

    // 스티커 이미지, 스티커 이름이 있는 view
    var stickerView: UIView = {
        let view = UIView()
        return view
    }()

    // 스티커 button
    var stickerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "star"), for: .normal)
        button.tintColor = .black
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 35 / 2
        return button
    }()

    // 스티커 label
    private let stickerLabel: UILabel = {
        let label = UILabel()
        label.text = "스티커"
        label.textColor = .black
        label.font = .systemFont(ofSize: 15)
        return label
    }()

    // 스케줄 넣을 StackView
    var scheduleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.layer.borderColor = UIColor.black.cgColor
        stackView.layer.borderWidth = 1
        return stackView
    }()

    // 반복 주기 view
    var repetationView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    // 반복 주기 label
    private let repetationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "반복 주기"
        return label
    }()

    // 반복 주기 주간/월간 label
    private let repetationWeeklyLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "매주"
        label.textAlignment = .center
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.black.cgColor
        label.layer.cornerRadius = 8
        label.font = .systemFont(ofSize: 14)
        return label
    }()

    // 반복 주기 요일 label
    private let repetationDay: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "월, 화, 수, 목, 금, 토, 일"
        label.font = .systemFont(ofSize: 13)
        return label
    }()

    // 반복 주기 버튼
    var stackViewButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrowtriangle.down.circle.fill"), for: .normal)
        button.tintColor = .black
        return button
    }()

    // 알림 View
    var notificationView: UIView = {
        let view = EditorCustomView()
        view.detailModalButton.isHidden = true
        return view
    }()

    // 중단 View
    var stopView: UIView = {
        let view = EditorCustomView()
        view.titleLabel.text = "중단"
        view.detailLabel.text = "없음"
        return view
    }()

    // 설명 View
    private let informationView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        return view
    }()

    // 설명 텍스트 Label
    private let informationTextLabel: UILabel = {
        let label = UILabel()
        label.text =
"""
현재 반복주기 1주일때만 알림 설정이 가능합니다. 추후에 수정 될 예정입니다.
"""
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 12)
        label.numberOfLines = 0
        label.textAlignment = .justified
        return label
    }()

    // 추가하기 버튼
    var addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("추가하기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        return button
    }()

    // MARK: - 초기화

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - 레이아웃 설정

    private func configureUI() {
        backgroundColor = .white

        [headerView, stackView, scheduleStackView, informationView, addButton].forEach {
            self.addSubview($0)
        }

        [backButton, titleLabel, deleteButton].forEach {
            headerView.addSubview($0)
        }

        [colorView, titleInputView, stickerView].forEach {
            stackView.addArrangedSubview($0)
        }

        [repetationView, notificationView, stopView].forEach {
            scheduleStackView.addArrangedSubview($0)
        }

        [repetationLabel, repetationWeeklyLabel, repetationDay, stackViewButton].forEach {
            repetationView.addSubview($0)
        }

        [colorButton, colorLabel].forEach {
            colorView.addSubview($0)
        }

        [titleTextField, titleInputImage].forEach {
            titleInputView.addSubview($0)
        }

        [stickerButton, stickerLabel].forEach {
            stickerView.addSubview($0)
        }

        informationView.addSubview(informationTextLabel)

        // MARK: - 제약조건 설정

        headerView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(15)
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.height.equalTo(50)
        }

        backButton.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.height.width.equalTo(30)
        }

        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }

        deleteButton.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.height.width.equalTo(30)
        }

        stackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(50)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(150)
        }

        scheduleStackView.snp.makeConstraints {
            $0.top.equalTo(stackView.snp.bottom).offset(60)
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(30)
        }

        repetationView.snp.makeConstraints {
            $0.height.equalTo(70)
        }

        notificationView.snp.makeConstraints {
            $0.height.equalTo(70)
        }

        stopView.snp.makeConstraints {
            $0.height.equalTo(70)
        }

        repetationLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
        }

        repetationDay.snp.makeConstraints {
            $0.trailing.equalTo(stackViewButton.snp.leading).offset(-10)
            $0.centerY.equalToSuperview()
        }

        stackViewButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(15)
            $0.centerY.equalToSuperview()
        }

        repetationWeeklyLabel.snp.makeConstraints {
            $0.trailing.equalTo(repetationDay.snp.leading).offset(-7)
            $0.height.equalTo(30)
            $0.width.equalTo(35)
            $0.centerY.equalToSuperview()
        }

        colorView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(50)
            $0.height.equalTo(150)
            $0.width.equalTo(130)
        }

        colorButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-10)
            $0.width.height.equalTo(35)
        }

        colorLabel.snp.makeConstraints {
            $0.top.equalTo(colorButton.snp.bottom)
            $0.height.equalTo(40)
            $0.centerX.equalToSuperview()
        }

        titleInputView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(50)
            $0.height.equalTo(150)
            $0.width.equalTo(130)
        }

        titleTextField.snp.makeConstraints {
            $0.height.equalTo(100)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-20)
        }

        titleInputImage.snp.makeConstraints {
            $0.top.equalTo(titleTextField.snp.bottom).offset(10)
            $0.height.equalTo(40)
            $0.centerX.bottom.equalToSuperview()
        }

        stickerView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(50)
            $0.height.equalTo(150)
            $0.width.equalTo(130)
        }

        stickerButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-10)
            $0.width.height.equalTo(35)
        }

        stickerLabel.snp.makeConstraints {
            $0.top.equalTo(colorButton.snp.bottom)
            $0.height.equalTo(40)
            $0.centerX.equalToSuperview()
        }

        informationView.snp.makeConstraints {
            $0.top.equalTo(scheduleStackView.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.height.equalTo(60)
        }

        informationTextLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }

        addButton.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(90)
        }
    }
}
