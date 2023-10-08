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
    
    private static let decimalPoint: Character = {
        let formatter = NumberFormatter()
        return formatter.decimalSeparator.first ?? "."
    }()
    
    private var cancellables: Set<AnyCancellable> = []
    
    private let baseModeMatrix: [[CalculatorButtonViewModel.Action]] = [
        [.clear, .empty, .empty, .empty],
        [.symbol("7"), .symbol("8"), .symbol("9"), .empty],
        [.symbol("4"), .symbol("5"), .symbol("6"), .empty],
        [.symbol("1"), .symbol("2"), .symbol("3"), .empty],
        [.symbol("0"), .symbol(decimalPoint), .result, . empty]
    ]
    
    private let calculatorAction = PassthroughSubject<CalculatorButtonViewModel.Action, Never>()
    private var calculationArguments: [Float] = []
    
    // a variable representing if the currently displayed input has already been collected into arguments table
    private var argumentCollected = false
    
    let errorSubject = PassthroughSubject<CalculatorError, Never>()
    @Published private var currentOperation: CalculatorOperation?
    @Published var displayText = "0"
    @Published var operations: [CalculatorOperation] = [Sine(), Cosine(), Add(), Subtract(), Multiply(), Divide()]
    @Published var buttonsMatrix: [[CalculatorButtonViewModel]] = [[]]
    @Published var errorDescription: String?
    
    init() {
        // setup bindings
        $operations.sink { [weak self] operations in
            self?.setupMatrix(withOperations: operations)
        }
        .store(in: &cancellables)
        
        $buttonsMatrix.sink { [weak self] buttonsMatrix in
            guard let self else { return }
            buttonsMatrix
                .flatMap { $0 }
                .forEach { viewModel in
                    viewModel.buttonAction.subscribe(self.calculatorAction).store(in: &viewModel.cancellables)
                }
        }
        .store(in: &cancellables)
        
        calculatorAction.sink { [weak self] action in
            guard let self else { return }
            handleAction(action: action)
        }
        .store(in: &cancellables)
        
        errorSubject
            .map { $0.description }
            .receive(on: DispatchQueue.main)
            .assign(to: &$errorDescription)
        
        errorSubject
            .map { _ in "Err"}
            .receive(on: DispatchQueue.main)
            .assign(to: &$displayText)
    }
    
    func handleAction(action: CalculatorButtonViewModel.Action) {
        // if an error occured, only accept clear action
        if errorDescription != nil {
            guard case .clear = action else { return }
        }
        
        switch action {
        case .operation(let operation):
            calculate()
            currentOperation = operation
        case .clear:
            clear()
        case .symbol(let char):
            if displayText == "0" && char != Self.decimalPoint {
                displayText = ""
            }
            if argumentCollected {
                displayText = ""
                argumentCollected = false
                
                // if no operation is currently selected, clean the arguments table
                if currentOperation == nil && !calculationArguments.isEmpty {
                    calculationArguments = []
                }
            }
            if displayText.contains(Self.decimalPoint), char == Self.decimalPoint {
                break
            }
            displayText += String(char)
        case .result:
            calculate()
            currentOperation = nil
        case .empty:
            break
        }
    }
    
    private func clear() {
        displayText = "0"
        errorDescription = nil
        currentOperation = nil
        argumentCollected = false
        calculationArguments = []
    }
    
    private func calculate() {
        if !argumentCollected {
            calculationArguments.append(Float(displayText) ?? 0)
            argumentCollected = true
        }
        guard let currentOperation else { return }
        if currentOperation.numberOfArguments == calculationArguments.count {
            Task {
                do {
                    let result = try await currentOperation.calculate(calculationArguments)
                    await MainActor.run {
                        displayText = String(result)
                        calculationArguments = [result]
                        argumentCollected = true
                    }
                } catch {
                    if let error = error as? CalculatorError {
                        errorSubject.send(error)
                    } else {
                        assertionFailure("The error should have CalculatorError type")
                    }
                }
            }
        }
    }
    
    private func setupMatrix(withOperations operations: [CalculatorOperation]) {
        var mutableBaseMatrix = baseModeMatrix
        var operationsIndex = 0
        
        // fill out empty spots with operations
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
