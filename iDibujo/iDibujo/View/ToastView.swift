//
//  ToastView.swift
//  iDibujo
//
//  Created by Israel Manzo on 4/28/25.
//  Copyright © 2025 Israel Manzo. All rights reserved.
//

import SwiftUI
import UIKit

struct ToastView: View {
    var text: String
    @Binding var isVisible: Bool
    var delayedAnimation: CGFloat = 2
    var animationDuration: CGFloat = 0.35
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    
    public var body: some View {
        VStack {
            if isVisible {
                toastContent
            }
            Spacer()
        }
        .animation(reduceMotion ? nil : .spring(response: 0.35, dampingFraction: 0.8), value: isVisible)
        .onChange(of: isVisible) { _, visible in
            if visible {
                UIAccessibility.post(notification: .announcement, argument: text)
            }
        }
    }
    
    @ViewBuilder
    private var toastContent: some View {
        HStack(spacing: 10) {
            Image(systemName: "checkmark.circle.fill")
                .font(.title3)
                .foregroundStyle(.green)
            Text(text)
                .font(.subheadline)
                .fontWeight(.medium)
        }
        .padding(.vertical, 14)
        .padding(.horizontal, 24)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(.ultraThinMaterial)
                .shadow(color: colorScheme == .dark ? .black.opacity(0.5) : .black.opacity(0.12), radius: 16, y: 6)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(Color.primary.opacity(colorScheme == .dark ? 0.15 : 0.2), lineWidth: 1)
        )
        .transition(reduceMotion ? .opacity : .asymmetric(
            insertion: .scale(scale: 0.9).combined(with: .opacity),
            removal: .opacity.combined(with: .move(edge: .top))
        ))
        .onAppear(perform: delayText)
    }
    
    private func delayText() {
        DispatchQueue.main.asyncAfter(deadline: .now() + delayedAnimation) {
            withAnimation(.easeOut(duration: animationDuration)) {
                self.isVisible = false
            }
        }
    }
}
