//
//  Customer.swift
//  VNPT2018
//
//  Created by Thành Lã on 11/7/18.
//  Copyright © 2018 MonstarLab. All rights reserved.
//

import Foundation

struct Customer {
    var id: String = ""
    var name: String = ""
    var address: String = ""
    var birthday: String = ""
    var phone: String = ""
    var type: Int = 0
    
    init(id: String = String.random(length: 16), blank: Bool = false) {
        self.id = id.uppercased()
        
        if blank { return }
        
        name = String.random(length: 16)
        address = String.random(length: 20)
        type = Int.random(1, max: 5)
        phone = String.random(length: 10, charset: "0123456789")
    }
    
    init(_ customer: RealmCustomer) {
        id = customer.id
        name = customer.name
        address = customer.address
        birthday = customer.birthday
        phone = customer.phone
        type = customer.type
    }
    
    func save() {
        RealmHelper.createOrUpdate(customer: self)
    }
    
    var typeName: String {
        if let customerType = RealmHelper.getType(by: type) {
            return customerType.name
        }
        return ""
    }
    
    var isValid: Bool {
        return !id.isEmpty && !name.isEmpty && !address.isEmpty && !birthday.isEmpty && !phone.isEmpty && type > 0
    }
}
