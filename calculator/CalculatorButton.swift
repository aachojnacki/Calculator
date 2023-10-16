//
//  CalculatorButton.swift
//  calculator
//
//  Created by Adrian Chojnacki on 02/10/2023.
//

import SwiftUI

struct CalculatorButton: View {
    @State private var isPressed = false
    @ObservedObject var viewModel: CalculatorButtonViewModel
    let buttonWidth: CGFloat
    var body: some View {
        Button(action: { viewModel.buttonPressed() }, label: {
            Text(viewModel.text)
                .font(.system(size: 30))
                .foregroundStyle(.white)
                .frame(width: buttonWidth, height: buttonWidth)
                .background(content: {
                    Circle()
                        .foregroundStyle(backgroundColor)
                })
        })
    }
    
    var backgroundColor: Color {
        let color: Color
        switch viewModel.mode {
        case .operation, .clear:
            if viewModel.isSelected {
                color = Colors.operationButtonSelected
            } else {
                color = Colors.operationButton
            }
        case .symbol:
            color = Colors.inputButton
        case .result:
            color = Colors.inputButton
        case .empty:
            return .clear
        }
        
        return color.opacity(isPressed ? 0.5 : 1)
    }
}

struct CalculatorButton_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorButton(viewModel: CalculatorButtonViewModel(mode: .clear), buttonWidth: 80)
            .previewLayout(.sizeThatFits)
    }
}
