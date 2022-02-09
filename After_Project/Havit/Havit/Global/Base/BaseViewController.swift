//
//  BaseViewController.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/06.
//

import UIKit

import RxSwift

class BaseViewController: UIViewController {

    let disposeBag = DisposeBag()

    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        render()
        configUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func render() {
        // Override Layout
    }
    
    func configUI() {
        // View Configuration
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func setupBaseNavigationBar(backgroundColor: UIColor = .white,
                                titleColor: UIColor = .black,
                                isTranslucent: Bool = false,
                                tintColor: UIColor = .black) {
        guard let navigationBar = navigationController?.navigationBar else { return }
        let appearance = UINavigationBarAppearance()
        let font = UIFont.font(.pretendardBold, ofSize: 16)
        
        appearance.backgroundColor = backgroundColor
        appearance.titleTextAttributes = [.foregroundColor: titleColor, .font: font]
        appearance.shadowColor = .clear
        
        navigationBar.standardAppearance = appearance
        navigationBar.compactAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        navigationBar.isTranslucent = isTranslucent
        navigationBar.tintColor = tintColor
    }
}
