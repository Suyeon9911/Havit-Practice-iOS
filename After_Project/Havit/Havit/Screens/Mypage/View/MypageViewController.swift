//
//  MypageViewController.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/06.
//

import UIKit

class MypageViewController: BaseViewController {

    // MARK: - property
    
    private let mainService: MainService = MainService(apiService: APIService(),
                                                       environment: .development)
    private let myPageCategoryView = MyPageDescriptionView()
    private let myPageSaveContentsView = MyPageDescriptionView()
    private let myPageSeenContentsView = MyPageDescriptionView()

    private let reachRateLabel: UILabel = {
        let label = UILabel()
        label.font = .font(.pretendardSemibold, ofSize: 45)
        label.textColor = .white
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .font(.pretendardReular, ofSize: 17)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()

    private let bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .whiteGray
        view.layer.cornerRadius = 18
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }()

    private let mypagePepleImage: UIImageView = {
        let image = UIImageView()
        image.image = ImageLiteral.imgMyPage
        image.contentMode = .scaleAspectFit
        return image
    }()

    private let mypageCornImage: UIImageView = {
        let image = UIImageView()
        image.image = ImageLiteral.imgMyPageCorn
        image.contentMode = .scaleToFill
        return image
    }()

    private let activityTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .font(.pretendardSemibold, ofSize: 20)
        label.textColor = .gray005
        return label
    }()

    private let hStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 13
        stack.alignment = .leading
        stack.distribution = .fillEqually

        return stack
    }()

    // MARK: - init

    override init() {
        super.init()
        setStackView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getUserData()
    }

    override func render() {
        view.setGradient(colors: [UIColor(red: 0.521, green: 0.472, blue: 1, alpha: 1).cgColor,
                                  UIColor(red: 0.415, green: 0.355, blue: 1, alpha: 1).cgColor],
                         locations: [0, 1],
                         startPoint: CGPoint(x: 0.25, y: 0.5),
                         endPoint: CGPoint(x: 0.75, y: 0.5))

        view.addSubViews([reachRateLabel, descriptionLabel, mypagePepleImage, bottomView, mypageCornImage])
        bottomView.addSubViews([activityTitleLabel, hStackView])

        hStackView.addArrangedSubview(myPageCategoryView)
        hStackView.addArrangedSubview(myPageSaveContentsView)
        hStackView.addArrangedSubview(myPageSeenContentsView)

        reachRateLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(72)
            $0.leading.equalToSuperview().inset(21)
        }

        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(reachRateLabel.snp.bottom).offset(9)
            $0.leading.equalTo(reachRateLabel.snp.leading)
        }

        bottomView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(UIScreen.main.bounds.size.height * (390 / 812))
        }

        mypagePepleImage.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(8)
            $0.trailing.equalToSuperview()
            $0.leading.equalToSuperview().inset(44)
            $0.bottom.equalTo(bottomView.snp.top).offset(70)
        }

        mypageCornImage.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.bottom.equalTo(bottomView.snp.top).offset(60)
            $0.width.equalTo(112)
            $0.height.equalTo(132)
        }

        activityTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(28)
            $0.leading.equalToSuperview().inset(24)
        }

        hStackView.snp.makeConstraints {
            $0.top.equalTo(activityTitleLabel.snp.bottom).offset(27)
            $0.leading.equalToSuperview().inset(22)
            $0.trailing.equalToSuperview().inset(22)
        }
    }

    override func configUI() {
        view.backgroundColor = .havitPurple
    }

    func setStackView() {
        myPageCategoryView.setData(image: ImageLiteral.iconMyPageCategory, title: "카테고리 수", count: "0개")
        myPageSaveContentsView.setData(image: ImageLiteral.iconMyPageSave, title: "저장한 콘텐츠", count: "0개")
        myPageSeenContentsView.setData(image: ImageLiteral.iconMyPageCheck, title: "확인한 콘텐츠", count: "0개")
    }
    
    // MARK: - network
    
    private func getUserData() {
        Task {
            do {
                async let user = try await mainService.getReachRate()
                
                if let user = try await user,
                   let watchedContentCount = user.totalSeenContentNumber,
                   let totalContentCount = user.totalContentNumber,
                   let nickname = user.nickname,
                   let categoryCount = user.totalCategoryNumber {
                    let rate = (Double(watchedContentCount) / Double(totalContentCount)) * 100
                    reachRateLabel.text = "\(Int(rate))%"
                    activityTitleLabel.text = "\(nickname)님의 활동"
                    descriptionLabel.text = "\(nickname)님은 7일차 해빗러입니다.\n벌써 함께한지 일주일!"
                    
                    myPageCategoryView.countLabel.text = "\(categoryCount)개"
                    myPageSaveContentsView.countLabel.text = "\(totalContentCount)개"
                    myPageSeenContentsView.countLabel.text = "\(watchedContentCount)개"
                }
            } catch APIServiceError.serverError {
                print("serverError")
            } catch APIServiceError.clientError(let message) {
                print("clientError:\(String(describing: message))")
            }
        }
    }
}
