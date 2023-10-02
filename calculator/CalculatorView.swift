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
    let buttons = [
        ["C", "sin", "cos", "/"],
        ["7", "8", "9", "*"],
        ["4", "5", "6", "-"],
        ["1", "2", "3", "+"],
        ["0", ".", "=", "₿"]
    ]
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Text("1337")
                        .font(.system(size: 50))
                }
                VStack(spacing: spacing) {
                    ForEach(buttons, id: \.self) { row in
                        HStack(spacing: spacing) {
                            ForEach(row, id: \.self) { button in
                                Text(button)
                                    .font(.system(size: 30))
                                    .foregroundStyle(.white)
                                    .frame(width: buttonSize(forGeometrySize: geometry.size), height: buttonSize(forGeometrySize: geometry.size))
                                    .background(content: { Circle()
                                        .foregroundStyle(.cyan)})
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
    CalculatorView()
}
