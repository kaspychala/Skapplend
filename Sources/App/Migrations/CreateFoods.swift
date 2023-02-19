//
//  CreateFoods.swift
//  
//
//  Created by Kasper Spychala on 19/02/2023.
//

import Foundation
import Vapor
import Fluent

struct DatabaseMigration: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("foods")
            .id()
            .field("name", .string, .required)
            .field("type", .string, .required)
            .field("safe_cats", .bool, .required)
            .field("safe_dogs", .bool, .required)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("foods").delete()
    }
}
