//
//  SelectStickerViewController.swift
//  Routine
//
//  Created by mun on 12/22/24.
//

import UIKit

import SnapKit

protocol SelectStickerViewControllerDelegate: AnyObject {
    func updateSticker(_ viewController: UIViewController, sticker: String)
}

class SelectStickerViewController: UIViewController {

    weak var delegate: SelectStickerViewControllerDelegate?
    let stickers = StickerData.data

    // 타이틀 Label
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "스티커"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()

    // 스티커 CollectionView
    lazy var stickerCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(StickerCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(SelectStickerCollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()


    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }

    // MARK: - 레이아웃 설정

    private func configureUI() {
        view.backgroundColor = .white

        [titleLabel, stickerCollectionView].forEach {
            view.addSubview($0)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.centerX.equalToSuperview()
        }

        stickerCollectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(800)
        }
    }

    // 컬렉션뷰 레이아웃 설정
    private func createLayout() -> UICollectionViewLayout {
        // 아이템 사이즈 설정
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.25),
            heightDimension: .fractionalHeight(1.0)
        )

        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 2, leading: 2, bottom: 2, trailing: 2)

        // 그룹 사이즈 설정
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(0.25)
        )

        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )

        // 섹션 설정
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.contentInsets = .init(top: 10, leading: 10, bottom: 20, trailing: 10)

        // 헤더 설정
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(44)
        )

        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )

        section.boundarySupplementaryItems = [header]
        section.orthogonalScrollingBehavior = .none // 수평 스크롤 비활성화

        return UICollectionViewCompositionalLayout(section: section)
    }

}

// MARK: - CollectionView Delegate 설정

extension SelectStickerViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.updateSticker(self, sticker: stickers[indexPath.section].stickers[indexPath.row])
        self.dismiss(animated: true)
    }
}

// MARK: - CollectionView DataSource 설정

extension SelectStickerViewController: UICollectionViewDataSource {
    // 섹션 수 설정
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        stickers.count
    }

    // 섹션 아이템 갯수 설정
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        stickers[section].stickers.count
    }

    // 셀 설정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? StickerCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(stickers[indexPath.section].stickers[indexPath.row])
        return cell
    }

    // 헤더 설정
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as? SelectStickerCollectionViewHeader else { return UICollectionViewCell() }
        header.configure(stickers[indexPath.section].category)
        return header
    }
}
