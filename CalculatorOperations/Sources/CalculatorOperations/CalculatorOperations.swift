import Foundation

public protocol CalculatorOperation {
    var numberOfArguments: Int { get }
    var name: String { get }
    func calculate(_ args:[Float]) async throws -> Float
}

extension CalculatorOperation {
    func checkArgsCount(argsCount: Int) {
        assert(argsCount == numberOfArguments, "Wrong args number passed to calculation")
    }
}

public class Add: CalculatorOperation {
    public let numberOfArguments = 2
    public let name = "+"
    
    public init() {}
    
    public func calculate(_ args: [Float]) async -> Float {
        checkArgsCount(argsCount: args.count)
        return args[0] + args[1]
    }
}

public class Subtract: CalculatorOperation {
    public let numberOfArguments = 2
    public let name = "-"
    
    public init() {}
    
    public func calculate(_ args: [Float]) async -> Float {
        checkArgsCount(argsCount: args.count)
        return args[0] - args[1]
    }
}

public class Multiply: CalculatorOperation {
    public let numberOfArguments = 2
    public let name = "×"
    
    public init() {}
    
    public func calculate(_ args: [Float]) async -> Float {
        checkArgsCount(argsCount: args.count)
        return args[0] * args[1]
    }
}

public class Divide: CalculatorOperation {
    public let numberOfArguments = 2
    public let name = "÷"
    
    public init() {}
    
    public func calculate(_ args: [Float]) async throws -> Float {
        checkArgsCount(argsCount: args.count)
        guard args[1] != 0 else { throw CalculatorError.zeroDivision }
        return args[0] / args[1]
    }
}

public class Sine: CalculatorOperation {
    public let numberOfArguments = 1
    public let name = "sin"
    
    public init() {}
    
    public func calculate(_ args: [Float]) async throws -> Float {
        checkArgsCount(argsCount: args.count)
        return sin(args[0])
    }
}

public class Cosine: CalculatorOperation {
    public let numberOfArguments = 1
    public let name = "cos"
    
    public init() {}
    
    public func calculate(_ args: [Float]) async throws -> Float {
        checkArgsCount(argsCount: args.count)
        return cos(args[0])
    }
}
