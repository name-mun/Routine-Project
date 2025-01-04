//
//  SelectStickerTableHeader.swift
//  Routine
//
//  Created by mun on 12/25/24.
//

import UIKit

import SnapKit

class SelectStickerCollectionViewHeader: UICollectionReusableView {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureUI() {
        addSubview(titleLabel)

        titleLabel.snp.makeConstraints {
            $0.leading.top.equalToSuperview()
        }
    }

    func configure(_ titleName: String) {
        titleLabel.text = titleName
    }
}
