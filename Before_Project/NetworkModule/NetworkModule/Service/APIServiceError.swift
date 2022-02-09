//
//  APIServiceError.swift
//  EmojiCommit
//
//  Created by Kang, Su Jin (강수진) on 2021/04/06.
//

import Foundation

enum APIServiceError: Error {
    case urlEncodingError
    case clientError(message: String?)
    case serverError
    case unknown
}
