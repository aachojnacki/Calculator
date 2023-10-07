import Foundation

public protocol CalculatorOperation {
    var numberOfArguments: Int { get }
    var name: String { get }
    func calculate(_ args:[Float]) async throws -> Float
}

public class AddOperation: CalculatorOperation {
    public let numberOfArguments = 2
    public let name = "+"
    
    public init() {}
    
    public func calculate(_ args: [Float]) async -> Float {
        return args.reduce(0) { partialResult, anotherArg in
             partialResult + anotherArg
        }
    }
}
