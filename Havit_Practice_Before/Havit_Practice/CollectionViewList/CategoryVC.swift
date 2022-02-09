//
//  CategoryVC.swift
//  Havit_Practice
//
//  Created by 김수연 on 2022/01/10.
//

import UIKit

import SnapKit
import Then

final class CategoryVC: UIViewController {

    enum Section {
        case main
    }

    private var categoryList: [Category] = []
    var dataSource: UICollectionViewDiffableDataSource<Section, Category>?

    private lazy var collectionView: UICollectionView = {
        let configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false

        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setLayouts()
        setDelegation()
        setGesture()
        updateData()
        setCollectionViewList()
    }
}

extension CategoryVC {
    private func setDelegation() {
        collectionView.dragInteractionEnabled = true
    }

    private func updateData() {
        let categoryList = CategoryListModel()
        self.categoryList = categoryList.getCategoryListModel()
    }

    private func setCollectionViewList() {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Category> {
            (cell, indexPath, category) in
            var content = cell.defaultContentConfiguration()

            content.image = UIImage(named: category.categoryImageName)
            content.text = "\(category.categoryTitle)"

            cell.contentConfiguration = content
        }
        dataSource = UICollectionViewDiffableDataSource<Section, Category>(collectionView: collectionView) { collectionView, indexPath, category in
            collectionView.dequeueConfiguredReusableCell(using: cellRegistration,
                                                         for: indexPath,
                                                         item: category)
        }

        var snapshot = NSDiffableDataSourceSnapshot<Section, Category>()
        snapshot.appendSections([.main])
        snapshot.appendItems(categoryList)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }


}

extension CategoryVC {
    private func setGesture() {
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressGesture(_:)))

        collectionView.addGestureRecognizer(longPressRecognizer)
    }

    @objc
    private func handleLongPressGesture(_ gesture: UILongPressGestureRecognizer) {
        switch gesture.state {
        case .began:
            guard let targetIndexPath = collectionView.indexPathForItem(at: gesture.location(in: collectionView)) else {
                return
            }
            collectionView.beginInteractiveMovementForItem(at: targetIndexPath)
        case .changed:
            collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: collectionView))
        case .ended:
            collectionView.endInteractiveMovement()
        default:
            collectionView.cancelInteractiveMovement()
        }

    }
}

extension CategoryVC {
    func setLayouts() {
        setViewHierarchies()
        setConstraints()
    }

    func setViewHierarchies() {
        view.addSubview(collectionView)
    }

    func setConstraints() {
        collectionView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(148)
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview().inset(16)
        }
    }
}

