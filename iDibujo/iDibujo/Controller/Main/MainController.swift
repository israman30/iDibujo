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
        let btn = CustomButton(titleColor: .white, background: .resetColor, fontSize: 33, imageString: CustomIcon.trash_square)
        return btn
    }()
    
    let importButton: UIButton = {
        let btn = CustomButton(titleColor: .white, background: .importColor, fontSize: 23, imageString: CustomIcon.tray_and_arrow_down)
        return btn
    }()
    
    let eraserButton: UIButton = {
        let btn = CustomButton(titleColor: .white, background: .eraseColor, fontSize: 23, imageString: CustomIcon.reaser)
        return btn
    }()
    
    let moreButton: UIButton = {
        let btn = CustomButton(titleColor: .white, background: .moreColor, fontSize:23, imageString: CustomIcon.scribble_variable)
        return btn
    }()
    
    // MARK: - Bottom bar buttons color selection.
    let redColorButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.colorButton(color: .red, buttonTag: 0)
        return btn
    }()
    
    let greenColorButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.colorButton(color: .green, buttonTag: 1)
        return btn
    }()
    
    let blueColorButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.colorButton(color: .blue, buttonTag: 2)
        return btn
    }()
    
    let pinkColorButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.colorButton(color: .pink, buttonTag: 3)
        return btn
    }()
    
    let yellowColorButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.colorButton(color: .yellow, buttonTag: 4)
        return btn
    }()
    
    let cyanColorButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.colorButton(color: .cyan, buttonTag: 5)
        return btn
    }()
    
    let whiteColorButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.colorButton(color: .white, buttonTag: 6)
        return btn
    }()
    
    let blackColorButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.colorButton(color: .black, buttonTag: 7)
        return btn
    }()
    
    let canvasViewModel = CanvasViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetButton.addTarget(self, action: #selector(reset), for: .touchUpInside)
        importButton.addTarget(self, action: #selector(handleImport), for: .touchUpInside)
        eraserButton.addTarget(self, action: #selector(erase), for: .touchUpInside)
        moreButton.addTarget(self, action: #selector(setting), for: .touchUpInside)
        
        redColorButton.addTarget(self, action: #selector(pickColorHandler), for: .touchUpInside)
        greenColorButton.addTarget(self, action: #selector(pickColorHandler), for: .touchUpInside)
        blueColorButton.addTarget(self, action: #selector(pickColorHandler), for: .touchUpInside)
        pinkColorButton.addTarget(self, action: #selector(pickColorHandler), for: .touchUpInside)
        yellowColorButton.addTarget(self, action: #selector(pickColorHandler), for: .touchUpInside)
        cyanColorButton.addTarget(self, action: #selector(pickColorHandler), for: .touchUpInside)
        whiteColorButton.addTarget(self, action: #selector(pickColorHandler), for: .touchUpInside)
        blackColorButton.addTarget(self, action: #selector(pickColorHandler), for: .touchUpInside)
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






