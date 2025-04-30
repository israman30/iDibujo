//
//  LineViewModel.swift
//  iDibujo Mac
//
//  Created by Israel Manzo on 4/29/25.
//

import SwiftUI

protocol CanvasProtocol {
    var lineWidth: CGFloat { get set }
    var lines: [Line] { get set }
    var selectedColor: Color { get set }
}

protocol SaveCanvasProtocol {
    func saveCanvas(from view: any View)
}
