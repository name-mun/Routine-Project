//
//  RoutineSuggestionTableViewCell.swift
//  Routine
//
//  Created by mun on 11/15/24.
//

import UIKit
import SnapKit

class RoutineSuggestionTableViewCell: UITableViewCell {
    static let id = "routineSuggestionTableViewCell"
    var data: [Routine]?
    var closeModal: (() -> Void)?

    private var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    func configure() {
        setUpCollectionView()
        collectionView.reloadData()
    }

    // MARK: - 레이아웃 설정

    private func setUpCollectionView() {
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 15
        layout.itemSize = .init(width: 120, height: 160)

        self.backgroundColor = .white

        self.collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(RoutineSuggestionCollectionViewCell.self, forCellWithReuseIdentifier: RoutineSuggestionCollectionViewCell.id)
        
        collectionView.delegate = self
        collectionView.dataSource = self

        self.contentView.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.height.equalTo(160)
            $0.top.equalToSuperview().offset(40)
            $0.leading.trailing.equalToSuperview()
        }
    }

}

// MARK: - TableViewCell Delegate 설정

extension RoutineSuggestionTableViewCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let data = data?[indexPath.item] else { return }
        RoutineManager.shared.create(data)

        guard let closeModal = closeModal else { return }
        closeModal()
    }
}

// MARK: - TableViewCell DataSource 설정

extension RoutineSuggestionTableViewCell: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RoutineSuggestionCollectionViewCell.id, for: indexPath) as? RoutineSuggestionCollectionViewCell else { return UICollectionViewCell() }
        cell.item = data?[indexPath.item]
        cell.configure()
        return cell
    }
}
