//
//  CustomerTableViewCell.swift
//  VNPT2018
//
//  Created by Thành Lã on 11/7/18.
//  Copyright © 2018 MonstarLab. All rights reserved.
//

import UIKit

class CustomerTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let selectedBgView = UIView()
        selectedBgView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        self.selectedBackgroundView = selectedBgView
    }
    
    func configuration(with customer: Customer) {
        titleLabel.text = customer.name
        noteLabel.text = customer.phone + " - " + customer.address
    }    
}

