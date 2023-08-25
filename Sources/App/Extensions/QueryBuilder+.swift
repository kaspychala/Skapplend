//
//  QueryBuilder+.swift
//  
//
//  Created by Kasper Spychala on 24/08/2023.
//

import Foundation
import Vapor
import Fluent

//GET http://localhost:8080/api/countries?limit=20&page=1
extension QueryBuilder {
    public func paginate(on req: Request) throws -> Self {
        if let limit = req.query.basic?.limit {
            let page = req.query.basic?.page ?? 0
            let lower = (page * limit)
            return range(lower: lower, upper: (lower + limit))
        }
        return self
    }
}
