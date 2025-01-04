//
//  DatePickerCollectionViewCell.swift
//  Routine
//
//  Created by t2023-m0072 on 11/1/24.
//

import UIKit

import SnapKit

// MARK: - RoutineCollectionViewCell

class RoutineCollectionViewCell: UICollectionViewCell {
    
    static let id: String = "RoutineBoardCollectionViewCell"
    static let borderWidth: CGFloat = 1
    static let cornerRadius: CGFloat = 10
    
    // 루틴 데이터
    // 데이터가 변할 경우 프로퍼티 옵저버를 통해 뷰를 업데이트한다.
    //    private var wholeData: RoutineData? {
    //        didSet {
    //            updateData()
    //        }
    //    }
    private(set) var routine: Routine?
    private(set) var result: RoutineResult?
    
    
    // 전체 스택 뷰
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .clear
        stackView.alignment = .center
        stackView.axis = .vertical
        return stackView
    }()
    
    // 루틴 제목 라벨 뷰
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.backgroundColor = .clear
        titleLabel.textColor = .black
        titleLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 3
        return titleLabel
    }()
    
    // 스티커 이미지 뷰
    private let stickerImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .bottom
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    // 중단 마크 이미지 뷰
    private let stopMarkImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.backgroundColor = .clear
        
        imageView.image = UIImage(systemName: "minus.circle")
        imageView.contentMode = .scaleAspectFit
        imageView.isHidden = true
        
        return imageView
    }()
    
    //
    private let checkImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.isHidden = true
        
        let checkImage = UIImage(systemName: "checkmark.square.fill")?.withTintColor(.green.withAlphaComponent(0.8))
        
        let imageSize = CGSize(width: 30, height: 25)
        let renderer = UIGraphicsImageRenderer(size: imageSize)
        let resizedCheckImage = renderer.image { _ in
            checkImage?.draw(in: .init(origin: .zero, size: imageSize))
        }
        
        imageView.image = resizedCheckImage
        imageView.tintColor = .white
        
        return imageView
    }()
    
    
    override func prepareForReuse() {
        resetData()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


// MARK: - 외부 사용 메서드

extension RoutineCollectionViewCell {
    
    /// 루틴 적용
    //
    func configureRoutine(routine: Routine) {
        self.routine = routine
        updateRoutine()
    }
    
    // 루틴 결과 적용
    func configureResult(result: RoutineResult) {
        self.result = result
        updateResult(result.isCompleted)
    }
    
    /// 셀 포지션 적용
    func configurePosition(index: Int, countOfData: Int) {
        let position = Position(index: index, countOfData: countOfData)
        layer.maskedCorners = position.maskedCorner()
    }
    
}

// MARK: - 레이아웃 설정

extension RoutineCollectionViewCell {
    
    // UI 설정
    private func configureUI() {
        
        [
            stackView,
            stopMarkImageView,
            checkImageView
        ].forEach { addSubview($0) }
        
        [
            titleLabel,
            stickerImageView
        ].forEach { stackView.addArrangedSubview($0) }
        
        // 중단 마크 레이아웃 설정
        stopMarkImageView.snp.makeConstraints { imageView in
            imageView.trailing.top.equalToSuperview().inset(8)
            imageView.size.equalTo(15)
        }
        
        // 전체 스택 뷰 레이아웃 설정
        stackView.snp.makeConstraints { stackView in
            stackView.center.size.equalToSuperview()
        }
        
        // 루틴 제목 라벨 레이아웃 설정
        titleLabel.snp.makeConstraints { titleLabel in
            titleLabel.leading.trailing.equalToSuperview().inset(20)
            titleLabel.height.equalToSuperview().multipliedBy(0.7)
            titleLabel.centerX.equalToSuperview()
        }
        
        // 스티커 이미지 뷰 레이아웃 설정
        stickerImageView.snp.makeConstraints { imageView in
            imageView.height.equalToSuperview().multipliedBy(0.3)
            imageView.centerX.equalToSuperview()
        }
        
        checkImageView.snp.makeConstraints { imageView in
            imageView.center.equalToSuperview()
            imageView.size.equalToSuperview().multipliedBy(0.5)
        }
        
        clipsToBounds = true
        layer.cornerRadius = Self.cornerRadius
        layer.borderWidth = Self.borderWidth
        layer.borderColor = UIColor.black.cgColor
    }
    
    
}

// MARK: - 셀 재사용 시 사용 메서드

extension RoutineCollectionViewCell {
    
    // 셀 데이터 초기화
    private func resetData() {
        self.routine = nil
        self.result = nil
        backgroundColor = .clear
        stickerImageView.image = nil
        titleLabel.text = nil
        stopMarkImageView.isHidden = true
    }
    
}


// MARK: - 뷰 업데이트 메서드

extension RoutineCollectionViewCell {
    
    // 뷰에 루틴 데이터 적용
    private func updateRoutine() {
        guard let routine else { return }
        
        updateBackgroundColor(routine.color)
        updateTitleLabel(routine.title)
        updateStickerImageView(routine.sticker)
        updateStopMarkView(routine.stopDate == nil)
    }
    
    // 보드 컬러 업데이트
    private func updateBackgroundColor(_ color: BoardColor) {
        self.backgroundColor = color.uiColor()
    }
    
    // 루틴 제목 업데이트
    private func updateTitleLabel(_ title: String) {
        self.titleLabel.text = title
    }
    
    // 루틴 스티커 이미지 업데이트
    private func updateStickerImageView(_ assetName: AssetName) {
        guard let stickerImage = UIImage(systemName: assetName)?
            .withRenderingMode(.alwaysOriginal) else { return }
        self.stickerImageView.image = stickerImage
    }
    
    // 루틴 중단마크 업데이트
    private func updateStopMarkView(_ stop: Bool) {
        stopMarkImageView.isHidden = stop
    }
    
    private func updateResult(_ isCompleted: Bool) {
        checkImageView.isHidden = !isCompleted
    }
    
}
