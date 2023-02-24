//
//  Draw.swift
//  iDibujo
//
//  Created by Israel Manzo on 2/24/23.
//  Copyright © 2023 Israel Manzo. All rights reserved.
//

import UIKit

struct Draw {
    var red: CGFloat = 0.0
    var green: CGFloat = 0.0
    var blue: CGFloat = 0.0
    var opacity: CGFloat = 1.0
    var brushSize: CGFloat = 9.0
    var lastPoint: CGPoint = .zero
    var swipe = false
    var isDrawing = true
    
    let container = UIImageView()
}
