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
    let displayHeight: CGFloat = 60
    
    @StateObject var viewModel: CalculatorViewModel
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                if let description = viewModel.errorDescription {
                    ErrorView(errorDescription: description)
                }
                Spacer()
                HStack {
                    Spacer()
                    if !viewModel.isCalculating {
                        Text(viewModel.displayText)
                            .font(.system(size: 50))
                            .foregroundColor(Colors.foreground)
                            .frame(maxHeight: displayHeight)
                            .padding(.trailing, padding)
                    } else {
                        ProgressView()
                            .frame(maxHeight: displayHeight, alignment: .center)
                            .progressViewStyle(CircularProgressViewStyle(tint: Colors.foreground))
                            .padding(.trailing, padding)
                    }
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
        }
        .background(Colors.background)
        .padding(.vertical, padding)
    }
    
    func buttonSize(forGeometrySize geometrySize: CGSize) -> CGFloat {
        let widthBase = min(geometrySize.width, geometrySize.height)
        let buttonWidth = ((widthBase - padding * 2) / 4) - spacing
        return min(buttonWidth, 120)
    }
}

// TODO: Error localization
struct ErrorView: View {
    let errorDescription: String
    var body: some View {
        Group {
            Text("⚠️ Error: \(errorDescription) \nPress C to continue")
                .padding()
                .foregroundStyle(Colors.errorForeground)
                .minimumScaleFactor(0.5)
        }
        .background(Colors.errorBackground)
        .clipShape(RoundedRectangle(cornerRadius: 25.0))
    }
}

#Preview {
    CalculatorView(viewModel: CalculatorViewModel())
}
