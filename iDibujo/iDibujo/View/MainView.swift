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
        view.addSubview(canvasViewModel.draw.container)
        canvasViewModel.draw.container.fillSuperview()
        canvasViewModel.draw.container.isUserInteractionEnabled = true
        
        let buttonContainerView = UIStackView(arrangedSubviews: [
            resetButton, importButton, eraserButton, moreButton
            ])
        buttonContainerView.distribution = .fillEqually
        buttonContainerView.axis = .horizontal
        buttonContainerView.spacing = 5
        
        resetButton.layer.cornerRadius = 5
        resetButton.accessibilityHint = NSLocalizedString("Reset_for_canvas", comment: "Reset for canvas")
        
        importButton.layer.cornerRadius = 5
        importButton.accessibilityHint = NSLocalizedString("Import_from_library_photo", comment: "Import from library photo")
        
        eraserButton.layer.cornerRadius = 5
        if !canvasViewModel.draw.isDrawing {
            eraserButton.accessibilityHint = NSLocalizedString("Draw_canvas", comment: "Draw in canvas")
        } else {
            eraserButton.accessibilityHint = NSLocalizedString("Erase_canvas", comment: "Erase canvas")
        }
        
        moreButton.layer.cornerRadius = 5
        moreButton.accessibilityHint = NSLocalizedString("More_settings", comment: "More settings")
        
        canvasViewModel.draw.container.addSubview(buttonContainerView)
        buttonContainerView.anchor(
            top: canvasViewModel.draw.container.safeAreaLayoutGuide.topAnchor,
            left: canvasViewModel.draw.container.leftAnchor,
            bottom: nil,
            right: canvasViewModel.draw.container.rightAnchor,
            padding: .init(top: 5, left: 20, bottom: 0, right: 20),
            size: .init(width: 0, height: 45)
        )
        setColorButtons()
        
    }
    
    // MARK: - SET BUTTONS CONTAINER
    func setColorButtons() {
        
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
        stackView.spacing = 2
        
        redColorButton.layer.borderColor = UIColor.black.cgColor
        redColorButton.layer.borderWidth = 2
        redColorButton.layer.cornerRadius = 8
        redColorButton.accessibilityLabel = NSLocalizedString("RED_COLOR", comment: "RED COLOR") 
        
        greenColorButton.layer.borderColor = UIColor.black.cgColor
        greenColorButton.layer.borderWidth = 2
        greenColorButton.layer.cornerRadius = 8
        greenColorButton.accessibilityLabel = NSLocalizedString("GREEN_COLOR", comment: "GREEN COLOR") 
        
        blueColorButton.layer.borderColor = UIColor.black.cgColor
        blueColorButton.layer.borderWidth = 2
        blueColorButton.layer.cornerRadius = 8
        blueColorButton.accessibilityLabel = NSLocalizedString("BLUE_COLOR", comment: "BLUE COLOR") 
        
        pinkColorButton.layer.borderColor = UIColor.black.cgColor
        pinkColorButton.layer.borderWidth = 2
        pinkColorButton.layer.cornerRadius = 8
        pinkColorButton.accessibilityLabel = NSLocalizedString("PINK_COLOR", comment: "PINK COLOR") 
        
        yellowColorButton.layer.borderColor = UIColor.black.cgColor
        yellowColorButton.layer.borderWidth = 2
        yellowColorButton.layer.cornerRadius = 8
        yellowColorButton.accessibilityLabel = NSLocalizedString("YELLOW_COLOR", comment: "YELLOW COLOR") 
        
        cyanColorButton.layer.borderColor = UIColor.black.cgColor
        cyanColorButton.layer.borderWidth = 2
        cyanColorButton.layer.cornerRadius = 10
        cyanColorButton.accessibilityLabel = NSLocalizedString("CYAN_COLOR", comment: "CYAN COLOR") 
        
        whiteColorButton.layer.borderColor = UIColor.black.cgColor
        whiteColorButton.layer.borderWidth = 2
        whiteColorButton.layer.cornerRadius = 8
        whiteColorButton.accessibilityLabel = NSLocalizedString("WHITE_COLOR", comment: "WHITE COLOR") 
        
        blackColorButton.layer.borderColor = UIColor.black.cgColor
        blackColorButton.layer.borderWidth = 2
        blackColorButton.layer.cornerRadius = 8
        blackColorButton.accessibilityLabel = NSLocalizedString("BLACK_COLOR", comment: "BLACK COLOR") 
        
        canvasViewModel.draw.container.addSubview(stackView)
        stackView.anchor(
            top: nil,
            left: canvasViewModel.draw.container.leftAnchor,
            bottom: canvasViewModel.draw.container.bottomAnchor,
            right: canvasViewModel.draw.container.rightAnchor,
            padding: .init(top: 0, left: 20, bottom: 20, right: 20),
            size: .init(width: 0, height: 44)
        )
    }
}

