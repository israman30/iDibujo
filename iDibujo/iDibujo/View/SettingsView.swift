//
//  SettingsView.swift
//  iDibujo
//
//  Created by Israel Manzo on 7/23/19.
//  Copyright © 2019 Israel Manzo. All rights reserved.
//

import UIKit

extension SettingsController {
    
    func setSliders() {
        let stackSliderView = UIStackView(arrangedSubviews: [
            brushLabel,
            changeBrushSizeSlider,
            opacityLabel,
            opacitySlider,
            rgbLabel,
            redLabel,
            redSlider,
            greenLabel,
            greenSlider,
            blueLabel,
            blueSlider
            ])
        stackSliderView.distribution = .fillEqually
        stackSliderView.axis = .vertical
        
        view.addSubview(stackSliderView)
        stackSliderView.anchor(
            top: imageView.bottomAnchor,
            left: view.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            right: view.rightAnchor,
            padding: .init(top: 30, left: 30, bottom: 30, right: 30)
        )
    }
    
    func setSettingsView(){
        
        view.backgroundColor = .white
        
        view.addSubViews(dismissButton,imageView)
        
        dismissButton.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.leftAnchor,
            bottom: nil,
            right: nil,
            padding: .init(top: 10, left: 5, bottom: 0, right: 0),
            size: .init(width: 100, height: 20)
        )
        
        imageView.centerInSuperview(size: .init(width: 150, height: 150))
        imageView.layer.cornerRadius = 150 / 2
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -200).isActive = true
    }
    
}

