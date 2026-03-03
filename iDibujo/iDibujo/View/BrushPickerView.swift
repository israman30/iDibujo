//
//  BrushPickerView.swift
//  iDibujo
//
//  Created by Israel Manzo on 3/2/25.
//  Copyright © 2025 Israel Manzo. All rights reserved.
//

import SwiftUI

struct BrushPickerView: View {
    @Binding var selectedBrush: BrushType
    
    var body: some View {
        Menu {
            ForEach(BrushType.allCases) { brush in
                Button {
                    selectedBrush = brush
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                } label: {
                    Label(brush.label, systemImage: brush.icon)
                }
            }
        } label: {
            Image(systemName: selectedBrush.icon)
                .font(.title2)
                .fontWeight(.medium)
                .foregroundStyle(.primary)
                .frame(width: 44, height: 44)
                .background(Color(uiColor: .secondarySystemFill))
                .clipShape(Circle())
        }
        .buttonStyle(.plain)
        .accessibilityLabel("Brush: \(selectedBrush.label)")
        .accessibilityHint(Labels.a11yBrushPickerHint)
    }
}

#Preview {
    BrushPickerView(selectedBrush: .constant(.marker))
        .padding()
}
