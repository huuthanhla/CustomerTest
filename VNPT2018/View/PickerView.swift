//
//  PickerView.swift
//  VNPT2018
//
//  Created by Thành Lã on 11/8/18.
//  Copyright © 2018 MonstarLab. All rights reserved.
//

import UIKit

protocol PickerViewDelegate: class {
    func selected(data: PickerData)
}

typealias PickerData = (name: String, value: Int)

class PickerView: UIView {
    var pickerView: UIPickerView!
    
    weak var delegate: PickerViewDelegate?
    
    var values: [PickerData] = []
    var selectedIndex: Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        pickerView.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
        pickerView.reloadComponent(0)
        pickerView.selectRow(selectedIndex, inComponent: 0, animated: true)
    }
    
    func setupView() {
        pickerView = setupPickerView()
        pickerView.dataSource = self
        pickerView.delegate = self
        addSubview(pickerView)
        
    }
    
    func setupPickerView() -> UIPickerView {
        let picker = UIPickerView()
        picker.backgroundColor = .white
        return picker
    }
}

extension PickerView: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return values.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return values[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedIndex = row
        delegate?.selected(data: values[row])
    }
}
