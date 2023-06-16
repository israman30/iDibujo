//
//  PreviewView.swift
//  iDibujo
//
//  Created by Israel Manzo on 6/14/23.
//  Copyright © 2023 Israel Manzo. All rights reserved.
//

import Foundation
import SwiftUI

struct UIViewControllerPreview<ViewController: UIViewController>: UIViewControllerRepresentable {
    
    let viewController: ViewController
    
    init(with builder: @escaping() -> ViewController) {
        viewController = builder()
    }
    
    func makeUIViewController(context: Context) -> ViewController {
        viewController
    }
    
    func updateUIViewController(_ uiViewController: ViewController, context: Context) {
        
    }
}

struct UIViewPreview<View: UIView>: UIViewRepresentable {
    
    let view: View
    
    init(with builder: @escaping() -> View) {
        self.view = builder()
    }
    
    func makeUIView(context: Context) -> UIView {
        view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        view.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
}
