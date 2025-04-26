//
//  LineViewModel.swift
//  iDibujo
//
//  Created by Israel Manzo on 2/26/25.
//  Copyright © 2025 Israel Manzo. All rights reserved.
//

import SwiftUI

/// `CanvasProtocol` defines the blueprint for storing canvas properties.
protocol CanvasProtocol: ObservableObject {
    var lineWithValue: CGFloat { get set }
    var lines: [Line] { get set }
    var selectedColor: Color { get set }
}

/// `SaveCanvasProtocol` defines the blueprint for saving a canvas snapshot.
protocol SaveCanvasProtocol: ObservableObject {
    func save(from view: any View)
}

final class LineViewModel: CanvasProtocol, SaveCanvasProtocol {
    @Published var lineWithValue: CGFloat = 5.0
    @Published var lines = [Line]()
    @Published var colors: [Color] = [.red, .yellow, .blue, .green, .orange, .pink, .black]
    @Published var selectedColor = Color.black
    @Published var deletedLines: [Line] = []
    
    // MARK: - This function captures and stores the view's context in the local photo library.
    /// - Parameters:
    ///    - view: takes the view for saving it context
    func save(from view: any View) {
        let image = view.snapshot()
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        print("Photo saved on library: \(image.description)")
    }
}
