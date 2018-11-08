//
//  CustomerViewController.swift
//  VNPT2018
//
//  Created by Thành Lã on 11/7/18.
//  Copyright © 2018 MonstarLab. All rights reserved.
//

import UIKit

protocol CustomerViewControllerDelegate: class {
    func createOrUpdateCustomer()
}

class CustomerViewController: BaseViewController {
    @IBOutlet weak var saveButton: UIButton!
    
    enum State {
        case create
        case update
    }
    
    weak var delegate: CustomerViewControllerDelegate?
    var customerTableVC: CustomerTableViewController?
    
    var customer: Customer?
    var state = State.create
    
    override func setupViews() {
        super.setupViews()
        configBarButton()
        
        let isCreate = state == .create
        title = isCreate ? "Thêm khách hàng" : "Sửa thông tin"
        let btnTitle = isCreate ? "Thêm" : "Lưu"
        saveButton.setTitle(btnTitle, for: .normal)
        
        saveButton.layer.shadowRadius = 3
        saveButton.layer.shadowOpacity = 0.5
        saveButton.layer.shadowColor = UIColor.darkGray.cgColor
        saveButton.layer.shadowOffset = .zero
        saveButton.layer.masksToBounds = false
    }
    
    @objc func reset(_ sender: UIBarButtonItem) {
        AlertController.shared.showConfirmMessage(title: "Xác nhận", message: "Xóa hết dữ liệu và nhập lại từ đầu!") { (confirm) in
            guard confirm else { return }
            self.customerTableVC?.clearData()
        }
    }
    
    func configBarButton() {
        configBackBarButton()
        
        let right = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(self.reset(_:)))
        right.tintColor = .groupTableViewBackground
        navigationItem.rightBarButtonItem = right
    }
    
    @IBAction func save(_ sender: Any) {
        customerTableVC?.saved()
        delegate?.createOrUpdateCustomer()
        navigationController?.popViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let tableVC = segue.destination as? CustomerTableViewController {
            tableVC.customer = customer
            customerTableVC = tableVC
        }
    }
}
