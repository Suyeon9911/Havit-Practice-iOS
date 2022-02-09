//
//  SignInViewController.swift
//  NetworkModule
//
//  Created by Kang, Su Jin (강수진) on 2022/01/08.
//

import UIKit
import RxSwift
import RxCocoa

class SignInViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var createAccountButton: UIButton!
    @IBOutlet var nextButton: UIButton!
    
    let viewModel = SignInViewControllerModel()
    let disposeBag = DisposeBag()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bindInput()
        bindOutput()
    }
    
    // MARK: - Methods
    // MARK: Custom Method
    private func bindInput() {
        nameTextField.rx.text
            .orEmpty
            .bind(to: viewModel.username)
            .disposed(by: disposeBag)
        
        passwordTextField.rx.text
            .orEmpty
            .bind(to: viewModel.password)
            .disposed(by: disposeBag)
        
        emailTextField.rx.text
            .orEmpty
            .bind(to: viewModel.email)
            .disposed(by: disposeBag)
        
        //TODO: coordinator 로 빼면 VM 쪽에 있어야할 듯
        createAccountButton.rx.tap
            .bind(onNext: { _ in
                let signUpViewController = UIViewController()
                signUpViewController.view.backgroundColor = .red
                self.navigationController?.pushViewController(signUpViewController, animated: true)
            })
            .disposed(by: disposeBag)
        
        nextButton.rx.tap
            .bind(onNext: { [weak self] _ in
                self?.viewModel.login()
            })
            .disposed(by: disposeBag)
    }
    
    private func bindOutput() {
        viewModel.isValid
            .bind(to: nextButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        viewModel.errorMessage
            .asDriver(onErrorJustReturn: "")
            .drive { [weak self] errorMessage in
                self?.showAlert(title: "에러", message: errorMessage)
                
            }
            .disposed(by: disposeBag)
    }
}
