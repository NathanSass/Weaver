import Foundation
import UIKit

/// This file is generated by Weaver 1.0.1
/// DO NOT EDIT!

final class MainDependencyContainer {

    static var onFatalError: (String, StaticString, UInt) -> Never = { message, file, line in
        Swift.fatalError(message, file: file, line: line)
    }

    fileprivate static func fatalError(file: StaticString = #file, line: UInt = #line) -> Never {
        onFatalError("Invalid memory graph. This is never suppose to happen. Please file a ticket at https://github.com/scribd/Weaver", file, line)
    }

    private typealias ParametersCopier = (MainDependencyContainer) -> Void
    private typealias Builder<T> = (ParametersCopier?) -> T

    private func builder<T>(_ value: T) -> Builder<T> {
        return { [weak self] copyParameters in
            guard let self = self else {
                MainDependencyContainer.fatalError()
            }
            copyParameters?(self)
            return value
        }
    }

    private func weakOptionalBuilder<T>(_ value: Optional<T>) -> Builder<Optional<T>> where T: AnyObject {
        return { [weak value] _ in value }
    }

    private func weakBuilder<T>(_ value: T) -> Builder<T> where T: AnyObject {
        return { [weak self, weak value] copyParameters in
            guard let self = self, let value = value else {
                MainDependencyContainer.fatalError()
            }
            copyParameters?(self)
            return value
        }
    }

    private func lazyBuilder<T>(_ builder: @escaping Builder<T>) -> Builder<T> {
        var _value: T?
        return { copyParameters in
            if let value = _value {
                return value
            }
            let value = builder(copyParameters)
            _value = value
            return value
        }
    }

    private func weakLazyBuilder<T>(_ builder: @escaping Builder<T>) -> Builder<T> where T: AnyObject {
        weak var _value: T?
        return { copyParameters in
            if let value = _value {
                return value
            }
            let value = builder(copyParameters)
            _value = value
            return value
        }
    }

    private static func fatalBuilder<T>() -> Builder<T> {
        return { _ in
            MainDependencyContainer.fatalError()
        }
    }

    private var builders = Dictionary<String, Any>()
    private func getBuilder<T>(for name: String, type _: T.Type) -> Builder<T> {
        guard let builder = builders[name] as? Builder<T> else {
            return MainDependencyContainer.fatalBuilder()
        }
        return builder
    }

    var host: Optional<String> {
        return getBuilder(for: "host", type: Optional<String>.self)(nil)
    }

    var logger: Logger {
        return getBuilder(for: "logger", type: Logger.self)(nil)
    }

    var movieAPI: APIProtocol {
        return getBuilder(for: "movieAPI", type: APIProtocol.self)(nil)
    }

    var urlSession: URLSession {
        return getBuilder(for: "urlSession", type: URLSession.self)(nil)
    }

    fileprivate init() {
    }

    private func movieAPIDependencyResolver() -> MovieAPIDependencyResolver {
        let _self = MainDependencyContainer()
        _self.builders["urlSession"] = _self.builder(urlSession)
        _self.builders["logger"] = lazyBuilder { (_: Optional<ParametersCopier>) -> Logger in return Logger() }
        _ = _self.getBuilder(for: "logger", type: Logger.self)(nil)
        return _self
    }

    fileprivate func publicMovieAPIDependencyResolver(urlSession: URLSession) -> MovieAPIDependencyResolver {
        let _self = MainDependencyContainer()
        _self.builders["urlSession"] = _self.builder(urlSession)
        _self.builders["logger"] = lazyBuilder { (_: Optional<ParametersCopier>) -> Logger in return Logger() }
        _ = _self.getBuilder(for: "logger", type: Logger.self)(nil)
        return _self
    }

    fileprivate func imageManagerDependencyResolver() -> ImageManagerDependencyResolver {
        let _self = MainDependencyContainer()
        _self.builders["logger"] = lazyBuilder { (_: Optional<ParametersCopier>) -> Logger in return Logger() }
        _self.builders["urlSession"] = lazyBuilder { [weak _self] (_: Optional<ParametersCopier>) -> URLSession in
            guard let _self = _self else {
                MainDependencyContainer.fatalError()
            }
            return ImageManager.makeURLSession(_self as URLSessionInputDependencyResolver)
        }
        _self.builders["movieAPI"] = lazyBuilder { [weak _self] (_: Optional<ParametersCopier>) -> APIProtocol in
            guard let _self = _self else {
                MainDependencyContainer.fatalError()
            }
            let __self = _self.movieAPIDependencyResolver()
            return MovieAPI(injecting: __self)
        }
        _ = _self.getBuilder(for: "logger", type: Logger.self)(nil)
        _ = _self.getBuilder(for: "urlSession", type: URLSession.self)(nil)
        _ = _self.getBuilder(for: "movieAPI", type: APIProtocol.self)(nil)
        return _self
    }

