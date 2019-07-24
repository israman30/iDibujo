//
//  ViewController.swift
//  iDibujo
//
//  Created by Israel Manzo on 7/23/19.
//  Copyright © 2019 Israel Manzo. All rights reserved.
//

import UIKit

extension UIButton {
    func colorButton(color: UIColor, buttonTag: Int){
        backgroundColor = color
        tag = buttonTag
    }
}


extension UIColor {
    // Method returns a custom color
    static var pink = UIColor(red: 255/255, green: 105/255, blue: 180, alpha: 1)
}

class ViewController: UIViewController {
    
    let container = UIImageView()
    
    var red: CGFloat = 0.0
    var green: CGFloat = 0.0
    var blue: CGFloat = 0.0
    
    var lastPoint = CGPoint.zero
    var swipe = false
    
    var brushSize: CGFloat = 9.0
    
    var opacity: CGFloat = 1.0
    
    var tool:UIImageView!
    var isDrawing = true
    
    var selectedImage: UIImage!
    
    let resetButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("reset", for: .normal)
        btn.addTarget(self, action: #selector(reset), for: .touchUpInside)
        return btn
    }()
    
    @objc func reset() {
        container.image = nil
    }
    
    let importButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("import", for: .normal)
        btn.addTarget(self, action: #selector(handleImport), for: .touchUpInside)
        return btn
    }()
    
    @objc func handleImport(){
        print(123)
        let actionSheet = UIAlertController(title: "Hello", message: "What are you going to do?", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Pick an image 🌅", style: .default, handler: { (UIAlertAction) in
            
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false
//            imagePicker.delegate = self
            
            self.present(imagePicker, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Save your Art 🎨", style: .default, handler: { (UIAlertAction) in
            
//            if let image = self.imagePhoto.image {
//                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
//            }
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel ❌", style: .default, handler: nil))
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    let eraserButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("eraser", for: .normal)
        let icon = #imageLiteral(resourceName: "eraser")
        btn.setBackgroundImage(icon, for: .normal)
        btn.addTarget(self, action: #selector(erase), for: .touchUpInside)
        return btn
    }()
    
    @objc func erase(){
        print(123)
        if isDrawing {
            (red, green, blue) = (1, 1, 1)
        } else {
            (red, green, blue) = (0, 0, 0)
        }
        isDrawing = !isDrawing
    }
    
    let moreButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("more", for: .normal)
        btn.addTarget(self, action: #selector(setting), for: .touchUpInside)
        return btn
    }()
    
    @objc func setting(){
        let settingsController = SettingsController()
        present(settingsController, animated: true, completion: nil)
    }
    
    let redColorButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.colorButton(color: .red, buttonTag: 0)
        btn.addTarget(self, action: #selector(handleDraw), for: .touchUpInside)
        return btn
    }()
    
    let greenColorButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.colorButton(color: .green, buttonTag: 1)
        btn.addTarget(self, action: #selector(handleDraw), for: .touchUpInside)
        return btn
    }()
    
    let blueColorButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.colorButton(color: .blue, buttonTag: 2)
        btn.addTarget(self, action: #selector(handleDraw), for: .touchUpInside)
        return btn
    }()
    
    let pinkColorButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.colorButton(color: .pink, buttonTag: 3)
        btn.addTarget(self, action: #selector(handleDraw), for: .touchUpInside)
        return btn
    }()
    
    let yellowColorButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.colorButton(color: .yellow, buttonTag: 4)
        btn.addTarget(self, action: #selector(handleDraw), for: .touchUpInside)
        return btn
    }()
    
    let cyanColorButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.colorButton(color: .cyan, buttonTag: 5)
        btn.addTarget(self, action: #selector(handleDraw), for: .touchUpInside)
        return btn
    }()
    
    let whiteColorButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.colorButton(color: .white, buttonTag: 6)
        btn.addTarget(self, action: #selector(handleDraw), for: .touchUpInside)
        return btn
    }()
    
    let blackColorButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.colorButton(color: .black, buttonTag: 7)
        btn.addTarget(self, action: #selector(handleDraw), for: .touchUpInside)
        return btn
    }()
    
    @objc func foo(){
        print("foo")
    }
    
    @objc func handleDraw(_ sender: Any){
        if (sender as AnyObject).tag == 0 {
            (red, green, blue) = (1, 0, 0)
            print("red")
        } else if (sender as AnyObject).tag == 1 {
            (red, green, blue) = (0, 1, 0)
            print("green")
        } else if (sender as AnyObject).tag == 2 {
            (red, green, blue) = (0, 0, 1)
            print("blue")
        } else if (sender as AnyObject).tag == 3 {
            (red, green, blue) = (1, 0, 1)
            print("yellow")
        } else if  (sender as AnyObject).tag == 4 {
            (red, green, blue) = (1, 1, 0)
        } else if (sender as AnyObject).tag == 5 {
            (red, green, blue) = (0, 1, 1)
        } else if (sender as AnyObject).tag == 6 {
            (red, green, blue) = (1, 1, 1)
        } else if (sender as AnyObject).tag == 7 {
            (red, green, blue) = (0, 0, 0)
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        swipe = false
        if let touch = touches.first {
            lastPoint = touch.location(in: self.view)
        }
    }
    
    //MARK: Drawing a line function
    func drawnLine(from: CGPoint, to: CGPoint){
        UIGraphicsBeginImageContext(self.view.frame.size)
        container.image?.draw(in: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        
        let context = UIGraphicsGetCurrentContext()
        context?.move(to: CGPoint(x: from.x, y: from.y))
        context?.addLine(to: CGPoint(x: to.x, y: to.y))
        // Brush image
//        tool.center = to
        
        context?.setBlendMode(.normal)
        context?.setLineCap(CGLineCap.round)
        context?.setLineWidth(brushSize) // Brush size variable value
        context?.setStrokeColor(UIColor(red: red, green: green, blue: blue, alpha: opacity).cgColor)
        context?.strokePath()
        
        container.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        swipe = true
        if let touch = touches.first {
            let currentPoint = touch.location(in: self.view)
            drawnLine(from: lastPoint , to: currentPoint)
            
            lastPoint = currentPoint
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !swipe {
            drawnLine(from: lastPoint, to: lastPoint)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setContainerView()
    }
    
}



