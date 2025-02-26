//
//  LineViewModel.swift
//  iDibujo
//
//  Created by Israel Manzo on 2/26/25.
//  Copyright © 2025 Israel Manzo. All rights reserved.
//

import SwiftUI

final class LineViewModel: ObservableObject {
    @Published var lineWithValue: CGFloat = 5.0
    @Published var lines = [Line]()
    @Published var colors: [Color] = [.red, .yellow, .blue, .green, .orange, .pink, .black]
    @Published var selectedColor = Color.black
    
    // MARK: - This function captures and stores the view's context in the local photo library.
    /// - Parameters:
    ///    - view: takes the view for saving it context
    func save(from view: any View) {
        let image = view.snapshot()
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        print("Photo saved on library: \(image.description)")
    }
}
