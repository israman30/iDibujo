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
        let targetSize = controller.view.intrinsicContentSize
        let view = controller.view
        let contentRect = NSRect(origin: .zero, size: targetSize)
        
        let window = NSWindow(
            contentRect: contentRect,
            styleMask: [.titled, .closable, .miniaturizable, .resizable],
            backing: .buffered, defer: false
        )
        window.center()
        window.contentView?.addSubview(view)

        if let bitmapRep = view.bitmapImageRepForCachingDisplay(in: contentRect) {
            view.cacheDisplay(in: contentRect, to: bitmapRep)
            let image = NSImage(size: bitmapRep.size)
            image.addRepresentation(bitmapRep)
            return image
        }
        return NSImage()
    }
}

extension View {
    @ViewBuilder
    func `if`(_ condition: Bool) -> some View {
        if condition {
            self.foregroundStyle(Color(.lightGray))
        } else {
            self.foregroundStyle(.black)
        }
    }
}
