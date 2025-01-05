//
//  TestEditViewController.swift
//  Routine
//
//  Created by mun on 12/3/24.
//

import UIKit

import SnapKit

class TestEditViewController: UIViewController {

    let routineEditorView = RoutineEditorView()

    override func loadView() {
        super.loadView()

        view = routineEditorView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureNav()
    }

    private func configureNav() {
        self.navigationController?.navigationBar.isHidden = true
    }
}
