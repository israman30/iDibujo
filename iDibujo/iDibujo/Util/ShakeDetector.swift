//
//  ShakeDetector.swift
//  iDibujo
//
//  Created by Israel Manzo on 3/2/25.
//  Copyright © 2025 Israel Manzo. All rights reserved.
//

import SwiftUI
import UIKit

/// Detects device shake gesture and invokes the provided action.
/// Uses `UIResponder.motionEnded` for native shake detection.
struct ShakeDetectorModifier: ViewModifier {
    let action: () -> Void

    func body(content: Content) -> some View {
        content
            .background(ShakeDetectorView(onShake: action))
    }
}

private struct ShakeDetectorView: UIViewRepresentable {
    let onShake: () -> Void

    func makeUIView(context: Context) -> ShakeDetectorUIView {
        ShakeDetectorUIView(onShake: onShake)
    }

    func updateUIView(_ uiView: ShakeDetectorUIView, context: Context) {}
}

private final class ShakeDetectorUIView: UIView {
    var onShake: () -> Void

    init(onShake: @escaping () -> Void) {
        self.onShake = onShake
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var canBecomeFirstResponder: Bool { true }

    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            DispatchQueue.main.async { [weak self] in
                self?.onShake()
            }
        }
    }

    override func didMoveToWindow() {
        super.didMoveToWindow()
        if window != nil {
            _ = becomeFirstResponder()
        }
    }
}

extension View {
    /// Adds shake-to-trigger behavior. When the device is shaken, the action is invoked.
    func onShake(perform action: @escaping () -> Void) -> some View {
        modifier(ShakeDetectorModifier(action: action))
    }
}
