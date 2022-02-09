//
//  CategoryContentsCollectionViewCell.swift
//  Havit
//
//  Created by 박예빈 on 2022/01/12.
//

import UIKit

import SnapKit

final class EmptyCategoryContentsCollectionViewCell: BaseCollectionViewCell {
    
    private var noticeLabel: UILabel = {
        let label = UILabel()
        label.text = "아직 저장된 콘텐츠가 없습니다."
        return label
    }()
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage()
        return imageView
    }()
    
    private var addButton: UIButton = {
        let button = UIButton()
        button.setTitle("콘텐츠 추가", for: .normal)
        return button
    }()
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }

    override func render() {
        contentView.addSubViews([noticeLabel, imageView, addButton])
        
        noticeLabel.snp.makeConstraints {
            $0.centerX.equalTo(contentView)
            $0.top.equalTo(contentView).offset(84)
        }
        
        imageView.snp.makeConstraints {
            $0.centerX.equalTo(contentView)
            $0.left.equalTo(contentView).offset(102)
            $0.top.equalTo(noticeLabel).offset(41)
            $0.width.height.equalTo(172)
        }
        
        addButton.snp.makeConstraints {
            $0.centerX.equalTo(contentView)
            $0.top.equalTo(imageView).offset(24)
        }
    }
}
