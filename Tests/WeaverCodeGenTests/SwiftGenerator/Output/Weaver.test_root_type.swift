/// This file is generated by Weaver 0.12.4
/// DO NOT EDIT!
// MARK: - FooTest13
protocol FooTest13DependencyResolver {
    var fuu: FuuTest13 { get }
}
final class FooTest13DependencyContainer: FooTest13DependencyResolver {
    private var _fuu: FuuTest13?
    var fuu: FuuTest13 {
        if let value = _fuu { return value }
        let value = FuuTest13()
        _fuu = value
        return value
    }
    init() {
        _ = fuu
    }
}