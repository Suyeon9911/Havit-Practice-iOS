//
//  ViewController.swift
//  Havit_Practice
//
//  Created by 김수연 on 2022/01/07.
//

import UIKit

import SnapKit
import Then

final class ViewController: UIViewController {

    private var categoryList: [Category] = []

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(CategoryCVC.self, forCellWithReuseIdentifier: CategoryCVC.identifier)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayouts()
        setDelegation()
        setGesture()
        updateData()
    }
}

extension ViewController {
    private func setDelegation() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.dragInteractionEnabled = true
    }

    private func updateData() {
        let categoryList = CategoryListModel()
        self.categoryList = categoryList.getCategoryListModel()
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCVC.identifier, for: indexPath) as? CategoryCVC else {return UICollectionViewCell()}

        cell.updateData(data: categoryList[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }

    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let categoryItem = categoryList.remove(at: sourceIndexPath.row)
        categoryList.insert(categoryItem, at: destinationIndexPath.row)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // TODO 화면 전환 
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 343, height: 56)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension ViewController {
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

extension ViewController {
    func setLayouts() {
        setViewHierarchies()
        setConstraints()
    }

    func setViewHierarchies() {
        collectionView.backgroundColor = .clear
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
