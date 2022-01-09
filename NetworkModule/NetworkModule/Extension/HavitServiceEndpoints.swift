//
//  HavitServiceEndpoints.swift
//  NetworkModule
//
//  Created by Kang, Su Jin (강수진) on 2022/01/08.
//

import Foundation

enum HavitServiceEndpoints {
    // organise all the end points here for clarity
    case getPosts
    case login(user: User)
    
    // gave a default timeout but can be different for each.
    var requestTimeOut: Int {
        return 20
    }
    
    // specify the type of HTTP request
    var httpMethod: HTTPMethod {
        switch self {
        case .getPosts:
            return .GET
        case .login:
            return .POST
        }
    }
    
    // encodable request body for POST
    var requestBody: Data? {
        switch self {
        case .login(let user):
            let parameters = ["email": user.email,
                              "password": user.password,
                              "address": user.address]
            // or you can use as user.encode()
            return parameters.encode()
        default:
            return nil
        }
    }
    
    // compose urls for each request
    func getURL(from environment: APIEnvironment) -> String {
        let baseUrl = environment.havitServiceBaseUrl
        switch self {
        case .getPosts:
            return "\(baseUrl)/post"
        case .login:
            return "\(baseUrl)/user/signup"
        }
    }
    
    // compose the NetworkRequest
    func createRequest(token: String = "",
                       environment: APIEnvironment) -> NetworkRequest {
        var headers: [String: String] = [:]
        headers["Content-Type"] = "application/json"
        headers["Authorization"] = "Bearer \(token)"
        return NetworkRequest(url: getURL(from: environment),
                              headers: headers,
                              reqBody: requestBody,
                              httpMethod: httpMethod)
    }
}
