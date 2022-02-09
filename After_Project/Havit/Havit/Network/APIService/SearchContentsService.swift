//
//  SearchContentsService.swift
//  Havit
//
//  Created by 박예빈 on 2022/01/19.
//

import Foundation

struct SearchContentsService: SearchContentsSeriviceable {

    private let apiService: Requestable
    private let environment: APIEnvironment

    init(apiService: Requestable, environment: APIEnvironment) {
        self.apiService = apiService
        self.environment = environment
    }

    func getSearchResult(keyword: String) async throws -> [Content]? {
        let request = SearchContentsEndPoint
            .getSearchResult(keyword: keyword)
            .createRequest(environment: environment)
        return try await self.apiService.request(request)
    }
}
