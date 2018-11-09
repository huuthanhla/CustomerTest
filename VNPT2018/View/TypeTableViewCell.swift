//
//  TypeTableViewCell.swift
//  VNPT2018
//
//  Created by Thành Lã on 11/9/18.
//  Copyright © 2018 MonstarLab. All rights reserved.
//

import UIKit

class TypeTableViewCell: UITableViewCell {
    @IBOutlet weak var typeNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let selectedBgView = UIView()
        selectedBgView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        self.selectedBackgroundView = selectedBgView
    }
    
    func configuration(with type: CustomerType) {
        typeNameLabel.text = type.name
    }

}
