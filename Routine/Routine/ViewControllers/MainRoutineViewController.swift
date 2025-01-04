//
//  MainRoutineBoardView.swift
//  Routine
//
//  Created by t2023-m0072 on 11/9/24.
//

import UIKit

import SnapKit

// MARK: - MainRoutineViewController

// 루틴 메인 화면 ViewController
final class MainRoutineViewController: UIViewController {
    
    private let routineDataModel = RoutineDataModel.shared
    
    // 프로퍼티 옵저버를 통해 데이터가 변하기 전 자동으로 코어데이터에 값을 저장시킨다.
    // TODO: 마지막으로 누른 셀의 경우 데이터가 제대로 저장되지 않는 오류 발생
    // willSet / didSet 모두 적용시키면 정상 작동하지만 원인을 파악하지 못함
    private var datas: [(routine: Routine, result: RoutineResult)] = []
    
    // 뷰에 로드되는 루틴 날짜 ( Model 에 위치하는게 적합할 것 같다. )
    private var date: Date = Date.now
    
    // 페이지의 루틴 날짜와 현재 날짜를 비교해, 루틴 결과 수정 가능여부 연산 ( Model 에 위치하는게 적합할 것 같다. )
    private var routineResultEditable: Bool {
        DateID(self.date) <= DateID(Date.now)
    }
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.text = DateID(date).description
        
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "매일 한 턴, 꿈을 향해"
        label.font = .systemFont(ofSize: 30, weight: .black)
        label.textAlignment = .left
        label.numberOfLines = 1
        
        return label
    }()
    
    // 캘린더 모달 버튼
    private let calendarModalButton: UIButton = {
        let button = UIButton()
        
        let configuration = UIButton.Configuration.plain()
        button.configuration = configuration
        button.setImage(UIImage(systemName: "calendar"), for: .normal)
        button.tintColor = .black
        button.imageView?.contentMode = .scaleAspectFill
        button.addTarget(nil,
                         action: #selector(calendarModalButtonTapped),
                         for: .touchUpInside)
        
        return button
    }()
    
    // 루틴 추천 모달 버튼
    private let suggestionModalButton: UIButton = {
        let button = UIButton()
        
        button.backgroundColor = .clear
        button.setImage(UIImage(named: "button"), for: .normal)
        
        button.addTarget(nil,
                         action: #selector(suggestionModalButtonTapped),
                         for: .touchDown)
        
        return button
    }()
    
    // 루틴 컬렉션 뷰
    private let routineCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: .init())
        
        collectionView.backgroundColor = .clear
        collectionView.isEditing = false
        collectionView.showsVerticalScrollIndicator = false
        
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        configureUI()
        setUpRoutineCollectionView()
        updateRoutineDatas()
        
        RoutineManager.shared.create(MockData.oldRoutine)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateRoutineDatas()
    }
    
}

// MARK: - 기본 설정 메서드

extension MainRoutineViewController {
    
    // 전체 레이아웃 설정
    private func configureUI() {
        
        [
            dateLabel,
            titleLabel,
            calendarModalButton,
            routineCollectionView,
            suggestionModalButton
        ].forEach { view.addSubview($0) }
        
        dateLabel.snp.makeConstraints { label in
            label.top.equalTo(view.safeAreaLayoutGuide)
            label.leading.equalToSuperview().inset(20)
            label.height.equalTo(30)
        }
        
        titleLabel.snp.makeConstraints { label in
            label.top.equalTo(dateLabel.snp.bottom)
            label.leading.equalToSuperview().inset(20)
            label.height.equalTo(40)
        }
        
        // 캘린더 모달 버튼 레이아웃
        calendarModalButton.snp.makeConstraints { button in
            button.centerY.equalTo(titleLabel)
            button.leading.equalTo(titleLabel.snp.trailing)
            button.height.equalTo(titleLabel)
        }
        
        // 루틴 컬렉션 뷰 레이아웃
        routineCollectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(30)
            $0.bottom.equalToSuperview().inset(30)
            $0.leading.trailing.equalToSuperview().inset(25)
        }
        
