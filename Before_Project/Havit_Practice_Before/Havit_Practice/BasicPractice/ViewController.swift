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

    private let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "iconBackBlack"), for: .normal)
        return button
    }()

    private let editButton: UIButton = {
        let button = UIButton()
        button.setTitle("수정", for: .normal)
        button.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 14)
        button.setTitleColor(UIColor(red: 0.456, green: 0.457, blue: 0.496, alpha: 1), for: .normal)
        return button
    }()

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(CategoryCVC.self, forCellWithReuseIdentifier: CategoryCVC.identifier)

        return collectionView
    }()

    private let categoryCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Pretendard-Regular", size: 13)
        label.text = "전체 0"
        label.textColor =  UIColor(red: 0.412, green: 0.412, blue: 0.412, alpha: 1)

        return label
    }()

    private let addButton: UIButton = {
        var configuration = UIButton.Configuration.plain()

        var container = AttributeContainer()
        container.font = UIFont(name: "Pretendard-SemiBold", size: 12)

        configuration.attributedTitle = AttributedString("카테고리 추가", attributes: container)

        configuration.baseForegroundColor = UIColor(red: 0.488, green: 0.45, blue: 0.849, alpha: 1)
        configuration.image = UIImage(named: "category_add")

        configuration.background.cornerRadius = 23
        configuration.background.strokeColor = UIColor(red: 0.839, green: 0.836, blue: 1, alpha: 1)
        configuration.background.strokeWidth = 1

        configuration.imagePadding = 2
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 10, bottom: 3, trailing: 10)
        configuration.imagePlacement = .leading

        let button = UIButton(configuration: configuration, primaryAction: nil)

        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setLayouts()
        setDelegation()
        setGesture()
        updateData()
    }
}

extension ViewController {
    private func setNavigationBar() {
        title = "전체 카테고리"
        navigationController?.navigationBar.titleTextAttributes = [.font: UIFont(name: "Pretendard-Bold", size: 16)]
        navigationItem.leftBarButtonItem = makeBarButtonItem(with: backButton)
        navigationItem.rightBarButtonItem = makeBarButtonItem(with: editButton)
    }

    private func makeBarButtonItem(with button: UIButton) -> UIBarButtonItem {
        button.frame = CGRect(x: 0, y: 0, width: 28, height: 28)
        button.addTarget(self, action: #selector(buttonDidTapped(_:)), for: .touchUpInside)
        return UIBarButtonItem(customView: button)
    }

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

extension ViewController {
    @objc
    private func buttonDidTapped(_ sender: UIButton) {
        switch sender {
        case backButton:
            // 뒤로 화면전환
            navigationController?.popViewController(animated: true)
        case editButton:
            navigationController?.popViewController(animated: true)
            //navigationController?.pushViewController(, animated: true)
        default:
            break
        }
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCVC.identifier, for: indexPath) as? CategoryCVC else {return UICollectionViewCell()}

        cell.updateData(data: categoryList[indexPath.row])
        categoryCountLabel.text = "전체 \(categoryList.count)"
        
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
        return CGSize(width: UIScreen.main.bounds.size.width - 32, height: 56)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
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
        view.addSubview(categoryCountLabel)
        view.addSubview(collectionView)
        view.addSubview(addButton)
    }

    func setConstraints() {
        categoryCountLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(114)
            $0.leading.equalToSuperview().inset(18)
        }

        addButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(105)
            $0.leading.equalTo(categoryCountLabel.snp.trailing).offset(195)
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(collectionView.snp.top).offset(-14)
        }

        collectionView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(148)
            $0.leading.bottom.trailing.equalToSuperview()
        }
    }
}
