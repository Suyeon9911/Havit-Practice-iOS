//
//  SignInViewControllerModel.swift
//  NetworkModule
//
//  Created by Kang, Su Jin (강수진) on 2022/01/08.
//

import Foundation
import RxSwift
import RxCocoa

final class SignInViewControllerModel {
    //MARK: View -> ViewModel
    let username = BehaviorRelay<String>(value: "")
    let password = BehaviorRelay<String>(value: "")
    let email = BehaviorRelay<String>(value: "")
    
    //MARK: ViewModel -> View
    let isValid: Observable<Bool>
    var errorMessage: PublishSubject<String> = PublishSubject()
    
    //MARK: private properties
    private let havitService: HavitServiceable
    private var token: String?
    
    //MARK: init
    init(havitService: HavitServiceable = HavitService(apiService: APIService(),
                                                       environment: .development)) {
        self.havitService = havitService
        isValid = Observable.combineLatest(self.username.asObservable(),
                                           self.password.asObservable(),
                                           self.email.asObservable()) { (username, password, email) in
            return username.count > 0
            && password.count > 0
            && email.count > 0
        }
    }
    
    //MARK: func
    func login() {
        let user = User(email: email.value,
                        password: password.value,
                        address: username.value)
        Task {
            do {
                let token = try await havitService.login(user: user)
                self.token = token
            } catch let error {
                var errorMessage = error.localizedDescription
                if case let APIServiceError.clientError(message) = error {
                    errorMessage = message ?? ""
                }
                self.errorMessage.onNext(errorMessage)
            }
        }
    }
}
