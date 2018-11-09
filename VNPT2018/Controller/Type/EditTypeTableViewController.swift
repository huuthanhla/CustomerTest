//
//  EditTypeTableViewController.swift
//  VNPT2018
//
//  Created by Thành Lã on 11/9/18.
//  Copyright © 2018 MonstarLab. All rights reserved.
//

import UIKit

class EditTypeTableViewController: UITableViewController {
    @IBOutlet weak var typeTextField: CustomTextField!
    
    var type: CustomerType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        typeTextField.addTarget(self, action: #selector(self.textFieldValueChanged(_:)), for: .editingChanged)
        typeTextField.text = type?.name
    }
    
    @objc func textFieldValueChanged(_ sender: UITextField) {
        guard let input = sender.text else { return }
        type?.name = input
    }
    
    func saved() {
        print(type ?? "")
        guard let aType = type, !aType.name.isEmpty else {
            AlertController.shared.showErrorMessage(title: "Lỗi", message: "Không được bỏ trống tên loại khách hàng", completionHandler: {})
            return
        }
        RealmHelper.insert(type: [aType.realmType])
    }
}
