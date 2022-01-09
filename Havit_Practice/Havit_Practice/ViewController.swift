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
        tableView.dragInteractionEnabled = true
        tableView.dragDelegate = self
        tableView.dropDelegate = self
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

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 8

    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 셀을 누르면 그 카테고리에 해당하는 콘텐츠뷰로 이동
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTVC.identifier) as? CategoryTVC else {return UITableViewCell()}

        cell.updateData(data: categoryList[indexPath.row])
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        return cell
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    // Swipe Right-to-left
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            self.categoryList.remove(at: indexPath.row)
        }
    }

    // Move Row Instance Method
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        print("\(sourceIndexPath.row) -> \(destinationIndexPath.row)")

        let categoryCell = self.categoryList[sourceIndexPath.row]

        self.categoryList.remove(at: sourceIndexPath.row)
        self.categoryList.insert(categoryCell, at: destinationIndexPath.row)
    }


}

extension ViewController: UITableViewDragDelegate {
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        return [UIDragItem(itemProvider: NSItemProvider())]
    }
}

extension ViewController: UITableViewDropDelegate {
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        if session.localDragSession != nil {
            return UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        }
        return UITableViewDropProposal(operation: .cancel, intent: .unspecified)
    }
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) { }

}

extension ViewController {
    func setLayouts() {
        setViewHierarchies()
        setConstraints()
    }

    func setViewHierarchies() {
        tableView.backgroundColor = .clear
        view.addSubview(tableView)
    }

    func setConstraints() {
        tableView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(148)
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview().inset(16)
        }
    }
}
