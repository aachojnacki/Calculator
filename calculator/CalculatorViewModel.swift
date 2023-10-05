//
//  CalculatorViewModel.swift
//  calculator
//
//  Created by Adrian Chojnacki on 03/10/2023.
//

import Combine
import CalculatorOperations
import Foundation

class CalculatorViewModel: ObservableObject {
    @Published var displayText = "0"
    @Published var operations: [CalculatorOperation] = [AddOperation()]
    @Published var buttonsMatrix: [[CalculatorButtonViewModel]] = [[]]
    
    let baseModeMatrix: [[CalculatorButtonViewModel.Mode]] = [
        [.clear, .empty, .empty, .empty],
        [.symbol("7"), .symbol("8"), .symbol("9"), .empty],
        [.symbol("4"), .symbol("5"), .symbol("6"), .empty],
        [.symbol("1"), .symbol("2"), .symbol("3"), .empty],
        [.symbol("0"), .symbol("."), .result, . empty]
    ]
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        $operations.sink { [weak self] operations in
            self?.setupMatrix(withOperations: operations)
        }
        .store(in: &cancellables)
    }
    
    private func setupMatrix(withOperations operations: [CalculatorOperation]) {
        var mutableBaseMatrix = baseModeMatrix
        var operationsIndex = 0
        
        for (rowIndex, row) in mutableBaseMatrix.enumerated() {
            for colIndex in 0..<row.count {
                if case .empty = mutableBaseMatrix[rowIndex][colIndex], operationsIndex < operations.count {
                    mutableBaseMatrix[rowIndex][colIndex] = .operation(operations[operationsIndex])
                    operationsIndex += 1
                }
            }
        }
        
        buttonsMatrix = mutableBaseMatrix.map { row in
            row.map { CalculatorButtonViewModel(mode: $0) }
        }
    }
}
