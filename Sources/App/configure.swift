import Vapor
import Fluent
import FluentPostgresDriver

// configures your application
public func configure(_ app: Application) throws {
    // register database
    app.databases.use(.postgres(
        hostname: Environment.get("DATABASE_HOST") ?? "localhost",
        port: Environment.get("DATABASE_PORT").flatMap(Int.init(_:)) ?? PostgresConfiguration.ianaPortNumber,
        username: Environment.get ("DATABASE_USERNAME") ?? "kspychala",
        password: Environment.get ("DATABASE_PASSWORD") ?? "",
        database: Environment.get ("DATABASE_NAME") ?? "kspychala"
    ), as: .psql)

    // register migration
    app.migrations.add(DatabaseMigration())
    try app.autoMigrate().wait()

    // register routes
    try routes(app)
}
