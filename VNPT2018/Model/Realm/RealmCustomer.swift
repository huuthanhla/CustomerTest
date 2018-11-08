//
//  RealmCustomer.swift
//  VNPT2018
//
//  Created by Thành Lã on 11/7/18.
//  Copyright © 2018 MonstarLab. All rights reserved.
//

import Foundation
import RealmSwift

class RealmCustomer: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var address: String = ""
    @objc dynamic var birthday: String = ""
    @objc dynamic var phone: String = ""
    @objc dynamic var type: Int = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(_ customer: Customer) {
        self.init()
        id = customer.id
        name = customer.name
        address = customer.address
        birthday = customer.birthday
        phone = customer.phone
        type = customer.type
    }
    
    var customer: Customer {
        return Customer(self)
    }
}
