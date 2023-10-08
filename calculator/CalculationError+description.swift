//
//  CalculationError+description.swift
//  calculator
//
//  Created by Adrian Chojnacki on 08/10/2023.
//

import CalculatorOperations
import Foundation

// TODO: Error localization
public extension CalculatorError {
    var description: String {
        switch self {
        case .zeroDivision:
            return "You can't divide by zero."
        case .connectionFailure:
            return "There was a problem with service connection"
        }
    }
}
