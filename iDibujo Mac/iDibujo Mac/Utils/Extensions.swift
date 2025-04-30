//
//  Extensions.swift
//  iDibujo Mac
//
//  Created by Israel Manzo on 4/29/25.
//

import Foundation
import SwiftUI

extension View {
    func snapshot() -> NSImage {
        let controller = NSHostingController(rootView: self)
        let view = controller.view

        let targetSize = controller.view.intrinsicContentSize
        view.bounds = CGRect(origin: .zero, size: targetSize)
        view.wantsLayer = true
        view.layer?.backgroundColor = .clear

        guard let renderer = view.bitmapImageRepForCachingDisplay(in: view.bounds) else {
            fatalError("Error creating bitmap image representation")
        }

        let image = NSImage(size: targetSize)
        image.addRepresentation(renderer)
        return image
    }
}
