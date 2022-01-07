//
//  Category.swift
//  Havit_Practice
//
//  Created by 김수연 on 2022/01/08.
//

import Foundation

struct Category {
    let categoryImageName: String
    let categoryTitle: String
}

struct CategoryListModel {
    private var data: [Category]?

    init() {
        self.data = [
            Category(categoryImageName: "category_icon", categoryTitle: "UX/UI 아티클"),
            Category(categoryImageName: "category_icon", categoryTitle: "UX/UI 아티클")
        ]
    }

    public func getCategoryListModel() -> [Category] {
        return data ?? []
    }
}