    static func imageManagerDependencyResolver() -> ImageManagerDependencyResolver {
        let _self = MainDependencyContainer().imageManagerDependencyResolver()
        return _self
    }

    private func movieManagerDependencyResolver() -> MovieManagerDependencyResolver {
        let _self = MainDependencyContainer()
        _self.builders["urlSession"] = lazyBuilder { [weak _self] (_: Optional<ParametersCopier>) -> URLSession in
            guard let _self = _self else {
                MainDependencyContainer.fatalError()
            }
            return { _ in URLSession.shared }(_self as URLSessionInputDependencyResolver)
        }
        _self.builders["movieAPI"] = lazyBuilder { [weak _self] (_: Optional<ParametersCopier>) -> APIProtocol in
            guard let _self = _self else {
                MainDependencyContainer.fatalError()
            }
            let __self = _self.movieAPIDependencyResolver()
            return MovieAPI(injecting: __self)
        }
        _ = _self.getBuilder(for: "urlSession", type: URLSession.self)(nil)
        _ = _self.getBuilder(for: "movieAPI", type: APIProtocol.self)(nil)
        return _self
    }

    fileprivate func publicMovieManagerDependencyResolver(host: Optional<String>,
                                                          logger: Logger) -> MovieManagerDependencyResolver {
        let _self = MainDependencyContainer()
        _self.builders["host"] = _self.builder(host)
        _self.builders["logger"] = _self.builder(logger)
        _self.builders["urlSession"] = lazyBuilder { [weak _self] (_: Optional<ParametersCopier>) -> URLSession in
            guard let _self = _self else {
                MainDependencyContainer.fatalError()
            }
            return { _ in URLSession.shared }(_self as URLSessionInputDependencyResolver)
        }
        _self.builders["movieAPI"] = lazyBuilder { [weak _self] (_: Optional<ParametersCopier>) -> APIProtocol in
            guard let _self = _self else {
                MainDependencyContainer.fatalError()
            }
            let __self = _self.movieAPIDependencyResolver()
            return MovieAPI(injecting: __self)
        }
        _ = _self.getBuilder(for: "urlSession", type: URLSession.self)(nil)
        _ = _self.getBuilder(for: "movieAPI", type: APIProtocol.self)(nil)
        return _self
    }
}


protocol HostResolver: AnyObject {
    var host: Optional<String> { get }
}

protocol LoggerResolver: AnyObject {
    var logger: Logger { get }
}

protocol MovieAPIResolver: AnyObject {
    var movieAPI: APIProtocol { get }
}

protocol UrlSessionResolver: AnyObject {
    var urlSession: URLSession { get }
}

extension MainDependencyContainer: HostResolver, LoggerResolver, MovieAPIResolver, UrlSessionResolver {
}

extension MainDependencyContainer {
}

typealias MovieAPIDependencyResolver = UrlSessionResolver & LoggerResolver

typealias ImageManagerDependencyResolver = LoggerResolver & UrlSessionResolver & MovieAPIResolver

typealias MovieManagerDependencyResolver = LoggerResolver & UrlSessionResolver & MovieAPIResolver & HostResolver

typealias URLSessionInputDependencyResolver = LoggerResolver & MovieAPIResolver & UrlSessionResolver

extension MovieAPI {
    public convenience init(urlSession: URLSession) {
        let _self = MainDependencyContainer()
        let __self = _self.publicMovieAPIDependencyResolver(urlSession: urlSession)
        self.init(injecting: __self)
    }
}

extension ImageManager {
    public convenience init() {
        let _self = MainDependencyContainer()
        let __self = _self.imageManagerDependencyResolver()
        self.init(injecting: __self)
    }
}

extension MovieManager {
    public convenience init(host: Optional<String>,
                            logger: Logger) {
        let _self = MainDependencyContainer()
        let __self = _self.publicMovieManagerDependencyResolver(host: host, logger: logger)
        self.init(injecting: __self)
    }
}
