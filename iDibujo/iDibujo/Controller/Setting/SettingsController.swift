//
//  SettingsController.swift
//  iDibujo
//
//  Created by Israel Manzo on 7/23/19.
//  Copyright © 2019 Israel Manzo. All rights reserved.
//

import UIKit

class SettingsController: UIViewController {
    
    var red: CGFloat = 0.0
    var blue: CGFloat = 0.0
    var green: CGFloat = 0.0
    
    var brushSize1: CGFloat = 5.0
    
    var opacity: CGFloat = 1.0
    
    var delegate: SettingsDelagate?
    
    let dismissButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("APPLY", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 20)
        btn.addTarget(self, action: #selector(back), for: .touchUpInside)
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
        label.text = "Brush Size"
        label.font = .boldSystemFont(ofSize: 15)
        return label
    }()
    
    let opacityLabel: UILabel = {
        let label = UILabel()
        label.text = "Opacity"
        label.font = .boldSystemFont(ofSize: 15)
        return label
    }()
    
    let rgbLabel: UILabel = {
        let label = UILabel()
        label.text = "RGB Colors"
        label.textAlignment = .center
        label.textColor = .lightGray
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    let redLabel: UILabel = {
        let label = UILabel()
        label.text = "Red Label"
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    let greenLabel: UILabel = {
        let label = UILabel()
        label.text = "Green Label"
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    let blueLabel: UILabel = {
        let label = UILabel()
        label.text = "Blue Label"
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    // MARK: - SLIDERS BLOCK
    let changeBrushSizeSlider: UISlider = {
        let slider = UISlider()
        slider.value = 10
        slider.minimumValue = 1
        slider.maximumValue = 90
        slider.addTarget(self, action: #selector(handleChangeBrushSize), for: .valueChanged)
        return slider
    }()
    
    let opacitySlider: UISlider = {
        let slider = UISlider()
        slider.addTarget(self, action: #selector(handleChangeOpacitySize), for: .valueChanged)
        return slider
    }()
    
    let redSlider: UISlider = {
        let slider = UISlider()
        slider.minimumTrackTintColor = .red
        slider.thumbTintColor = .red
        slider.addTarget(self, action: #selector(handleRedColor), for: .valueChanged)
        return slider
    }()
    
    let greenSlider: UISlider = {
        let slider = UISlider()
        slider.minimumTrackTintColor = .green
        slider.thumbTintColor = .green
        slider.addTarget(self, action: #selector(handleGreenColor), for: .valueChanged)
        return slider
    }()
    
    let blueSlider: UISlider = {
        let slider = UISlider()
        slider.minimumTrackTintColor = .blue
        slider.thumbTintColor = .blue
        slider.addTarget(self, action: #selector(handleBlueColor), for: .valueChanged)
        return slider
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        previewDraw(red: red, green: green, blue: blue)
        
        redSlider.value = Float(red)
        redLabel.text = String(Int(redSlider.value * 255))
        
        greenSlider.value = Float(green)
        greenLabel.text = String(Int(greenSlider.value * 255))
        
        blueSlider.value = Float(blue)
        blueLabel.text = String(Int(blueSlider.value * 255))
        
        setSettingsView()
        setSliders()
    }
    
    
}


