//
//  RoutineSuggestionCollectionViewCell.swift
//  Routine
//
//  Created by mun on 11/15/24.
//

import UIKit
import SnapKit


class RoutineSuggestionCollectionViewCell: UICollectionViewCell {
    static let id = "routineSuggestionCollectionViewCell"
    private let view = UIView()
    private let itemLabel = UILabel()
    private let imageView = UIImageView()
    private let addButton = UIButton()
    var item: RoutineData?

    // MARK: - 초기화

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - 레이아웃 설정

    func configure() {
        view.backgroundColor = .white
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.black.cgColor

        itemLabel.text = item?.title
        itemLabel.font = .systemFont(ofSize: 15)
        itemLabel.textColor = .black

        if let sticker = item?.sticker {
            imageView.image = UIImage(systemName: sticker)?.withRenderingMode(.alwaysOriginal)
        }

        if let color = item?.color.uiColor() {
            view.backgroundColor = color
        }

        imageView.contentMode = .scaleAspectFit


        addButton.setImage(UIImage(named: "button"), for: .normal)

        [itemLabel, imageView, addButton].forEach {
            view.addSubview($0)
        }

        self.contentView.addSubview(view)

        view.snp.makeConstraints {
            $0.width.equalTo(120)
            $0.height.equalTo(160)
            $0.bottom.equalToSuperview()
        }

        itemLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(50)
            $0.centerX.equalToSuperview()
        }

        imageView.snp.makeConstraints {
            $0.width.height.equalTo(60)
            $0.centerX.bottom.equalToSuperview()
        }

        addButton.snp.makeConstraints {
            $0.width.height.equalTo(30)
            $0.top.trailing.equalToSuperview().inset(5)
        }
    }
}
