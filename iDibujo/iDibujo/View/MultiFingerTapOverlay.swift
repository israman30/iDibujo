//
//  MultiFingerTapOverlay.swift
//  iDibujo
//
//  Created by Israel Manzo on 3/2/25.
//  Copyright © 2025 Israel Manzo. All rights reserved.
//

import SwiftUI
import UIKit

/// Transparent overlay that captures two-finger tap (undo) and three-finger tap (redo).
/// Single-finger touches pass through for drawing.
struct MultiFingerTapOverlay: UIViewRepresentable {
    let onTwoFingerTap: () -> Void
    let onThreeFingerTap: () -> Void
    
    func makeUIView(context: Context) -> MultiFingerTapView {
        let view = MultiFingerTapView()
        view.onTwoFingerTap = onTwoFingerTap
        view.onThreeFingerTap = onThreeFingerTap
        view.setupGestureRecognizers()
        return view
    }
    
    func updateUIView(_ uiView: MultiFingerTapView, context: Context) {
        uiView.onTwoFingerTap = onTwoFingerTap
        uiView.onThreeFingerTap = onThreeFingerTap
    }
}

final class MultiFingerTapView: UIView {
    var onTwoFingerTap: (() -> Void)?
    var onThreeFingerTap: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        isUserInteractionEnabled = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
        isUserInteractionEnabled = true
    }
    
    /// Pass through single-finger touches for drawing; capture 2- and 3-finger taps.
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard let event = event, let touches = event.allTouches else { return nil }
        let count = touches.count
        if count == 2 || count == 3 {
            return super.hitTest(point, with: event)
        }
        return nil
    }
    
    func setupGestureRecognizers() {
        let twoFingerTap = UITapGestureRecognizer(target: self, action: #selector(handleTwoFingerTap))
        twoFingerTap.numberOfTouchesRequired = 2
        twoFingerTap.numberOfTapsRequired = 1
        addGestureRecognizer(twoFingerTap)
        
        let threeFingerTap = UITapGestureRecognizer(target: self, action: #selector(handleThreeFingerTap))
        threeFingerTap.numberOfTouchesRequired = 3
        threeFingerTap.numberOfTapsRequired = 1
        addGestureRecognizer(threeFingerTap)
    }
    
    @objc private func handleTwoFingerTap() {
        onTwoFingerTap?()
    }
    
    @objc private func handleThreeFingerTap() {
        onThreeFingerTap?()
    }
}
