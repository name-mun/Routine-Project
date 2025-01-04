//
//  RoutineSuggestionViewController.swift
//  Routine
//
//  Created by mun on 11/3/24.
//

import UIKit
import SnapKit

class RoutineSuggestionViewController: UIViewController {

    private let pageTitle = UILabel()
    private let pageDescription = UILabel()
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private let addButton = UIButton()
    private let suggestionData = SuggestionData.mock

    // 테스트용 버튼
    private lazy var testButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.setTitle("수정테스트", for: .normal)
        button.addAction(UIAction{ [weak self] _ in
            self?.testButtonTapped()
        }, for: .touchUpInside)
        return button
    }()

    var onDismiss: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        configureLayout()
    }

    private func configureUI() {
        view.backgroundColor = .white
        configurePageTitle()
        configureTableView()
        configureAddButton()
    }

    private func configurePageTitle() {
        view.addSubview(testButton)

        pageTitle.text = "루틴추천"
        pageTitle.textColor = .black
        pageTitle.font = .boldSystemFont(ofSize: 30)

        pageDescription.text = "오늘 날짜부터 루틴이 추가 돼요."
        pageDescription.textColor = .black
        pageDescription.font = .systemFont(ofSize: 15)

        [pageTitle, pageDescription].forEach {
            view.addSubview($0)
        }
    }

    private func configureTableView() {
        view.addSubview(tableView)

        tableView.backgroundColor = .white
        tableView.register(RoutineSuggestionTableViewCell.self, forCellReuseIdentifier: RoutineSuggestionTableViewCell.id)

        tableView.register(RoutineSuggestionTableHeader.self, forHeaderFooterViewReuseIdentifier: "RoutineSuggestionTableHeader")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }

    private func configureAddButton() {
        addButton.setTitle("직접 만들기", for: .normal)
        addButton.titleLabel?.font = .boldSystemFont(ofSize: 17)
        addButton.backgroundColor = .black
        addButton.layer.cornerRadius = 25

        view.addSubview(addButton)

        addButton.addTarget(self, action: #selector(clickButton), for: .touchDown)
    }

    private func configureLayout() {
        testButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(30)
            $0.leading.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }

        pageTitle.snp.makeConstraints {
            $0.top.equalTo(testButton.snp.bottom).offset(10)
            $0.leading.equalToSuperview().inset(20)
        }

        pageDescription.snp.makeConstraints {
            $0.top.equalTo(pageTitle.snp.bottom).offset(10)
            $0.leading.equalTo(pageTitle.snp.leading)
        }

        tableView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview()
            $0.top.equalTo(pageDescription.snp.bottom).offset(50)
            $0.trailing.equalToSuperview()
        }

        addButton.snp.makeConstraints() {
            $0.width.equalTo(150)
            $0.height.equalTo(50)
            $0.bottom.equalToSuperview().inset(40)
            $0.centerX.equalToSuperview()
        }
    }

    private func closeModal() {
        onDismiss?()
        self.dismiss(animated: true)
    }

    private func testButtonTapped() {
        let testData = RoutineData(title: "테스트", color: .creamyBeige, sticker: "star", repeatation: Repeatation.default)
        RoutineManager.shared.create(testData)
        let nextVC = CreateRoutineViewController(RoutineEditorMode.edit)
        nextVC.configureData(testData)

        let nav = self.presentingViewController as? UINavigationController

        nav?.pushViewController(nextVC, animated: true)

        self.dismiss(animated: true, completion: nil)
    }

    @objc
    private func clickButton() {

        let newViewController = CreateRoutineViewController(RoutineEditorMode.create)

        let nav = self.presentingViewController as? UINavigationController

        nav?.pushViewController(newViewController, animated: true)

        self.dismiss(animated: true, completion: nil)

        //nextScreen.modalPresentationStyle = .fullScreen

        //present(nextScreen,animated: true,completion: nil)
        //.navigationController?.pushViewController(nextScreen, animated: true)
        //navigationController?.pushViewController(nextScreen, animated: true)
    }
}

// MARK: - TableView Delegate 설정

extension RoutineSuggestionViewController: UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return suggestionData.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 240
    }

}

// MARK: - TableView DataSource 설정

extension RoutineSuggestionViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "RoutineSuggestionTableHeader") as? RoutineSuggestionTableHeader else {
            return nil
        }
        headerView.sectionTitle = suggestionData[section].sectionTitle
        headerView.subTitle = suggestionData[section].subTitle
        headerView.configure()

        return headerView
    }

    func tableView(_ tableView:  UITableView, cellForRowAt indexPath:  IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RoutineSuggestionTableViewCell.id, for: indexPath) as? RoutineSuggestionTableViewCell else {
            return UITableViewCell()
        }
        cell.data = suggestionData[indexPath.section].routineSuggestionData
        cell.configure()
        cell.closeModal = closeModal
        return cell
    }
}

#Preview("RoutineSuggestionViewController") {
    RoutineSuggestionViewController()
}

