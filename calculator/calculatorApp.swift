//
//  calculatorApp.swift
//  calculator
//
//  Created by Adrian Chojnacki on 02/10/2023.
//

import SwiftUI

@main
struct calculatorApp: App {
    var body: some Scene {
        WindowGroup {
            CalculatorView(viewModel: CalculatorViewModel())
        }
    }
}
