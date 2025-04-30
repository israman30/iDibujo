//
//  LineViewModel.swift
//  iDibujo Mac
//
//  Created by Israel Manzo on 4/29/25.
//

import SwiftUI

protocol CanvasProtocol: ObservableObject  {
    var lineWithValue: CGFloat { get set }
    var lines: [Line] { get set }
    var selectedColor: Color { get set }
}

protocol SaveCanvasProtocol {
    func saveCanvas(from view: any View)
}

final class LineViewModel: CanvasProtocol, SaveCanvasProtocol {
    @Published var lineWithValue: CGFloat = 5.0
    @Published var lines = [Line]()
    @Published var colors: [Color] = [.red, .yellow, .blue, .green, .orange, .pink, .black]
    @Published var selectedColor = Color.black
    @Published var deletedLines: [Line] = []
    @Published var isSaved: Bool = false
    
    func saveCanvas(from view: any View) {
        let image = view.snapshot()
        isSaved = true
        if let tiffData = image.tiffRepresentation,
           let bitmap = NSBitmapImageRep(data: tiffData),
           let pngData = bitmap.representation(using: .png, properties: [:]) {
            let url = FileManager.default.temporaryDirectory.appendingPathComponent("savedCanvas.png")
            try? pngData.write(to: url)
        }
    }
}
