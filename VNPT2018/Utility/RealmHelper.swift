//
//  RealmHelper.swift
//  VNPT2018
//
//  Created by Thành Lã on 11/7/18.
//  Copyright © 2018 MonstarLab. All rights reserved.
//

import Foundation
import RealmSwift

class RealmHelper {
    static func createOrUpdate(customer: Customer) {
        do {
            let realm = try Realm()
            let aCustomer = RealmCustomer(customer)
            try realm.write {
                realm.add(aCustomer, update: true)
            }
            print("Insert or Update account `\(customer.id)` to Realm")
        } catch {
            print("error: \(error)")
        }
    }
    
    static func deleteCustomer(id: String) {
        do {
            let realm = try Realm()
            
            guard let record = realm.object(ofType: RealmCustomer.self, forPrimaryKey: id) else { return }
            
            try realm.write {
                realm.delete(record)
            }
            print("deleted record `\(id)`")
        } catch {
            print("error: \(error)")
        }
    }
    
    static func getAllCustomers() -> [Customer] {
        do {
            let realm = try Realm()
            return realm.objects(RealmCustomer.self)
                .sorted(byKeyPath: "name", ascending: true)
                .toArray().map { $0.customer }
        } catch {
            print("error: \(error)")
            return []
        }
    }
    
    // MARK: - TYPE
    
    static func insert(type: [RealmCustomerType]) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(type, update: true)
            }
            print("Insert `\(type.count)` type to Realm")
        } catch {
            print("error: \(error)")
        }
    }
    
    static func getType(by id: String) -> RealmCustomerType? {
        do {
            let realm = try Realm()
            return realm.object(ofType: RealmCustomerType.self, forPrimaryKey: id)
        } catch {
            print("error: \(error)")
            return nil
        }
    }
    
    static func getAllTypes() -> [RealmCustomerType] {
        do {
            let realm = try Realm()
            return realm.objects(RealmCustomerType.self)
                .sorted(byKeyPath: "name", ascending: true)
                .toArray()
        } catch {
            print("error: \(error)")
            return []
        }
    }
    
    static func deleteType(id: String) {
        do {
            let realm = try Realm()
            
            guard let record = realm.object(ofType: RealmCustomerType.self, forPrimaryKey: id) else { return }
            
            try realm.write {
                realm.delete(record)
            }
            print("deleted Type `\(id)`")
        } catch {
            print("error: \(error)")
        }
    }
}

