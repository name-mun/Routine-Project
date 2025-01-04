//
//  CreateRoutineViewController.swift
//  Routine
//
//  Created by mun on 12/1/24.
//

import UIKit

enum RoutineEditorMode {
    case create
    case edit
}

// 루틴 생성 화면 ViewController
class CreateRoutineViewController: UIViewController {

    let routineEditorView = RoutineEditorView()

    private var selectedColorIndex = 0 // 선택된 색상 인덱스 저장
    private var sticker = "house.fill"
    private var color: BoardColor = BoardColor.white
    private var routineEditorMode: RoutineEditorMode
    private var routine: Routine? // 루틴 수정 모드에서 필요한 변수

    // MARK: - 초기화

    init(_ mode: RoutineEditorMode) {
        self.routineEditorMode = mode
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - 생명주기 메서드

    override func loadView() {
        super.loadView()

        view = routineEditorView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureNav()
        setupAction()
    }

    // MARK: - 레이아웃 설정

    private func configureNav() {
        self.navigationController?.navigationBar.isHidden = true
    }

    // 액션 연결
    private func setupAction() {

        // 색상 버튼 액션 연결
        routineEditorView.colorButton.addAction(UIAction{ [weak self] _ in
            self?.colorButtonTapped()
        }, for: .touchUpInside)

        // 스티커 버튼 액션 연결
        routineEditorView.stickerButton.addAction(UIAction{ [weak self] _ in
            self?.stickerButtonTapped()
        }, for: .touchUpInside)

        // 추가하기 버튼 액션 연결
        routineEditorView.addButton.addAction(UIAction{ [weak self] _ in
            self?.addButtonTapped()
        }, for: .touchUpInside)

        // 뒤로가기, 삭제하기 버튼 액션 연결
        routineEditorView.backButton.addAction(UIAction{ [weak self] _ in
            self?.backButtonTapped()
        }, for: .touchUpInside)

        // 삭제하기 버튼 액션 연결
        routineEditorView.deleteButton.addAction(UIAction{ [weak self] _ in
            self?.deleteButtonTapped()
        }, for: .touchUpInside)

    }
}

// MARK: - 데이터 설정

extension CreateRoutineViewController {
    func configureData(_ routine: Routine) {
        routineEditorView.configure(routine)
        self.routine = routine
    }
}

// MARK: - 액션 설정

extension CreateRoutineViewController {
    // 색상 버튼 눌리면 실행
    private func colorButtonTapped() {
        let modalVC = SelectColorViewController()
        modalVC.delegate = self
        modalVC.setupIndex(selectedColorIndex)
        // 모달 화면 크기 설정
        if let sheet = modalVC.sheetPresentationController {
            if #available(iOS 16.0, *) {
                sheet.detents = [
                    .custom { _ in
                        return 250
                    }
                ]
            } else {
                sheet.detents = [.medium()]
            }
        }
        present(modalVC, animated: true)
    }

    // 스티커 버튼 눌리면 실행
    private func stickerButtonTapped() {
        let modalVC = SelectStickerViewController()
        modalVC.delegate = self
        present(modalVC, animated: true)
    }

    // 추가하기 버튼 눌리면 실행
    private func addButtonTapped() {
        if routineEditorMode == .create {
            let data = Routine(
                title: routineEditorView.titleTextField.text ?? "",
                color: color,
                sticker: sticker,
                repeatation: Repeatation.default
            )
            RoutineManager.shared.create(data)
        } else {
            guard var routin = routine else { return }
            routin.title = routineEditorView.titleTextField.text ?? ""
            routin.color = color
            routin.sticker = sticker
            print(routin)
            RoutineManager.shared.update(routin)
        }
        navigationController?.popToRootViewController(animated: true)
    }

    // 뒤로가기 버튼 눌리면 실행
    private func backButtonTapped() {
        navigationController?.popToRootViewController(animated: true)
    }

    // 삭제하기 버튼 눌리면 실행
    private func deleteButtonTapped() {
        if routineEditorMode == .edit {
            let modalVC = DeleteRoutineViewController()
            modalVC.delegate = self
            modalVC.modalPresentationStyle = .overFullScreen
            modalVC.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            present(modalVC, animated: true)
        } else {
            navigationController?.popToRootViewController(animated: true)
        }
    }
}

// MARK: - SelectColorViewController Delegate 설정

extension CreateRoutineViewController: SelectColorViewControllerDelegate {
    func updateColor(_ viewController: SelectColorViewController, color: BoardColor, selectedIndex: Int) {
        let uiColor = BoardColor(rawValue: selectedIndex)?.uiColor()
        routineEditorView.colorButton.backgroundColor = uiColor
        routineEditorView.titleInputView.backgroundColor = uiColor
        self.selectedColorIndex = selectedIndex
        self.color = color
    }
}

// MARK: - SelectStickerViewController Delegate 설정

extension CreateRoutineViewController: SelectStickerViewControllerDelegate {
    func updateSticker(_ viewController: UIViewController, sticker: String) {
        routineEditorView.titleInputImage.image = UIImage(systemName: sticker)?.withRenderingMode(.alwaysOriginal)
        self.sticker = sticker
    }
}


// MARK: - DeleteRoutineViewController Delegate 설정

extension CreateRoutineViewController: DeleteRoutineViewControllerDelegate {
    func updateData(_ viewController: UIViewController, _ isApplyTapped: Bool) {
        if isApplyTapped, let routine = routine {
            RoutineManager.shared.delete(routine)
        }

        navigationController?.popToRootViewController(animated: true)
    }
}
