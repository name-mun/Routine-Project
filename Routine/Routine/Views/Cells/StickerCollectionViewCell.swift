//
//  StickerCollectionViewCell.swift
//  Routine
//
//  Created by mun on 12/22/24.
//

import UIKit

import SnapKit

final class StickerCollectionViewCell: UICollectionViewCell {

    private let stickerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .black
        return imageView
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
        backgroundColor = .white

        addSubview(stickerImageView)

        stickerImageView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }
    }

    // MARK: - 데이터 설정

    func configure(_ stickerName: String) {
        stickerImageView.image = UIImage(systemName: stickerName)?.withRenderingMode(.alwaysOriginal)
        
    }
}
