//
//  RoutineSuggestionTableHeader.swift
//  Routine
//
//  Created by mun on 11/17/24.
//

import UIKit
import SnapKit

final class RoutineSuggestionTableHeader: UITableViewHeaderFooterView {
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    var sectionTitle: String?
    var subTitle: String?

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
    }
    
    func configure() {
        titleLabel.textColor = .black
        titleLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.text = sectionTitle

        subtitleLabel.textColor = .darkGray
        subtitleLabel.font = .systemFont(ofSize: 15)
        subtitleLabel.text = subTitle

        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        
        contentView.snp.makeConstraints() {
            $0.height.equalTo(40)
        }
        
        titleLabel.snp.makeConstraints() {
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview()
        }
        
        subtitleLabel.snp.makeConstraints() {
            $0.leading.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
        }

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
