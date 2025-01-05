//
//  DeleteRoutineViewController.swift
//  Routine
//
//  Created by mun on 1/4/25.
//

import UIKit

import SnapKit

protocol DeleteRoutineViewControllerDelegate: AnyObject {
    func updateData(_ viewController: UIViewController, _ isApplyTapped: Bool)
}

final class DeleteRoutineViewController: UIViewController {

    var delegate: DeleteRoutineViewControllerDelegate?

    private let modalView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemBackground
        view.layer.cornerRadius = 30
        view.layer.masksToBounds = false
        view.alpha = 1
        return view
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(systemName: "exclamationmark.triangle")?.withRenderingMode(.alwaysOriginal)
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "루틴 삭제하기"
        label.font = .boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()

    private let contentsLabel: UILabel = {
        let label = UILabel()
        label.text =
"""
삭제 하시면 전체 기간에서 
해당 루틴이 삭제됩니다.
"""
        label.textColor = .gray
        label.font = .systemFont(ofSize: 15)
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()

    private let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        return stackView
    }()

    private let cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("취소", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()

    private let applyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("적용", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupAction()
    }

    // MARK: - 레이아웃 설정

    private func setupUI() {
        view.addSubview(modalView)

        [
            imageView,
            titleLabel,
            contentsLabel,
            buttonStackView
        ].forEach {
            modalView.addSubview($0)
        }

        [cancelButton, applyButton].forEach {
            buttonStackView.addArrangedSubview($0)
        }

        modalView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.center.equalToSuperview()
            $0.height.equalTo(300)
        }

        imageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(80)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }

        contentsLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }

        buttonStackView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.height.equalTo(100)
            $0.horizontalEdges.equalToSuperview()
        }
    }

    // MARK: - 액션 연결

    private func setupAction() {
        cancelButton.addAction(UIAction { [weak self] _ in
            guard let self = self else { return }
            self.cancelButtonTapped()
        }, for: .touchUpInside)

        applyButton.addAction(UIAction { [weak self] _ in
            guard let self = self else { return }
            self.applyButtonTapped()
        }, for: .touchUpInside)
    }
}

// MARK: - 액션 설정

extension DeleteRoutineViewController {
    private func cancelButtonTapped() {
        self.delegate?.updateData(self, false)
        dismiss(animated: true)
    }

    private func applyButtonTapped() {
        self.delegate?.updateData(self, true)
        dismiss(animated: true)
    }
}
