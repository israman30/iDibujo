//
//  AlertController.swift
//  iDibujo
//
//  Created by Israel Manzo on 7/23/19.
//  Copyright © 2019 Israel Manzo. All rights reserved.
//

import UIKit

struct AlertController {
    
    static func resetDraw(_ vc: UIViewController, imageView: UIImageView) {
        let alert = UIAlertController(title: NSLocalizedString("Alert_Recycle_Logo", comment: "♻️"), message: NSLocalizedString("Alert_Comment_Reset_Art", comment: "Are yo sure you want to reset your art???"), preferredStyle: .alert)
        
        let action = UIAlertAction(title: NSLocalizedString("Alert_YES", comment: "YES"), style: .default) { alert in
            imageView.image = nil
        }
        let cancel = UIAlertAction(title: "NO", style: .destructive, handler: nil)
        alert.addAction(action)
        alert.addAction(cancel)
        vc.present(alert, animated: true, completion: nil)
    }
    
    static func alert(_ viewController: UIViewController, title: String, message: String) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: NSLocalizedString("Alert_NO", comment: "NO"), style: .default, handler: nil)
        alertController.addAction(action)
        
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    static func actionSheet(_ viewController: UIViewController, title: String, message: String) {
        let actionSheet = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        let cancel = UIAlertAction(title: NSLocalizedString("Alert_Action_Cancel", comment: "Cancel ❌"), style: .cancel, handler: nil)
        // TODO: add aditional buttons
        
        actionSheet.addAction(cancel)
        // TODO: add aditional buttons in actionSheet
        
        viewController.present(actionSheet, animated: true, completion: nil)
    }
}
