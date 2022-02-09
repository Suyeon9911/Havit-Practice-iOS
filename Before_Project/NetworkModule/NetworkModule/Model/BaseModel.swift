//
//  BaseModel.swift
//  NetworkModule
//
//  Created by Kang, Su Jin (강수진) on 2022/01/08.
//

import Foundation

struct BaseModel<T: Decodable>: Decodable {
    let status: Int?
    let success: Bool?
    let message: String?
    let data: T?
}
