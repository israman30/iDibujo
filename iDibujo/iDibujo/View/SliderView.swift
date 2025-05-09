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
    let width: CGFloat = 25
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                Rectangle()
                    .frame(width: width, height: 150)
                    .foregroundStyle(.gray)
                Rectangle()
                    .foregroundStyle(.black)
                    .frame(width: width, height: min(value * 150 / 40, height, max(height + dragOffset, dragOffset)))
                    .transition(.slide)
                    .animation(.linear(duration: 0.1), value: value)
            }
            .gesture(
                DragGesture()
                    .onChanged({ value in
                        withAnimation {
                            dragOffset = -value.translation.height * 1.2
                            let newHeight = min(150, max(5, height + dragOffset))
                            self.value = newHeight / 150 * 40
                        }
                    })
                    .onEnded({ value in
                        height = min(150, max(0, height + dragOffset))
                        dragOffset = 0
                    })
            )
            .clipShape(.rect(cornerRadius: 20))
            .frame(height: 150)
    
            Text(String(format: "%.0f", value))
                .font(.title3)
                .foregroundStyle(.black)
                .contentTransition(.numericText())
        }
        .padding(.vertical, 10)
    }
}

#Preview {
    SliderView(value: .constant(10))
}
