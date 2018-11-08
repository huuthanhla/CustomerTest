//
//  RealmCustomerType.swift
//  VNPT2018
//
//  Created by Thành Lã on 11/7/18.
//  Copyright © 2018 MonstarLab. All rights reserved.
//

import Foundation
import RealmSwift

class RealmCustomerType: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(_ type: CustomerType) {
        self.init()
        self.id = type.id
        self.name = type.name
    }
}
