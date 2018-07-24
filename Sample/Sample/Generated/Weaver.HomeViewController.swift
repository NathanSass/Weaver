/// This file is generated by Weaver 0.9.13
/// DO NOT EDIT!
import API
import Foundation
import UIKit
import WeaverDI
// MARK: - HomeViewController
final class HomeViewControllerDependencyContainer: DependencyContainer {
    init(parent: Reference<DependencyContainer>? = nil) {
        super.init(parent)
    }
    override func registerDependencies(in store: DependencyStore) {
        store.register(Logger.self, scope: .graph, name: "logger", builder: { (dependencies) in
            return Logger()
        })
        store.register(UIViewController.self, scope: .transient, name: "movieController", builder: { (dependencies, movieID: UInt, title: String) in
            return MovieViewController.makeMovieViewController(injecting: dependencies, movieID: movieID, title: title)
        })
    }
}
protocol HomeViewControllerDependencyResolver {
    var logger: Logger { get }
    func movieController(movieID: UInt, title: String) -> UIViewController
    var movieManager: MovieManaging { get }
}
extension HomeViewControllerDependencyContainer: HomeViewControllerDependencyResolver {
    var logger: Logger {
        return resolve(Logger.self, name: "logger")
    }
    func movieController(movieID: UInt, title: String) -> UIViewController {
        return resolve(UIViewController.self, name: "movieController", parameters: movieID, title)
    }
    var movieManager: MovieManaging {
        return resolve(MovieManaging.self, name: "movieManager")
    }
}
extension HomeViewController {
    static func makeHomeViewController(injecting parentDependencies: DependencyContainer) -> HomeViewController {
        let dependencies = HomeViewControllerDependencyContainer(parent: Reference(parentDependencies))
        return HomeViewController(injecting: dependencies)
    }
}
protocol HomeViewControllerDependencyInjectable {
    init(injecting dependencies: HomeViewControllerDependencyResolver)
}
extension HomeViewController: HomeViewControllerDependencyInjectable {}