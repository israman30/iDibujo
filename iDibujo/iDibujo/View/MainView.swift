//
//  MainView.swift
//  iDibujo
//
//  Created by Israel Manzo on 7/23/19.
//  Copyright © 2019 Israel Manzo. All rights reserved.
//

import UIKit

extension ViewController {
    
    func setContainerView(){
        view.addSubview(container)
        container.fillSuperview()
        container.isUserInteractionEnabled = true
        
        let buttonContainerView = UIStackView(arrangedSubviews: [
            resetButton, importButton, eraserButton, moreButton
            ])
        buttonContainerView.distribution = .fillEqually
        buttonContainerView.axis = .horizontal
        buttonContainerView.spacing = 10
        
        resetButton.layer.cornerRadius = 2
        importButton.layer.cornerRadius = 2
        eraserButton.layer.cornerRadius = 2
        moreButton.layer.cornerRadius = 2
        
        container.addSubview(buttonContainerView)
        buttonContainerView.anchor(top: container.safeAreaLayoutGuide.topAnchor, left: container.leftAnchor, bottom: nil, right: container.rightAnchor, padding: .init(top: 5, left: 20, bottom: 0, right: 20), size: .init(width: 0, height: 40))
        setColorButtons()
        
    }
    
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
        
        redColorButton.layer.borderColor = UIColor.gray.cgColor
        redColorButton.layer.borderWidth = 1
        
        greenColorButton.layer.borderColor = UIColor.gray.cgColor
        greenColorButton.layer.borderWidth = 1
        
        blueColorButton.layer.borderColor = UIColor.gray.cgColor
        blueColorButton.layer.borderWidth = 1
        
        pinkColorButton.layer.borderColor = UIColor.gray.cgColor
        pinkColorButton.layer.borderWidth = 1
        
        yellowColorButton.layer.borderColor = UIColor.gray.cgColor
        yellowColorButton.layer.borderWidth = 1
        
        cyanColorButton.layer.borderColor = UIColor.gray.cgColor
        cyanColorButton.layer.borderWidth = 1
        
        whiteColorButton.layer.borderColor = UIColor.gray.cgColor
        whiteColorButton.layer.borderWidth = 1
        
        blackColorButton.layer.borderColor = UIColor.gray.cgColor
        blackColorButton.layer.borderWidth = 1
        
        container.addSubview(stackView)
        stackView.anchor(
            top: nil,
            left: container.leftAnchor,
            bottom: container.bottomAnchor,
            right: container.rightAnchor,
            padding: .init(top: 0, left: 20, bottom: 20, right: 20),
            size: .init(width: 0, height: 40)
        )
    }
}

