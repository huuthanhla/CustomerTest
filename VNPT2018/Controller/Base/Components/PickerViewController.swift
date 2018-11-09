//
//  Extensions.swift
//  VNPT2018
//
//  Created by Thành Lã on 11/7/18.
//  Copyright © 2018 MonstarLab. All rights reserved.
//

import UIKit

class PickerViewController: UIViewController {
    @IBOutlet var pickerToolbar: UIToolbar!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    let pickerView = UIPickerView()
    let textField = UITextField()
    
    var values: [PickerData] = []
    var selectedIndex = 0
    
    typealias pickerHandler = (String) -> Void
    var doneHandler: pickerHandler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configPickerView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
        pickerView.selectRow(selectedIndex, inComponent: 0, animated: true)
    }
    
    private func configPickerView() {
        let barButtonItemTextAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)
        ]
        doneBarButton.setTitleTextAttributes(barButtonItemTextAttributes, for: .normal)
        doneBarButton.setTitleTextAttributes(barButtonItemTextAttributes, for: .highlighted)
        
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.backgroundColor = .white
        
        view.addSubview(textField)
        textField.inputView = pickerView
        textField.inputAccessoryView = pickerToolbar
        textField.autocorrectionType = .no
    }
    
    @IBAction func pickerDoneAction(_ sender: Any) {
        textField.resignFirstResponder()
        selectedIndex = pickerView.selectedRow(inComponent: 0)
        doneHandler?(values[selectedIndex].value)
        self.dismiss(animated: true, completion: nil)
    }
    
    static func show(from viewController: UIViewController, values: [PickerData], selectedIndex: Int = 0, doneHandler: @escaping pickerHandler) {
        let pickerViewController = UIViewController.instantiate(PickerViewController.self, storyboard: String(describing: PickerViewController.self))
        pickerViewController.values = values
        pickerViewController.selectedIndex = selectedIndex
        pickerViewController.doneHandler = doneHandler
        viewController.present(pickerViewController, animated: true, completion: nil)
    }
}

extension PickerViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return values.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return values[row].name
    }
}
