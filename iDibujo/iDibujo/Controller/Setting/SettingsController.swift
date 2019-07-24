//
//  SettingsController.swift
//  iDibujo
//
//  Created by Israel Manzo on 7/23/19.
//  Copyright © 2019 Israel Manzo. All rights reserved.
//

import UIKit

protocol SettingsDelagate {
    func settingsDidFinish(_ settings: SettingsController )
}

class SettingsController: UIViewController {
    
    var red: CGFloat = 0.0
    var blue: CGFloat = 0.0
    var green: CGFloat = 0.0
    
    var brushSize1: CGFloat = 5.0
    
    var opacity: CGFloat = 1.0
    
    var delegate: SettingsDelagate?
    
    let dismissButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("BACK", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(back), for: .touchUpInside)
        return btn
    }()
    
    let imageView: UIImageView = {
        let brush = UIImageView()
        brush.isUserInteractionEnabled = true
        brush.autoresizesSubviews = true
        return brush
    }()
    
    @objc func back(){
        if delegate != nil {
            delegate?.settingsDidFinish(self)
        }
        dismiss(animated: true, completion: nil)
    }
    
    let brushLabel: UILabel = {
        let label = UILabel()
        label.text = "Brush Size"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    let opacityLabel: UILabel = {
        let label = UILabel()
        label.text = "Opacity"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    let rgbLabel: UILabel = {
        let label = UILabel()
        label.text = "RGB Colors"
        label.textAlignment = .center
        label.textColor = .lightGray
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    let redLabel: UILabel = {
        let label = UILabel()
        label.text = "Red Label"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    let greenLabel: UILabel = {
        let label = UILabel()
        label.text = "Green Label"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    let blueLabel: UILabel = {
        let label = UILabel()
        label.text = "Blue Label"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    // SLIDERS
    
    let changeBrushSizeSlider: UISlider = {
        let slider = UISlider()
        slider.value = 10
        slider.minimumValue = 1
        slider.maximumValue = 90
        slider.addTarget(self, action: #selector(handleChangeBrushSize), for: .valueChanged)
        return slider
    }()
    
    @objc func handleChangeBrushSize(_ sender: Any){
        let slider = sender as! UISlider
        brushSize1 = CGFloat(slider.value)
        previewDraw(red: red, green: green, blue: blue)
    }
    
    let opacitySlider: UISlider = {
        let slider = UISlider()
        slider.addTarget(self, action: #selector(handleChangeOpacitySize), for: .valueChanged)
        return slider
    }()
    
    @objc func handleChangeOpacitySize(_ sender: Any) {
        let slider = sender as! UISlider
        opacity = CGFloat(slider.value)
        previewDraw(red: red, green: green, blue: blue)
    }
    
    let redSlider: UISlider = {
        let slider = UISlider()
        slider.minimumTrackTintColor = .red
        slider.thumbTintColor = .red
        slider.addTarget(self, action: #selector(handleRedColor), for: .valueChanged)
        return slider
    }()
    
    @objc func handleRedColor(_ sender: Any){
        let slider = sender as! UISlider
        red = CGFloat(slider.value)
        previewDraw(red: red, green: green, blue: blue)
        redLabel.text = "\(Int(slider.value * 255))"
    }
    
    let greenSlider: UISlider = {
        let slider = UISlider()
        slider.minimumTrackTintColor = .green
        slider.thumbTintColor = .green
        slider.addTarget(self, action: #selector(handleGreenColor), for: .valueChanged)
        return slider
    }()
    
    @objc func handleGreenColor(_ sender: Any) {
        let slider = sender as! UISlider
        green = CGFloat(slider.value)
        previewDraw(red: red, green: green, blue: blue)
        greenLabel.text = "\(Int(slider.value * 255))"
    }
    
    let blueSlider: UISlider = {
        let slider = UISlider()
        slider.minimumTrackTintColor = .blue
        slider.thumbTintColor = .blue
        slider.addTarget(self, action: #selector(handleBlueColor), for: .valueChanged)
        return slider
    }()
    
    @objc func handleBlueColor(_ sender: Any) {
        let slider = sender as! UISlider
        blue = CGFloat(slider.value)
        previewDraw(red: red, green: green, blue: blue)
        blueLabel.text = "\(Int(slider.value * 255))"
    }
    
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
    
    // MARK: Preview drawing function
    func previewDraw(red: CGFloat, green: CGFloat, blue: CGFloat){
        UIGraphicsBeginImageContext(imageView.frame.size)
        
        let context = UIGraphicsGetCurrentContext()
        context?.setStrokeColor(UIColor(red: red, green: green, blue: blue, alpha: opacity).cgColor)
        context?.setLineWidth(brushSize1)
        context?.setLineCap(CGLineCap.round)
        context?.move(to: CGPoint(x: 70, y: 70))
        context?.addLine(to: CGPoint(x: 70, y: 70))
        context?.strokePath()
        
        imageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
}

