//
//  BaseViewController.swift
//  VNPT2018
//
//  Created by Thành Lã on 11/7/18.
//  Copyright © 2018 MonstarLab. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        configNavigationBar(navigationController)
    }
    
    func configBackgroundColor() {
        guard let bgImage = UIImage(named: "pattern-grey") else { return }
        view.backgroundColor = UIColor(patternImage: bgImage)
    }
    
    @objc func back(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    func configBackBarButton() {        
        let left = UIBarButtonItem(image: UIImage(named: "NavBack"), style: .plain, target: self, action: #selector(self.back(_:)))
        left.tintColor = .white
        navigationItem.leftBarButtonItem = left
    }
    
    func configNavigationBar(_ navigationController: UINavigationController?, isTranslucent: Bool = true, barTintColor: UIColor = UIColor.lightGray, titleColer: UIColor = UIColor.white, fontSize: CGFloat = 16) {
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize, weight: .medium),
            NSAttributedString.Key.foregroundColor: titleColer
        ]
        navigationController?.navigationBar.barTintColor = barTintColor
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        navigationController?.navigationBar.isTranslucent = isTranslucent
    }
}
