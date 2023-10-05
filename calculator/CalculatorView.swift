//
//  ContentView.swift
//  calculator
//
//  Created by Adrian Chojnacki on 02/10/2023.
//

import SwiftUI

struct CalculatorView: View {
    let padding: CGFloat = 10
    let spacing: CGFloat = 10
    @StateObject var viewModel: CalculatorViewModel
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Text(viewModel.displayText)
                        .font(.system(size: 50))
                }
                VStack(spacing: spacing) {
                    ForEach(viewModel.buttonsMatrix, id: \.self) { row in
                        HStack(spacing: spacing) {
                            ForEach(row) { buttonViewModel in
                                CalculatorButton(viewModel: buttonViewModel, buttonWidth: buttonSize(forGeometrySize: geometry.size))
                            }
                        }
                    }
                }
            }
            .padding(padding)
        }
    }
    
    func buttonSize(forGeometrySize geometrySize: CGSize) -> CGFloat {
        let widthBase = min(geometrySize.width, geometrySize.height)
        let buttonWidth = ((widthBase - padding * 2) / 4) - spacing
        return min(buttonWidth, 120)
    }
}

#Preview {
    CalculatorView(viewModel: CalculatorViewModel())
}
