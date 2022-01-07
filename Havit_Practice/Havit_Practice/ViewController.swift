//
//  ViewController.swift
//  Havit_Practice
//
//  Created by 김수연 on 2022/01/07.
//

import UIKit

import SnapKit
import Then

class ViewController: UIViewController {

    private var categoryList: [Category] = []

    private lazy var tableView = UITableView().then {
        $0.register(CategoryTVC.self, forCellReuseIdentifier: CategoryTVC.identifier)
        $0.separatorStyle = .none
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayouts()
        setDelegation()
        updateData()
        print("\(categoryList)")
    }


}

extension ViewController {
    private func setDelegation() {
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func updateData() {
        let categoryList = CategoryListModel()
        self.categoryList = categoryList.getCategoryListModel()
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 셀 선택시 회색으로 바뀌는 효과 해제
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTVC.identifier) as? CategoryTVC else {return UITableViewCell()}

        cell.updateData(data: categoryList[indexPath.row])
        return cell 
    }


}

extension ViewController {
    func setLayouts() {
        setViewHierarchies()
        setConstraints()
    }

    func setViewHierarchies() {
        view.addSubview(tableView)
    }

    func setConstraints() {
        tableView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(148)
            $0.bottom.leading.trailing.equalToSuperview()
        }
    }
}
