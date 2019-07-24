//
//  SavePhotoHandler+Ext.swift
//  iDibujo
//
//  Created by Israel Manzo on 7/24/19.
//  Copyright © 2019 Israel Manzo. All rights reserved.
//

import UIKit

extension MainController {
    
    func savePhotoToLibrary() {
        let actionSheet = UIAlertController(title: "Hello", message: "What are you going to do?", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Save your Art 🎨", style: .default, handler: { (UIAlertAction) in
            
            guard let image = self.container.image else { return }
            UIImageWriteToSavedPhotosAlbum(image, self, #selector(self.image(_:didFinishWithError:contextInfo:)), nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel ❌", style: .default, handler: nil))
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    @objc func image(_ image: UIImage, didFinishWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            AlertController.alert(self, title: "Error", message: error.localizedDescription)
        } else {
            AlertController.alert(self, title: "Saved", message: "You photo has been saved!")
        }
    }
    
}

