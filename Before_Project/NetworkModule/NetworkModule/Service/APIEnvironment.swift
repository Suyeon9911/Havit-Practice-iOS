//
//  APIEnvironment.swift
//  EmojiCommit
//
//  Created by Kang, Su Jin (강수진) on 2021/05/26.
//

import Foundation

enum APIEnvironment: String, CaseIterable {
    case development
    case staging
    case production
}

extension APIEnvironment {
    var havitServiceBaseUrl: String {
        switch self {
        case .development:
            return "https://asia-northeast3-daangnmarket-wesopt.cloudfunctions.net/api"
        case .staging:
            return ""
        case .production:
            return ""
        }
    }
}
