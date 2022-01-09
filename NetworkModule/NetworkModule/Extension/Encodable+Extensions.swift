//
//  Encodable+Extensions.swift
//  NetworkModule
//
//  Created by Kang, Su Jin (강수진) on 2022/01/08.
//

import Foundation

extension Encodable {
    func encode() -> Data? {
        do {
            return try JSONEncoder().encode(self)
        } catch {
            return nil
        }
    }
}