        // 루틴 추천 모달 버튼 레이아웃
        suggestionModalButton.snp.makeConstraints() {
            $0.bottom.trailing.equalToSuperview().inset(30)
            $0.width.height.equalTo(60)
        }
        
    }
    
    // 루틴 데이터 업데이트 및 컬렉션 뷰 새로고침
    private func updateRoutineDatas() {
        datas = routineDataModel.readRoutineDatas(self.date)
        routineCollectionView.reloadData()
    }
    
}


// MARK: - 버튼 액션
extension MainRoutineViewController {
    
    // 캘린더 모달 버튼 액션
    @objc
    private func calendarModalButtonTapped() {
        let calendarViewController = CalendarViewController()
        
        calendarViewController.setDate(date)
        calendarViewController.onDismiss = { [weak self] date in
            self?.updateDate(date)
        }
        
        calendarViewController.modalPresentationStyle = .pageSheet
        present(calendarViewController, animated: false)
    }
    
    // 날짜 업데이트 메서드 ( 클로저를 통해 캘린더 뷰에 바인딩 )
    private func updateDate(_ date: Date) {
        self.date = date
        updateRoutineDatas()
        dateLabel.text = DateID(date).description
    }
    
    // 루틴 추천 모달 버튼 액션
    @objc
    private func suggestionModalButtonTapped() {
        
        let routineSuggestionView = RoutineSuggestionViewController()
        
        routineSuggestionView.onDismiss = { [weak self] in
            self?.updateRoutineDatas()
        }
        
        routineSuggestionView.modalPresentationStyle = .automatic
        present(routineSuggestionView, animated: true, completion: nil)
    }
    
}


// MARK: - 루틴 컬렉션 뷰 메서드

extension MainRoutineViewController {
    
    // 루틴 컬렉션 뷰 설정
    private func setUpRoutineCollectionView() {
        routineCollectionView.dataSource = self
        routineCollectionView.delegate = self
        
        routineCollectionView.register(RoutineCollectionViewCell.self,
                                       forCellWithReuseIdentifier: RoutineCollectionViewCell.id)
        
        configureRoutineCollectionViewFlowLayout()
    }
    
    // 루틴 컬렉션 뷰 플로우 레이아웃 설정
    private func configureRoutineCollectionViewFlowLayout() {
        let width = ( UIScreen.main.bounds.width - 2 * 25 ) / 3
        let height = width * 1.1
        
        let snakeLayout = SnakeFlowLayout()
        snakeLayout.itemSize = CGSize(width: width, height: height)
        snakeLayout.minimumInteritemSpacing = 0
        snakeLayout.minimumLineSpacing = 20
        
        routineCollectionView.collectionViewLayout = snakeLayout
    }
    
}


// MARK: - MainRoutineViewController - DataSource

extension MainRoutineViewController: UICollectionViewDataSource {
    
    // 컬렉션 뷰 셀 수 반환 메서드 (UICollectionViewDataSource)
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datas.count
    }
    
    // 컬렉션 뷰 셀 반환 메서드 (UICollectionViewDataSource)
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let defaultCell = collectionView.dequeueReusableCell(withReuseIdentifier: RoutineCollectionViewCell.id, for: indexPath)
        
        guard let routineCell = defaultCell as? RoutineCollectionViewCell else { return defaultCell }
        
        let data = datas[indexPath.item]
        
        routineCell.configureRoutine(routine: data.routine)
        routineCell.configureResult(result: data.result)
        routineCell.configurePosition(index: indexPath.item, countOfData: datas.count)
        
        return routineCell
    }
    
}

// MARK: - MainRoutineViewController - Delegate

extension MainRoutineViewController: UICollectionViewDelegate {
    
    // 셀이 선택되기 전 호출 메서드
    // 해당 셀의 결과값을 전환시킨다
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        
        guard routineResultEditable else { return false }
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? RoutineCollectionViewCell,
              var result = cell.result else { return false }
        
        result.toggle()
        routineDataModel.updateRoutineResult(result)
        cell.configureResult(result: result)
        
        return false
    }
    
}
