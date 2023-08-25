//
//  URLQueryContainer+.swift
//  
//
//  Created by Kasper Spychala on 24/08/2023.
//

import Foundation
import Vapor
import Fluent

public struct BasicQuery: Codable {
    public let plain: Bool?
    public let page: Int?
    public let limit: Int?
    public let search: String?
}

extension URLQueryContainer {
    public var basic: BasicQuery? {
        let decoded = try? decode(BasicQuery.self)
        return decoded
    }

    public var plain: Bool? {
        return basic?.plain
    }

    public var page: Int? {
        return basic?.page
    }

    public var limit: Int? {
        return basic?.limit ?? 20
    }

    public var search: String? {
        return basic?.search
    }
}
