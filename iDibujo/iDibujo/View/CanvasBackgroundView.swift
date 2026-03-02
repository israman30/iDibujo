//
//  CanvasBackgroundView.swift
//  iDibujo
//
//  Created by Israel Manzo on 3/2/25.
//  Copyright © 2025 Israel Manzo. All rights reserved.
//

import SwiftUI

/// Renders the canvas background based on the selected style.
struct CanvasBackgroundView: View {
    let backgroundType: CanvasBackgroundType
    let customImage: UIImage?
    
    var body: some View {
        Group {
            switch backgroundType {
            case .white:
                Color.white
            case .black:
                Color.black
            case .grid:
                GridBackgroundView()
            case .linedPaper:
                LinedPaperBackgroundView()
            case .customImage:
                if let image = customImage {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } else {
                    Color(red: 0.98, green: 0.98, blue: 1.0)
                }
            }
        }
        .shadow(color: .black.opacity(0.04), radius: 1, x: 0, y: 1)
    }
}

// MARK: - Grid Background
private struct GridBackgroundView: View {
    private let gridSpacing: CGFloat = 20
    private let lineColor = Color.gray.opacity(0.3)
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            
            ZStack {
                Color.white
                
                Canvas { context, size in
                    // Vertical lines
                    var x: CGFloat = 0
                    while x <= width {
                        var path = Path()
                        path.move(to: CGPoint(x: x, y: 0))
                        path.addLine(to: CGPoint(x: x, y: height))
                        context.stroke(path, with: .color(lineColor), lineWidth: 0.5)
                        x += gridSpacing
                    }
                    // Horizontal lines
                    var y: CGFloat = 0
                    while y <= height {
                        var path = Path()
                        path.move(to: CGPoint(x: 0, y: y))
                        path.addLine(to: CGPoint(x: width, y: y))
                        context.stroke(path, with: .color(lineColor), lineWidth: 0.5)
                        y += gridSpacing
                    }
                }
            }
        }
    }
}

// MARK: - Lined Paper Background
private struct LinedPaperBackgroundView: View {
    private let lineSpacing: CGFloat = 28
    private let lineColor = Color.gray.opacity(0.4)
    private let marginColor = Color.red.opacity(0.5)
    private let marginWidth: CGFloat = 40
    
    var body: some View {
        GeometryReader { geometry in
            let height = geometry.size.height
            
            ZStack(alignment: .leading) {
                Color.white
                
                Canvas { context, size in
                    // Horizontal ruled lines
                    var y: CGFloat = lineSpacing
                    while y < height {
                        var path = Path()
                        path.move(to: CGPoint(x: marginWidth, y: y))
                        path.addLine(to: CGPoint(x: size.width, y: y))
                        context.stroke(path, with: .color(lineColor), lineWidth: 0.5)
                        y += lineSpacing
                    }
                    // Left margin (red vertical line)
                    var marginPath = Path()
                    marginPath.move(to: CGPoint(x: marginWidth, y: 0))
                    marginPath.addLine(to: CGPoint(x: marginWidth, y: height))
                    context.stroke(marginPath, with: .color(marginColor), lineWidth: 1)
                }
            }
        }
    }
}

#Preview("Backgrounds") {
    VStack(spacing: 20) {
        HStack(spacing: 16) {
            CanvasBackgroundView(backgroundType: .white, customImage: nil)
                .frame(width: 80, height: 80)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            CanvasBackgroundView(backgroundType: .black, customImage: nil)
                .frame(width: 80, height: 80)
                .clipShape(RoundedRectangle(cornerRadius: 8))
        }
        HStack(spacing: 16) {
            CanvasBackgroundView(backgroundType: .grid, customImage: nil)
                .frame(width: 80, height: 80)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            CanvasBackgroundView(backgroundType: .linedPaper, customImage: nil)
                .frame(width: 80, height: 80)
                .clipShape(RoundedRectangle(cornerRadius: 8))
        }
    }
    .padding()
}
