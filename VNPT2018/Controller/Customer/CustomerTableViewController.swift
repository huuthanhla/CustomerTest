//
//  CustomerTableViewController.swift
//  VNPT2018
//
//  Created by Thành Lã on 11/7/18.
//  Copyright © 2018 MonstarLab. All rights reserved.
//

import UIKit

class CustomerTableViewController: UITableViewController {
    @IBOutlet weak var idTextField: CustomTextField!
    @IBOutlet weak var customerNameTextField: CustomTextField!
    @IBOutlet weak var addressTextField: CustomTextField!
    @IBOutlet weak var phoneTextField: CustomTextField!
    @IBOutlet weak var birthdayTextField: CustomTextField!
    @IBOutlet weak var customerTypeLabel: UILabel!
    @IBOutlet weak var typeTextField: CustomTextField!
    
    var birthdayDatePicker: UIDatePicker?
    
    enum TextFieldTag: Int {
        case id = 10, name, address, phone
        static let tags = [id, name, address, phone]
    }
    
    var textField: [UITextField] {
        return [idTextField, customerNameTextField, addressTextField, phoneTextField]
    }
    
    var customer: Customer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configViews()
    }
    
    func configViews() {
        setupPickerView()
        
        zip(textField, TextFieldTag.tags).forEach { (textfield, textFieldTag) in
            textfield.tag = textFieldTag.rawValue
            textfield.addTarget(self, action: #selector(self.textFieldValueChanged(_:)), for: .editingChanged)
        }
        
        guard let customer = customer else { return }
        idTextField.text = customer.id
        customerNameTextField.text = customer.name
        addressTextField.text = customer.address
        phoneTextField.text = customer.phone
        
        if !customer.birthday.isEmpty {
            birthdayTextField.text = customer.birthday
        }
        
        if !customer.typeName.isEmpty {
            customerTypeLabel.text = customer.typeName
        }
    }
    
    fileprivate func setupPickerView() {
        birthdayDatePicker = UIDatePicker()
        birthdayDatePicker?.maximumDate = Calendar.current.date(byAdding: .year, value: -4, to: Date())
        birthdayDatePicker?.datePickerMode = .date
        birthdayDatePicker?.addTarget(self, action: #selector(self.datePickerValueChanged(_:)), for: .valueChanged)
        if let dateString = customer?.birthday, let date = dateFromString(dateString) {
            birthdayDatePicker?.setDate(date, animated: false)
        }
        
        birthdayTextField.inputView = birthdayDatePicker
        birthdayTextField.addTarget(self, action: #selector(self.textFieldDidBegin(_:)), for: .editingDidBegin)
    }
    
    // Make a dateFormatter in which format you would like to display the selected date in the textfield.
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        birthdayTextField.text = sender.date.displayText
        customer?.birthday = sender.date.displayText
    }
    
    @objc func textFieldDidBegin(_ sender: UITextField) {
        if let dayOfBirth = customer?.birthday, !dayOfBirth.isEmpty {
            birthdayTextField.text = dayOfBirth
        } else {
            birthdayTextField.text = birthdayDatePicker?.date.displayText
        }
        
        customer?.birthday = birthdayTextField.text ?? ""
    }
    
    @IBAction func selectCustomerType(_ sender: Any) {
        let customerType = RealmHelper.getAllTypes().map({ (name: $0.name, value: $0.id) })
        PickerViewController.show(from: self, values: customerType, selectedIndex: 0) { (typeId) in
            self.customer?.type = typeId
            self.customerTypeLabel.text = self.customer?.typeName
        }
    }
    
    @objc func textFieldValueChanged(_ sender: UITextField) {
        guard let input = sender.text else { return }
        switch sender.tag {
        case TextFieldTag.id.rawValue:
            customer?.id = input
        case TextFieldTag.name.rawValue:
            customer?.name = input
        case TextFieldTag.address.rawValue:
            customer?.address = input
        case TextFieldTag.phone.rawValue:
            customer?.phone = input
        default:
            break
        }
    }
    
    fileprivate func hideKeyboard() {
        view.endEditing(true)
    }
    
    func clearData() {
        hideKeyboard()
        textField.forEach { $0.text = "" }
        customerTypeLabel.text = "Chọn"
        birthdayTextField.text = ""
        if let aCustomer = customer {
            customer = Customer(id: aCustomer.id, blank: true)
            idTextField.text = aCustomer.id
        }
    }
    
    func saved() {
        print(customer ?? "")
        guard let aCustomer = customer, aCustomer.isValid else {
            AlertController.shared.showErrorMessage(title: "Lỗi", message: "Chưa nhập đủ thông tin khách hàng", completionHandler: {})
            return
        }
        RealmHelper.createOrUpdate(customer: aCustomer)
    }
    
    fileprivate func dateFromString(_ dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.date(from: dateString)
    }
}

extension CustomerTableViewController: PickerViewDelegate {
    func selected(data: PickerData) {
        
    }
}
