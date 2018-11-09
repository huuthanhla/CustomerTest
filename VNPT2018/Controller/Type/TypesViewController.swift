//
//  TypesViewController.swift
//  VNPT2018
//
//  Created by Thành Lã on 11/9/18.
//  Copyright © 2018 MonstarLab. All rights reserved.
//

import UIKit

class TypesViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var allTypes: [CustomerType] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Các loại khách hàng"
        fetchData()
    }
    
    override func setupViews() {
        super.setupViews()
        configBackBarButton()
        configBackgroundColor()
        let add = UIBarButtonItem(image: UIImage(named: "Add"), style: .plain, target: self, action: #selector(self.addType(_:)))
        add.tintColor = .white
        navigationItem.rightBarButtonItem = add
    }
    
    @objc fileprivate func addType(_ sender: UIBarButtonItem) {
        pushToCustomerVC(type: CustomerType(id: UUID().uuidString, name: ""))
    }
    
    fileprivate func pushToCustomerVC(state: EditTypeViewController.State = .create, type: CustomerType? = nil) {
        guard let typeVC = storyboard?.instantiateViewController(withIdentifier: String(describing: EditTypeViewController.self)) as? EditTypeViewController else { return }
        typeVC.state = state
        typeVC.type = type
        typeVC.delegate = self
        navigationController?.pushViewController(typeVC, animated: true)
    }
    
    fileprivate func fetchData(animation: UITableView.RowAnimation = .fade) {
        allTypes = RealmHelper.getAllTypes().map({ $0.customerType })
        tableView.reloadSections(IndexSet(integer: 0), with: animation)
    }
}

extension TypesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TypeTableViewCell", for: indexPath) as? TypeTableViewCell else { return UITableViewCell() }
        cell.configuration(with: allTypes[indexPath.row])
        return cell
    }
}

extension TypesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        pushToCustomerVC(state: .update, type: allTypes[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let trash = UITableViewRowAction(style: .normal, title: "Delete") { (action, index) in
            self.deleteType(self.allTypes[indexPath.row])
        }
        trash.backgroundColor = .red
        
        return [trash]
    }
    
    fileprivate func deleteType(_ type: CustomerType) {
        AlertController.shared.showConfirmMessage(title: "Xác nhận", message: "Xóa loại khách hàng [\(type.name)]?") { confirm in
            guard confirm else { return }
            RealmHelper.deleteType(id: type.id)
            self.fetchData(animation: .automatic)
        }
    }
}

extension TypesViewController: EditTypeViewControllerDelegate {
    func createOrUpdateType() {
        fetchData()
    }
}
