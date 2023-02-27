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
        
        let title = NSLocalizedString("Alert_Hello", comment: "Hello")
        let message = NSLocalizedString("Alert_Message", comment: "What are you going to do?")
        let actionTitle = NSLocalizedString("Alert_Action_Title", comment: "Save your Art 🎨")
        let cancelTitle = NSLocalizedString("Alert_Action_Cancel", comment: "Cancel ❌")
        
        let actionSheet = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: actionTitle, style: .default, handler: { (UIAlertAction) in
            
            guard let image = self.canvasViewModel.draw.container.image else { return }
            UIImageWriteToSavedPhotosAlbum(
                image,
                self,
                #selector(self.image(_:didFinishWithError:contextInfo:)),
                nil
            )
        }))
        
        actionSheet.addAction(UIAlertAction(title: cancelTitle, style: .default, handler: nil))
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    @objc func image(_ image: UIImage, didFinishWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            AlertController.alert(self, title: NSLocalizedString("Alert_Error", comment: "Error"), message: error.localizedDescription)
        } else {
            AlertController.alert(self, title: NSLocalizedString("Alert_Saved", comment: "Saved"), message: NSLocalizedString("Alert_Saved_Comment", comment: "You photo has been saved!"))
        }
    }
    
}

