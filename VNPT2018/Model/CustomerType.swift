//
//  CustomerType.swift
//  VNPT2018
//
//  Created by Thành Lã on 11/7/18.
//  Copyright © 2018 MonstarLab. All rights reserved.
//

import Foundation

struct CustomerType {
    var id: Int
    var name: String
    
    func save() {
        RealmHelper.insert(type: [RealmCustomerType(self)])
    }
}
