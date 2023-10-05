//
//  CalculatorButtonViewModel.swift
//  calculator
//
//  Created by Adrian Chojnacki on 05/10/2023.
//

import CalculatorOperations
import Foundation

class CalculatorButtonViewModel: ObservableObject, Identifiable, Hashable {
    static func == (lhs: CalculatorButtonViewModel, rhs: CalculatorButtonViewModel) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    enum Mode {
        case operation(CalculatorOperation)
        case clear
        case symbol(Character)
        case result
        case empty
    }
    
    @Published var text: String
    let mode: Mode
    init(mode: Mode) {
        self.mode = mode
        switch mode {
        case .operation(let operation):
            text = operation.name
        case .clear:
            text = "C"
        case .symbol(let symbol):
            text = symbol.description
        case .result:
            text = "="
        default:
            text = ""
        }
    }
    
}
