//
//  CategoryServiceable.swift
//  Havit
//
//  Created by 김수연 on 2022/01/18.
//

import Foundation

protocol CategorySeriviceable {
    func createCategory(title: String, imageId: Int) async throws -> String?
    func getCategory() async throws -> [Category]?
    func editCategory(categoryId: Int, title: String, imageId: Int) async throws -> String?
    func changeCategoryOrder(categoryIndexArray: [Int]) async throws -> [Int]?
    func deleteCategory(categoryId: Int) async throws -> Int? 
}
