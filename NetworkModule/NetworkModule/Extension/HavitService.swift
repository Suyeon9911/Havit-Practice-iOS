//
//  HavitService.swift
//  NetworkModule
//
//  Created by Kang, Su Jin (강수진) on 2022/01/08.
//

import Foundation

struct HavitService: HavitServiceable {
    
    private var apiService: Requestable
    private var environment: APIEnvironment
    
    // inject this for testability
    init(apiService: Requestable, environment: APIEnvironment) {
        self.apiService = apiService
        self.environment = environment
    }
    
    func getPosts() async throws -> [Post]? {
        let request = HavitServiceEndpoints
            .getPosts
            .createRequest(environment: self.environment)
        return try await self.apiService.request(request)
    }
    
    func login(user: User) async throws -> String? {
        let request = HavitServiceEndpoints
            .login(user: user)
            .createRequest(environment: self.environment)
        return try await self.apiService.request(request)
    }
}
