//
//  CalculatorButton.swift
//  calculator
//
//  Created by Adrian Chojnacki on 02/10/2023.
//

import SwiftUI

struct CalculatorButton: View {
    var body: some View {
        ZStack {
            Circle()
                .foregroundStyle(.yellow)
            Text("1")
                .font(.system(size: 50))
                .foregroundStyle(.foreground)
                .lineLimit(1)
        }
    }
}

struct CalculatorButton_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorButton()
            .previewLayout(.sizeThatFits)
    }
}
