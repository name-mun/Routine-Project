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
    
    // 루틴 데이터 모델
    private let routineDataModel = RoutineDataManager.shared
    
    // 루틴 데이터
    private var datas: [(routine: Routine, result: RoutineResult)] = []
    
    // 뷰에 로드되는 루틴 날짜 ( Model 에 위치하는게 적합할 것 같다. )
    private var date: Date = Date.now
    
    // 페이지의 루틴 날짜와 현재 날짜를 비교해, 루틴 결과 수정 가능여부 연산
    private var routineResultEditable: Bool {
        DateID(self.date) <= DateID(Date.now)
    }
    
    // 날짜 표시 라벨
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.text = DateID(date).description
        
        return label
    }()
    
    // 제목 라벨
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
        let button = UIButton(type: .system)
        
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
        let button = UIButton(type: .system)
        
        button.backgroundColor = .clear
        
        let image = UIImage(systemName: "plus.circle")
        let newSize = CGSize(width: 50, height: 50)
        let renderer = UIGraphicsImageRenderer(size: newSize)
        let resizedImage = renderer.image { _ in
            image?.draw(in: CGRect(origin: .zero, size: newSize)) // 이미지 사이즈 조정
        }
        button.setImage(resizedImage, for: .normal)
        button.tintColor = .black
        
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
        collectionView.isHidden = true
        
        return collectionView
    }()
    
    private let emptyRoutineLabel: UILabel = {
        let label = UILabel()
        
        label.text = "루틴칸이 없어요."
        label.font = .boldSystemFont(ofSize: 25)
        label.textColor = .black
        label.textAlignment = .center
        label.isHidden = true
        
        return label
    }()
    
    private let emptyMessageLabel: UILabel = {
        let label = UILabel()
        
        label.text = "루틴칸을 추가해서 루틴을 시작해보세요."
        label.font = .systemFont(ofSize: 15)
        label.textColor = .systemGray
        label.textAlignment = .center
        label.isHidden = true
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        configureUI()
        setUpRoutineCollectionView()
        collectionViewGestureRecognizer()
        updateRoutineDatas()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateRoutineDatas()
        navigationController?.isNavigationBarHidden = true
    }
    
}

// MARK: - UIGestureRecognizer 설정
extension MainRoutineViewController {
    
    // GestureRecognizer 설정 메서드
    private func collectionViewGestureRecognizer() {
        let tapGestureRecongnizer = UITapGestureRecognizer(target: self, action: #selector(collectionViewTapped))
        
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(collectionViewLogPress))
        longPressGestureRecognizer.minimumPressDuration = 0.5
        
        [
            tapGestureRecongnizer,
            longPressGestureRecognizer
        ].forEach { routineCollectionView.addGestureRecognizer($0) }
        
    }
    
    // 탭 액션
    // 선택 시 루틴 결과 저장 및 셀에 반영
    @objc
    private func collectionViewTapped(_ gesture: UITapGestureRecognizer) {
        guard gesture.state == .ended else { return }
        let location = gesture.location(in: routineCollectionView)
        guard let indexPath = routineCollectionView.indexPathForItem(at: location),
              let routineCell = routineCollectionView.cellForItem(at: indexPath) as? RoutineCollectionViewCell,
              indexPath.item < datas.count,
              routineResultEditable else { return }
        
        var result = datas[indexPath.item].result
        result.toggle()
        
        routineDataModel.updateRoutineResult(result)
        datas[indexPath.item].result = result
        routineCell.configureResult(result: result)
    }
    
    // 롱 프레스 액션
    // 0.5초 동안 길게 누를 시 루틴 수정 뷰 푸쉬
    @objc
    private func collectionViewLogPress(_ gesture: UILongPressGestureRecognizer) {
        guard gesture.state == .began else { return }
        
        let location = gesture.location(in: routineCollectionView)
        guard let indexPath = routineCollectionView.indexPathForItem(at: location),
              indexPath.item < datas.count else { return }
        
        let routine = datas[indexPath.item].routine
        
        let editRoutineViewController = CreateRoutineViewController(.edit)
        editRoutineViewController.configureData(routine)
//        editRoutineViewController.
        
        navigationController?.pushViewController(editRoutineViewController, animated: true)
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
            suggestionModalButton,
            emptyRoutineLabel,
            emptyMessageLabel
        ].forEach { view.addSubview($0) }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.leading.equalToSuperview().inset(20)
            $0.height.equalTo(30)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom)
            $0.leading.equalToSuperview().inset(20)
            $0.height.equalTo(40)
        }
        
        // 캘린더 모달 버튼 레이아웃
        calendarModalButton.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.leading.equalTo(titleLabel.snp.trailing)
            $0.height.equalTo(titleLabel)
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
        
        emptyMessageLabel.snp.makeConstraints{
            $0.center.equalTo(routineCollectionView)
        }
        
        emptyRoutineLabel.snp.makeConstraints{
            $0.bottom.equalTo(emptyMessageLabel.snp.top).offset(-10)
            $0.centerX.equalToSuperview()
        }
        
    }
    
    // 루틴 데이터 업데이트 및 컬렉션 뷰 새로고침
    private func updateRoutineDatas() {
        datas = routineDataModel.readRoutineDatas(self.date)
        routineCollectionView.reloadData()
        if datas.isEmpty {
            routineCollectionView.isHidden = true
            emptyRoutineLabel.isHidden = false
            emptyMessageLabel.isHidden = false
        } else {
            routineCollectionView.isHidden = false
            emptyRoutineLabel.isHidden = true
            emptyMessageLabel.isHidden = true
        }
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
                
        if let sheet = calendarViewController.sheetPresentationController {
            if #available(iOS 16.0, *) {
                sheet.detents = [
                    .custom { _ in
                        return 450
                    }
                ]
            } else {
                sheet.detents = [.medium()]
            }
        }
        
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
