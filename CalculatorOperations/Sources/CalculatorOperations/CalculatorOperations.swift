import Foundation

public protocol CalculatorOperation {
    var numberOfArguments: Int { get }
    var name: String { get }
    func calculate(_ args:[CGFloat]) async throws -> CGFloat
}

public class AddOperation: CalculatorOperation {
    public let numberOfArguments = 2
    public let name = "+"
    
    public init() {}
    
    public func calculate(_ args: [CGFloat]) async -> CGFloat {
        return args.reduce(0) { partialResult, anotherArg in
             partialResult + anotherArg
        }
    }
}
