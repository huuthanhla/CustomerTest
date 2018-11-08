//
//  MainViewController.swift
//  VNPT2018
//
//  Created by Thành Lã on 11/7/18.
//  Copyright © 2018 MonstarLab. All rights reserved.
//

import UIKit

class MainViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var customerArray: [Customer] = []
    
    override func setupViews() {
        super.setupViews()
        setupRightBarButton()
        configBackgroundColor()
        fetchData()
    }
    
    fileprivate func fetchData() {
        customerArray = RealmHelper.getAllCustomers()
        tableView.reloadSections(IndexSet(integer: 0), with: .fade)
        title = customerArray.count > 0
            ? "Danh sách  \(customerArray.count)  khách hàng"
            : "Danh sách khách hàng"
    }
}

extension MainViewController {
    func setupRightBarButton() {
        let add = UIBarButtonItem(image: UIImage(named: "Add"), style: .plain, target: self, action: #selector(self.addCustomer(_:)))
        add.tintColor = .white
        navigationItem.rightBarButtonItem = add
    }
    
    @objc func addCustomer(_ sender: UIBarButtonItem) {
        pushToCustomerVC(customer: Customer(blank: true))
    }
    
    fileprivate func pushToCustomerVC(state: CustomerViewController.State = .create, customer: Customer? = nil) {
        guard let customerVC = storyboard?.instantiateViewController(withIdentifier: String(describing: CustomerViewController.self)) as? CustomerViewController else { return }
        customerVC.state = state
        customerVC.customer = customer
        customerVC.delegate = self
        navigationController?.pushViewController(customerVC, animated: true)
    }
}

extension MainViewController: CustomerViewControllerDelegate {
    func createOrUpdateCustomer() {
        fetchData()
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return customerArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomerTableViewCell", for: indexPath) as? CustomerTableViewCell else { return UITableViewCell() }
        cell.configuration(with: customerArray[indexPath.row])
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        pushToCustomerVC(state: .update, customer: customerArray[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let edit = UITableViewRowAction(style: .normal, title: "Edit") { (action, index) in
            self.editCustomer(self.customerArray[indexPath.row])
        }
        edit.backgroundColor = .orange
        
        let trash = UITableViewRowAction(style: .normal, title: "Delete") { (action, index) in
            self.deleteCustomer(self.customerArray[indexPath.row])
        }        
        trash.backgroundColor = .red
        
        return [trash, edit]
    }
    
    fileprivate func editCustomer(_ customer: Customer) {
        pushToCustomerVC(state: .update, customer: customer)
    }
    
    fileprivate func deleteCustomer(_ customer: Customer) {
        AlertController.shared.showConfirmMessage(title: "Xác nhận", message: "Xóa khách hàng [\(customer.name)]?") { confirm in
            guard confirm else { return }
            RealmHelper.deleteCustomer(id: customer.id)
            self.fetchData()
        }
    }
}
