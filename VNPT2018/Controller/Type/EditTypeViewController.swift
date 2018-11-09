//
//  EditTypeViewController.swift
//  VNPT2018
//
//  Created by Thành Lã on 11/9/18.
//  Copyright © 2018 MonstarLab. All rights reserved.
//

import UIKit

protocol EditTypeViewControllerDelegate: class {
    func createOrUpdateType()
}

class EditTypeViewController: BaseViewController {
    @IBOutlet weak var saveButton: UIButton!
    
    enum State {
        case create
        case update
    }
    
    weak var delegate: EditTypeViewControllerDelegate?
    var typeTableVC: EditTypeTableViewController?
    
    var type: CustomerType?
    var state = State.create

    override func setupViews() {
        super.setupViews()
        configBackBarButton()
        
        let isCreate = state == .create
        title = isCreate ? "Thêm loại khách hàng" : "Sửa thông tin"
        let btnTitle = isCreate ? "Thêm" : "Lưu"
        saveButton.setTitle(btnTitle, for: .normal)
        
        saveButton.layer.shadowRadius = 3
        saveButton.layer.shadowOpacity = 0.5
        saveButton.layer.shadowColor = UIColor.darkGray.cgColor
        saveButton.layer.shadowOffset = .zero
        saveButton.layer.masksToBounds = false
    }
    
    @IBAction func save(_ sender: Any) {
        typeTableVC?.saved()
        delegate?.createOrUpdateType()
        navigationController?.popViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let tableVC = segue.destination as? EditTypeTableViewController {
            tableVC.type = type
            typeTableVC = tableVC
        }
    }
}
