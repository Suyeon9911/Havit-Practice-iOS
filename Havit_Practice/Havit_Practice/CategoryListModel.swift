//
//  Category.swift
//  Havit_Practice
//
//  Created by 김수연 on 2022/01/08.
//

import Foundation

struct Category: Hashable {
    let categoryImageName: String
    let categoryTitle: String
}

struct CategoryListModel {
    private var data: [Category]?

    init() {
        self.data = [
            Category(categoryImageName: "category_icon", categoryTitle: "UX/UI 아티클1"),
            Category(categoryImageName: "category_icon", categoryTitle: "UX/UI 아티클2"),
            Category(categoryImageName: "category_icon", categoryTitle: "UX/UI 아티클3"),
            Category(categoryImageName: "category_icon", categoryTitle: "UX/UI 아티클4"),
            Category(categoryImageName: "category_icon", categoryTitle: "UX/UI 아티클5"),
            Category(categoryImageName: "category_icon", categoryTitle: "UX/UI 아티클6"),
            Category(categoryImageName: "category_icon", categoryTitle: "UX/UI 아티클7"),
            Category(categoryImageName: "category_icon", categoryTitle: "UX/UI 아티클8"),
            Category(categoryImageName: "category_icon", categoryTitle: "UX/UI 아티클9"),
            Category(categoryImageName: "category_icon", categoryTitle: "UX/UI 아티클10"),
            Category(categoryImageName: "category_icon", categoryTitle: "UX/UI 아티클11")
        ]
    }

    public func getCategoryListModel() -> [Category] {
        return data ?? []
    }
}
