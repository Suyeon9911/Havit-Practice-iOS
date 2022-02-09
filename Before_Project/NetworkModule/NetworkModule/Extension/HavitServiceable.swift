//
//  HavitServiceable.swift
//  NetworkModule
//
//  Created by Kang, Su Jin (강수진) on 2022/01/08.
//

import Foundation

protocol HavitServiceable {
    func getPosts() async throws -> [Post]?
    func login(user: User) async throws -> String?
}
