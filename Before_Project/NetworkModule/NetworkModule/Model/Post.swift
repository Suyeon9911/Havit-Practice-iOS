//
//  Post.swift
//  NetworkModule
//
//  Created by Kang, Su Jin (강수진) on 2022/01/08.
//

import Foundation

struct Post: Decodable {
    let id: Int
    let img: String
    let title, category: String
    let price: Int
    let state, trade, content: String
    let isDeleted: Bool
    let createdAt: String
    let userID: Int
    let address: String

    enum CodingKeys: String, CodingKey {
        case id, img, title, category, price, state, trade, content, isDeleted, createdAt
        case userID = "userId"
        case address
    }
}
