//
//  CategorySingleton.swift
//  Havit_Practice
//
//  Created by 김수연 on 2022/01/11.
//

import Foundation

class CategorySingleton {
    // static을 통해 자기 자신 타입을 객체로, 생성자를 private으로 만들어서 다른 클래스에서 생성하지 못하도록
    static let shared = CategorySingleton()

    var categoryImageName: String?
    var categoryTitle: String?

    private init() { }
}
