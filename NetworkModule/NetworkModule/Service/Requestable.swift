//
//  Requestable.swift
//  EmojiCommit
//
//  Created by Kang, Su Jin (강수진) on 2021/05/26.
//

import Foundation

protocol Requestable {
    var requestTimeOut: Float { get }
    func request<T: Decodable>(_ request: NetworkRequest) async throws -> T?
}
