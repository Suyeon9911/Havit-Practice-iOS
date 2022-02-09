//
//  CategoryViewController.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/06.
//

import UIKit

import RxCocoa
import SnapKit
import ShareExtension

class CategoryViewController: BaseViewController {

    enum PresentableParentType {
        case main
        case tabbar
    }

    // MARK: - property
    let categoryService: CategorySeriviceable = CategoryService(apiService: APIService(),
                                                                environment: .development)
    private var categories: [Category] = []
    private let emptyCategoryView = EmptyCategoryView()

    private lazy var categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(cell: CategoryCollectionViewCell.self)
        return collectionView
    }()

    private let categoryCountLabel: UILabel = {
        let label = UILabel()
        label.font = .font(.pretendardReular, ofSize: 13)
        label.text = "전체 0"
        label.textColor = .gray003
        return label
    }()

    private let addButton: UIButton = {
        var configuration = UIButton.Configuration.plain()

        var container = AttributeContainer()
        container.font = .font(.pretendardSemibold, ofSize: 12)

        configuration.attributedTitle = AttributedString("카테고리 추가", attributes: container)

        configuration.baseForegroundColor = UIColor.purpleText
        configuration.image = ImageLiteral.iconCategoryAdd

        configuration.background.cornerRadius = 23
        configuration.background.strokeColor = UIColor.purpleLight
        configuration.background.strokeWidth = 1

        configuration.imagePadding = 2
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 10, bottom: 3, trailing: 10)
        configuration.imagePlacement = .leading

        let button = UIButton(configuration: configuration, primaryAction: nil)
        return button
    }()

    private let backButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 28, height: 28))
        button.setImage(ImageLiteral.btnBackBlack, for: .normal)
        return button
    }()

    private let editButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 28, height: 28))
        button.setTitle("수정", for: .normal)
        button.titleLabel?.font = .font(.pretendardMedium, ofSize: 14)
        button.setTitleColor(UIColor.gray003, for: .normal)
        return button
    }()
    private var type: PresentableParentType

    // MARK: - init

    init(type: PresentableParentType) {
        self.type = type
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegation()
    }

    override func viewWillAppear(_ animated: Bool) {
        setupBaseNavigationBar(backgroundColor: .white)
    }

    override func viewDidAppear(_ animated: Bool) {
        getCategory()
        setupCategoryViewControllerType()
    }

    func getCategory() {
        Task {
            do {
                let categories = try await categoryService.getCategory()

                if let categories = categories,
                   !categories.isEmpty {
                    self.categories = categories
                    self.categoryCountLabel.text = "전체 \(categories.count)"
                    self.categoryCollectionView.reloadData()
                } else {
                    setEmptyView()
                }
            } catch APIServiceError.serverError {
                print("serverError")
            } catch APIServiceError.clientError(let message) {
                print("clientError:\(message)")
            }
        }

    }
    
    private func setupCategoryViewControllerType() {
        switch type {
        case .main:
            backButton.isHidden = false
            tabBarController?.tabBar.isHidden = true
        case .tabbar:
            backButton.isHidden = true
        }
    }
    
    override func render() {
        view.addSubViews([categoryCollectionView, categoryCountLabel, addButton])

        categoryCountLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(22)
            $0.leading.equalToSuperview().inset(18)
        }

        addButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(13)
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(categoryCollectionView.snp.top).offset(-14)
        }

        categoryCollectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(56)
            $0.leading.bottom.trailing.equalToSuperview()
        }

    }

    override func configUI() {
        super.configUI()

        view.backgroundColor = .white
        setupBaseNavigationBar(backgroundColor: .white, titleColor: .black, isTranslucent: false)
        setNavigationItem()
        bind()
    }

    // MARK: - func
    
    private func setDelegation() {
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
    }

    private func setNavigationItem() {
        let font = UIFont.font(.pretendardBold, ofSize: 16)
        navigationController?.navigationBar.titleTextAttributes = [.font: font]
        
        navigationItem.title = "전체 카테고리"
        navigationItem.leftBarButtonItem = makeBarButtonItem(with: backButton)
        navigationItem.rightBarButtonItem = makeBarButtonItem(with: editButton)
    }

    private func makeBarButtonItem(with button: UIButton) -> UIBarButtonItem {
        return UIBarButtonItem(customView: button)
    }

    private func bind() {
        addButton.rx.tap
            .bind(onNext: { [weak self] in
                let addCategoryTitleViewController = AddCategoryTitleViewController(type: .category)
                let navigationController = UINavigationController(rootViewController: addCategoryTitleViewController)
                self?.present(navigationController, animated: true)
            })
            .disposed(by: disposeBag)

        backButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)

        editButton.rx.tap
            .bind(onNext: { [weak self] in
                let manageCategory = ManageCategoryViewController()
                manageCategory.categories = self?.categories ?? []
                self?.navigationController?.pushViewController(manageCategory, animated: true)
            })
            .disposed(by: disposeBag)
    }

    private func setEmptyView() {

        self.view.addSubview(emptyCategoryView)
        emptyCategoryView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(49)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension CategoryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = categoryCollectionView.dequeueReusableCell(forIndexPath: indexPath) as CategoryCollectionViewCell

        cell.configure(type: .category)
        cell.update(data: categories[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let categoryId = categories[indexPath.item].id else { return }
        let categoryContentViewController = CategoryContentsViewController(categoryId: categoryId,
                                                                           categories: categories)
        navigationController?.pushViewController(categoryContentViewController, animated: true)
    }
}

extension CategoryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width - 32, height: 56)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 16, bottom: 30, right: 16)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
