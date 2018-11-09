//
//  CustomerType.swift
//  VNPT2018
//
//  Created by Thành Lã on 11/7/18.
//  Copyright © 2018 MonstarLab. All rights reserved.
//

import Foundation

struct CustomerType {
    var id: String
    var name: String
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
    
    init(realm: RealmCustomerType) {
        id = realm.id
        name = realm.name
    }
    
    var realmType: RealmCustomerType {
        return RealmCustomerType(self)
    }
    
    func save() {
        RealmHelper.insert(type: [RealmCustomerType(self)])
    }
}
