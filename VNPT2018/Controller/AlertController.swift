//
//  AlertController.swift
//  VNPT2018
//
//  Created by Thành Lã on 11/7/18.
//  Copyright © 2018 MonstarLab. All rights reserved.
//

import UIKit

class AlertController: NSObject {
    static let shared = AlertController()
    var alertController: UIAlertController?
    
    func showConfirmMessage(title: String? = nil, message: String, confirm: String = "Đồng ý", cancel: String = "Bỏ qua", isDestructive: Bool = true, completionHandler: @escaping (_ confirm: Bool) -> Void) {
        if self.alertController != nil {
            self.alertController?.dismiss(animated: false, completion: nil)
            self.alertController = nil
        }
        self.alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: confirm, style: isDestructive ? .destructive : .default, handler: { _ in
            self.alertController = nil
            completionHandler(true)
        })
        let cancelAction = UIAlertAction(title: cancel, style: .default, handler: { _ in
            self.alertController = nil
            completionHandler(false)
        })
        self.alertController?.addAction(cancelAction)
        self.alertController?.addAction(confirmAction)
        UIApplication.shared.topViewController?.present(alertController!, animated: true, completion: nil)
    }
    
    func showErrorMessage(title: String? = nil, message: String, ok: String = "OK", completionHandler: @escaping () -> Void) {
        if self.alertController != nil { return }
        self.alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: ok, style: .cancel, handler: { _ in
            self.alertController = nil
            completionHandler()
        })
        self.alertController?.addAction(okAction)
        UIApplication.shared.topViewController?.present(alertController!, animated: true, completion: nil)
    }
}
