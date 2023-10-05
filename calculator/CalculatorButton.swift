//
//  CalculatorButton.swift
//  calculator
//
//  Created by Adrian Chojnacki on 02/10/2023.
//

import SwiftUI

struct CalculatorButton: View {
    @ObservedObject var viewModel: CalculatorButtonViewModel
    let buttonWidth: CGFloat
    var body: some View {
        Text(viewModel.text)
            .font(.system(size: 30))
            .foregroundStyle(.white)
            .frame(width: buttonWidth, height: buttonWidth)
            .background(content: { Circle()
                .foregroundStyle(backgroundColor)})
    }
    
    var backgroundColor: Color {
        switch viewModel.mode {
        case .operation, .clear:
            return .cyan
        case .symbol:
            return .yellow
        case .result:
            return .yellow
        case .empty:
            return .clear
        }
    }
}

struct CalculatorButton_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorButton(viewModel: CalculatorButtonViewModel(mode: .clear), buttonWidth: 80)
            .previewLayout(.sizeThatFits)
    }
}
