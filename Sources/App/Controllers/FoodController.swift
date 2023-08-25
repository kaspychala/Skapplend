//
//  FoodController.swift
//  
//
//  Created by Kasper Spychala on 19/02/2023.
//

import Vapor
import Fluent

struct FoodController: RouteCollection {
    func boot(routes: Vapor.RoutesBuilder) throws {
        let foods = routes.grouped("foods")
        foods.get(use: index)
        foods.get("/paginate", use: paginate)
        foods.post(use: create)
        foods.put(use: update)
        foods.group(":foodId") { food in
            food.delete(use: delete)
        }
        foods.group("paginate") { food in
            food.get(use: paginate)
        }
    }

    func index(req: Request) async throws -> [Food] {
        try await Food.query(on: req.db).all()
    }

    func paginate(req: Request) async throws -> [Food] {
        try await Food.query(on: req.db).paginate(on: req).all()
    }

    func create(req: Request) async throws -> HTTPStatus {
        let food = try req.content.decode(Food.self)
        try await food.save(on: req.db)
        return .ok
    }

    func update(req: Request) async throws -> HTTPStatus {
        let food = try req.content.decode(Food.self)
        guard let foodFromDb = try await Food.find(food.id, on: req.db) else {
            throw Abort(.notFound)
        }

        foodFromDb.name = food.name
        foodFromDb.type = food.type
        foodFromDb.kcal = food.kcal
        foodFromDb.weight = food.weight

        try await foodFromDb.update(on: req.db)
        return .ok
    }

    func delete(req: Request) async throws -> HTTPStatus {
        guard let food = try await Food.find(req.parameters.get("id"), on: req.db) else {
            throw Abort(.notFound)
        }

        try await food.delete(on: req.db)
        return .ok
    }
}
