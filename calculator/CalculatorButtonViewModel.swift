//
//  CalculatorButtonViewModel.swift
//  calculator
//
//  Created by Adrian Chojnacki on 05/10/2023.
//

import CalculatorOperations
import Combine
import Foundation

class CalculatorButtonViewModel: ObservableObject, Identifiable {
    enum Action {
        case operation(CalculatorOperation)
        case clear
        case symbol(Character)
        case result
        case empty
    }
    
    @Published var text: String
    @Published var isSelected = false
    let mode: Action
    let buttonAction = PassthroughSubject<Action, Never>()
    var cancellables = Set<AnyCancellable>()
    
    init(mode: Action) {
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
    
    func buttonPressed() {
        buttonAction.send(mode)
    }
}

// SwiftUI requires Hashable protocol to be implemented in order to use ForEach on Arrays
extension Array: Identifiable where Element: Hashable {
    public var id: Self { self }
}

extension CalculatorButtonViewModel: Hashable {
    static func == (lhs: CalculatorButtonViewModel, rhs: CalculatorButtonViewModel) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
