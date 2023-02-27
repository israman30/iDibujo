//
//  SettingsView.swift
//  iDibujo
//
//  Created by Israel Manzo on 7/23/19.
//  Copyright © 2019 Israel Manzo. All rights reserved.
//

import UIKit

extension SettingsController {
    
    // MARK: - SETTING SLIDER FOR SETTINGS CONTROLLER
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
            padding: .init(top: 10, left: 30, bottom: 20, right: 30)
        )
    }
    
    // MARK: - SETTINGS VIEW FOR SETTING CONTROLLER
    func setSettingsView() {
        
        view.backgroundColor = .white
        
        view.addSubViews(dismissButton, imageView)
        
        dismissButton.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.leftAnchor,
            bottom: nil,
            right: nil,
            padding: .init(top: 10, left: 5, bottom: 0, right: 0),
            size: .init(width: 180, height: 44)
        )
        dismissButton.backgroundColor = .yellow
        dismissButton.shadow()
        dismissButton.accessibilityHint = NSLocalizedString("Apply_changes", comment: "Apply changes")
        
        imageView.centerInSuperview(size: .init(width: 150, height: 150))
        imageView.layer.cornerRadius = 150 / 2
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -200).isActive = true
    }
    
}

