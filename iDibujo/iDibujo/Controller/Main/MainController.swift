//
//  MainController.swift
//  iDibujo
//
//  Created by Israel Manzo on 7/23/19.
//  Copyright © 2019 Israel Manzo. All rights reserved.
//

import UIKit

class MainController: UIViewController {
    
    let resetButton: UIButton = {
        let btn = CustomButton(for: "RESET", titleColor: .white, background: .resetColor, fontSize: 23)
        btn.addTarget(self, action: #selector(reset), for: .touchUpInside)
        return btn
    }()
    
    let importButton: UIButton = {
        let btn = CustomButton(for: "SAVE", titleColor: .white, background: .importColor, fontSize: 23)
        btn.addTarget(self, action: #selector(handleImport), for: .touchUpInside)
        return btn
    }()
    
    let eraserButton: UIButton = {
        let btn = CustomButton(for: "DELT", titleColor: .white, background: .eraseColor, fontSize: 23)
        btn.addTarget(self, action: #selector(erase), for: .touchUpInside)
        return btn
    }()
    
    let moreButton: UIButton = {
        let btn = CustomButton(for: "MORE", titleColor: .white, background: .moreColor, fontSize:23)
        btn.addTarget(self, action: #selector(setting), for: .touchUpInside)
        return btn
    }()
    
    // MARK: - Bottom bar buttons color selection.
    let redColorButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.colorButton(color: .red, buttonTag: 0)
        btn.addTarget(self, action: #selector(pickColorHandler), for: .touchUpInside)
        
        return btn
    }()
    
    let greenColorButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.colorButton(color: .green, buttonTag: 1)
        btn.addTarget(self, action: #selector(pickColorHandler), for: .touchUpInside)
        return btn
    }()
    
    let blueColorButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.colorButton(color: .blue, buttonTag: 2)
        btn.addTarget(self, action: #selector(pickColorHandler), for: .touchUpInside)
        return btn
    }()
    
    let pinkColorButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.colorButton(color: .pink, buttonTag: 3)
        btn.addTarget(self, action: #selector(pickColorHandler), for: .touchUpInside)
        return btn
    }()
    
    let yellowColorButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.colorButton(color: .yellow, buttonTag: 4)
        btn.addTarget(self, action: #selector(pickColorHandler), for: .touchUpInside)
        return btn
    }()
    
    let cyanColorButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.colorButton(color: .cyan, buttonTag: 5)
        btn.addTarget(self, action: #selector(pickColorHandler), for: .touchUpInside)
        return btn
    }()
    
    let whiteColorButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.colorButton(color: .white, buttonTag: 6)
        btn.addTarget(self, action: #selector(pickColorHandler), for: .touchUpInside)
        return btn
    }()
    
    let blackColorButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.colorButton(color: .black, buttonTag: 7)
        btn.addTarget(self, action: #selector(pickColorHandler), for: .touchUpInside)
        return btn
    }()
    
    let canvasViewModel = CanvasViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setContainerView()
    }
    
}

import SwiftUI

@available(iOS 13.0.0, *)
struct MainPreview: PreviewProvider {
    
    static var previews: some View {
        ContainerView()
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<MainPreview.ContainerView>) -> UIViewController {
            return MainController()
        }
        
        func updateUIViewController(_ uiViewController: MainPreview.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<MainPreview.ContainerView>) {
            // NOTHING HERE
        }
    }
}






