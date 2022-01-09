//
//  CategoryTVC.swift
//  Havit_Practice
//
//  Created by 김수연 on 2022/01/08.
//

import UIKit

import SnapKit
import Then

class CategoryCVC: UICollectionViewCell {
    static let identifier = "CategoryCVC"

    private let categoryView = UIView().then {
        $0.layer.backgroundColor = UIColor(red: 0.839, green: 0.836, blue: 1, alpha: 1).cgColor
        $0.layer.cornerRadius = 6
    }

    private let categoryImageView = UIImageView().then {
        $0.image = UIImage(named: "category_icon")
    }

    private let categoryTitleLabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard-Medium", size: 12)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayouts()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateData(data: Category) {
        categoryImageView.image = UIImage(named: data.categoryImageName)
        categoryTitleLabel.text = "\(data.categoryTitle)"
    }

}

extension CategoryCVC {
    private func setLayouts() {
        setViewHierarchies()
        setConstraints()
    }

    private func setViewHierarchies() {
        contentView.addSubview(categoryView)
        categoryView.addSubview(categoryImageView)
        categoryView.addSubview(categoryTitleLabel)
    }

    private func setConstraints() {
        categoryView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(343)
            $0.height.equalTo(56)
        }

        categoryImageView.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview().inset(7)
        }

        categoryTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(18)
            $0.leading.equalTo(categoryImageView.snp.trailing).offset(7)
        }
    }
}

