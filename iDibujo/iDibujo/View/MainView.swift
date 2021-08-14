//
//  MainView.swift
//  iDibujo
//
//  Created by Israel Manzo on 7/23/19.
//  Copyright © 2019 Israel Manzo. All rights reserved.
//

import UIKit

extension MainController {
    
    // MARK: - SET MAIN PARENT VIEW FOR MAIN CONTROLLER WITH COLOR PICKER + BUTTONS CONTAINER
    func setContainerView() {
        
        view.backgroundColor = .white
        view.addSubview(canvasViewModel.container)
        canvasViewModel.container.fillSuperview()
        canvasViewModel.container.isUserInteractionEnabled = true
        
        let buttonContainerView = UIStackView(arrangedSubviews: [
            resetButton, importButton, eraserButton, moreButton
            ])
        buttonContainerView.distribution = .fillEqually
        buttonContainerView.axis = .horizontal
        buttonContainerView.spacing = 10
        
        resetButton.layer.cornerRadius = 5
        importButton.layer.cornerRadius = 5
        eraserButton.layer.cornerRadius = 5
        moreButton.layer.cornerRadius = 5
        
        canvasViewModel.container.addSubview(buttonContainerView)
        buttonContainerView.anchor(
            top: canvasViewModel.container.safeAreaLayoutGuide.topAnchor,
            left: canvasViewModel.container.leftAnchor,
            bottom: nil,
            right: canvasViewModel.container.rightAnchor,
            padding: .init(top: 5, left: 20, bottom: 0, right: 20),
            size: .init(width: 0, height: 40)
        )
        setColorButtons()
        
    }
    
    // MARK: - SET BUTTONS CONTAINER
    func setColorButtons(){
        
        let stackView = UIStackView(arrangedSubviews: [
            redColorButton,
            greenColorButton,
            blueColorButton,
            pinkColorButton,
            yellowColorButton,
            cyanColorButton,
            whiteColorButton,
            blackColorButton
            ])
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        
        redColorButton.layer.borderColor = UIColor.black.cgColor
        redColorButton.layer.borderWidth = 2
        redColorButton.layer.cornerRadius = 8
        
        greenColorButton.layer.borderColor = UIColor.black.cgColor
        greenColorButton.layer.borderWidth = 2
        greenColorButton.layer.cornerRadius = 8
        
        blueColorButton.layer.borderColor = UIColor.black.cgColor
        blueColorButton.layer.borderWidth = 2
        blueColorButton.layer.cornerRadius = 8
        
        pinkColorButton.layer.borderColor = UIColor.black.cgColor
        pinkColorButton.layer.borderWidth = 2
        pinkColorButton.layer.cornerRadius = 8
        
        yellowColorButton.layer.borderColor = UIColor.black.cgColor
        yellowColorButton.layer.borderWidth = 2
        yellowColorButton.layer.cornerRadius = 8
        
        cyanColorButton.layer.borderColor = UIColor.black.cgColor
        cyanColorButton.layer.borderWidth = 2
        cyanColorButton.layer.cornerRadius = 10
        
        whiteColorButton.layer.borderColor = UIColor.black.cgColor
        whiteColorButton.layer.borderWidth = 2
        whiteColorButton.layer.cornerRadius = 8
        
        blackColorButton.layer.borderColor = UIColor.black.cgColor
        blackColorButton.layer.borderWidth = 2
        blackColorButton.layer.cornerRadius = 8
        
        canvasViewModel.container.addSubview(stackView)
        stackView.anchor(
            top: nil,
            left: canvasViewModel.container.leftAnchor,
            bottom: canvasViewModel.container.bottomAnchor,
            right: canvasViewModel.container.rightAnchor,
            padding: .init(top: 0, left: 20, bottom: 20, right: 20),
            size: .init(width: 0, height: 45)
        )
    }
}

