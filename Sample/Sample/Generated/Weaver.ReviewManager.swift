/// This file is generated by Weaver 0.9.13
/// DO NOT EDIT!
import API
import Foundation
import WeaverDI
// MARK: - ReviewManager
final class ReviewManagerDependencyContainer: DependencyContainer {
    init(parent: Reference<DependencyContainer>? = nil) {
        super.init(parent)
    }
    override func registerDependencies(in store: DependencyStore) {
        store.register(Logger.self, scope: .graph, name: "logger", builder: { (dependencies) in
            return Logger()
        })
    }
}
protocol ReviewManagerDependencyResolver {
    var logger: Logger { get }
    var movieAPI: APIProtocol { get }
}
extension ReviewManagerDependencyContainer: ReviewManagerDependencyResolver {
    var logger: Logger {
        return resolve(Logger.self, name: "logger")
    }
    var movieAPI: APIProtocol {
        return resolve(APIProtocol.self, name: "movieAPI")
    }
}
extension ReviewManager {
    static func makeReviewManager(injecting parentDependencies: DependencyContainer) -> ReviewManager {
        let dependencies = ReviewManagerDependencyContainer(parent: Reference(parentDependencies))
        return ReviewManager(injecting: dependencies)
    }
}
protocol ReviewManagerDependencyInjectable {
    init(injecting dependencies: ReviewManagerDependencyResolver)
}
extension ReviewManager: ReviewManagerDependencyInjectable {}