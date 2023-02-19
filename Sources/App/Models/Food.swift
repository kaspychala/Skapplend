//
//  Food.swift
//  
//
//  Created by Kasper Spychala on 19/02/2023.
//

import Vapor
import Fluent

final class Food: Model, Content {
    // Name of the table or collection.
    static let schema = "foods"

    // Unique identifier for this Food.
    @ID(key: .id)
    var id: UUID?

    @Field(key: "name")
    var name: String

    @Field(key: "type")
    var type: String

    @Field(key: "safe_cats")
    var isSafeToEatForCats: Bool

    @Field(key: "safe_dogs")
    var isSafeToEatForDogs: Bool

    // Creates a new, empty Food.
    init() { }

    // Creates a new Food with all properties set.
    init(id: UUID? = nil, name: String, type: String, isSafeToEatForCats: Bool, isSafeToEatForDogs: Bool) {
        self.id = id
        self.name = name
        self.type = type
        self.isSafeToEatForDogs = self.isSafeToEatForDogs
        self.isSafeToEatForCats = self.isSafeToEatForCats
    }
}
