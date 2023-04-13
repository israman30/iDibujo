//
//  SettingsController.swift
//  iDibujo
//
//  Created by Israel Manzo on 7/23/19.
//  Copyright © 2019 Israel Manzo. All rights reserved.
//

import UIKit

class SettingsController: UIViewController {
    
    var settingsViewModel = SettingsViewModel()
    
    var delegate: SettingsProtocol?
    
    let dismissButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle(NSLocalizedString("APPLY", comment: "APPLY"), for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 20)
        return btn
    }()
    
    let imageView: UIImageView = {
        let brush = UIImageView()
        brush.isUserInteractionEnabled = true
        brush.autoresizesSubviews = true
        return brush
    }()
    
    let brushLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("Brush_Size", comment: "Brush Size")
        label.font = .preferredFont(forTextStyle: .title2)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    let opacityLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("Opacity", comment: "Opacity")
        label.font = .preferredFont(forTextStyle: .title2)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    let rgbLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("RGB_Colors", comment: "RGB Colors")
        label.textAlignment = .center
        label.textColor = .init(red: 141/255, green: 141/255, blue: 145/255, alpha: 1)
        label.font = .preferredFont(forTextStyle: .title1)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    let redLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("Red_Label", comment: "Red Label")
        label.font = .preferredFont(forTextStyle: .title2)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    let greenLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("Green_Label", comment: "Green Label")
        label.font = .preferredFont(forTextStyle: .title2)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    let blueLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("Blue_Label", comment: "Blue Label")
        label.font = .preferredFont(forTextStyle: .title2)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    // MARK: - SLIDERS BLOCK
    let changeBrushSizeSlider: CustomSlider = {
        let slider = CustomSlider(firstColor: CustomColor.blackPrimary, secondColor: CustomColor.blackSecondary)
        slider.value = 10
        slider.minimumValue = 1
        slider.maximumValue = 90
        slider.customBackgorundShapeSlider()
        return slider
    }()
    
    let opacitySlider: CustomSlider = {
        let slider = CustomSlider(firstColor: .clear, secondColor: .clear)
        slider.setValue(1, animated: true)
        slider.customBackgorundShapeSlider()
        return slider
    }()
    
    let redSlider: CustomSlider = {
        let slider = CustomSlider(firstColor: CustomColor.redPrimary, secondColor: CustomColor.redSecondary)
        slider.minimumTrackTintColor = CustomColor.redPrimary
        slider.thumbTintColor = CustomColor.redPrimary
        slider.customBackgorundShapeSlider()
        return slider
    }()
    
    let greenSlider: CustomSlider = {
        let slider = CustomSlider(firstColor: CustomColor.greenPrimary, secondColor: CustomColor.greenSecondary)
        slider.minimumTrackTintColor = .green
        slider.thumbTintColor = .green
        slider.customBackgorundShapeSlider()
        return slider
    }()
    
    let blueSlider: CustomSlider = {
        let slider = CustomSlider(firstColor: CustomColor.bluePrimary, secondColor: CustomColor.blueSecondary)
        slider.minimumTrackTintColor = .blue
        slider.thumbTintColor = .blue
        slider.customBackgorundShapeSlider()
        return slider
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        blueSlider.addTarget(self, action: #selector(handleBlueColor), for: .valueChanged)
        greenSlider.addTarget(self, action: #selector(handleGreenColor), for: .valueChanged)
        redSlider.addTarget(self, action: #selector(handleRedColor), for: .valueChanged)
        opacitySlider.addTarget(self, action: #selector(handleChangeOpacitySize), for: .valueChanged)
        changeBrushSizeSlider.addTarget(self, action: #selector(handleChangeBrushSize), for: .valueChanged)
        dismissButton.addTarget(self, action: #selector(back), for: .touchUpInside)
        
        previewDraw(red: settingsViewModel.draw.red, green: settingsViewModel.draw.green, blue: settingsViewModel.draw.blue)
        
        redSlider.value = Float(settingsViewModel.draw.red)
        redLabel.text = String(Int(redSlider.value * 255))
        
        greenSlider.value = Float(settingsViewModel.draw.green)
        greenLabel.text = String(Int(greenSlider.value * 255))
        
        blueSlider.value = Float(settingsViewModel.draw.blue)
        blueLabel.text = String(Int(blueSlider.value * 255))
        
        changeBrushSizeSlider.value = 10
        
        setSettingsView()
        setSliders()
    }
    
    
}


