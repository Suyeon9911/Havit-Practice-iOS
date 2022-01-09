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

    private let categoryImageView = UIImageView().then {
        $0.image = UIImage(named: "category_icon")
    }

    private let categoryTitleLabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard-Medium", size: 12)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayouts()
        round()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CategoryCVC {
    func updateData(data: Category) {
        categoryImageView.image = UIImage(named: data.categoryImageName)
        categoryTitleLabel.text = "\(data.categoryTitle)"
    }

    private func round() {
        layer.cornerRadius = 6
        contentView.layer.cornerRadius = 6
    }
}

extension CategoryCVC {
    private func setLayouts() {
        setViewHierarchies()
        setConstraints()
    }

    private func setViewHierarchies() {
        contentView.layer.backgroundColor = UIColor(red: 0.969, green: 0.965, blue: 1, alpha: 1).cgColor
        contentView.addSubview(categoryImageView)
        contentView.addSubview(categoryTitleLabel)
    }

    private func setConstraints() {
        categoryImageView.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview().inset(7)
        }

        categoryTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(18)
            $0.leading.equalTo(categoryImageView.snp.trailing).offset(7)
        }
    }
}

