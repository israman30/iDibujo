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
