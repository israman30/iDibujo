//
//  SliderView.swift
//  iDibujo
//
//  Created by Israel Manzo on 4/26/25.
//  Copyright © 2025 Israel Manzo. All rights reserved.
//

import SwiftUI

struct SliderView: View {
    @State var height: CGFloat = 150
    @State var dragOffset: CGFloat = 1
    @Binding var value: CGFloat
    let width: CGFloat = 28
    
    var body: some View {
        VStack(spacing: 8) {
            ZStack(alignment: .bottom) {
                // Track
                RoundedRectangle(cornerRadius: width / 2)
                    .frame(width: width, height: 150)
                    .foregroundStyle(Color(uiColor: .systemGray5))
                
                // Fill
                RoundedRectangle(cornerRadius: width / 2)
                    .frame(width: width, height: min(value * 150 / 40, height, max(height + dragOffset, dragOffset)))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [Color(uiColor: .systemGray), Color(uiColor: .systemGray2)],
                            startPoint: .bottom,
                            endPoint: .top
                        )
                    )
                    .transition(.opacity)
                    .animation(.easeOut(duration: 0.15), value: value)
            }
            .gesture(
                DragGesture()
                    .onChanged({ gestureValue in
                        withAnimation(.easeOut(duration: 0.05)) {
                            dragOffset = -gestureValue.translation.height * 1.2
                            let newHeight = min(150, max(5, height + dragOffset))
                            self.value = newHeight / 150 * 40
                        }
                    })
                    .onEnded({ _ in
                        withAnimation(.easeOut(duration: 0.2)) {
                            height = min(150, max(0, height + dragOffset))
                            dragOffset = 0
                        }
                    })
            )
            .clipShape(RoundedRectangle(cornerRadius: width / 2))
            .frame(height: 150)
            .overlay(
                RoundedRectangle(cornerRadius: width / 2)
                    .stroke(Color(uiColor: .systemGray4), lineWidth: 0.5)
            )
    
            Text(String(format: "%.0f", value))
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundStyle(.secondary)
                .contentTransition(.numericText())
                .monospacedDigit()
        }
        .padding(.vertical, 12)
    }
}

#Preview {
    SliderView(value: .constant(10))
}
