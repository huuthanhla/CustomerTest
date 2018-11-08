//
//  Extensions.swift
//  VNPT2018
//
//  Created by Thành Lã on 11/7/18.
//  Copyright © 2018 MonstarLab. All rights reserved.
//

import UIKit
import RealmSwift

extension Results {
    public func toArray() -> [Element] {
        return Array(self)
    }
}

extension String {
    static func random(length len: Int = 0, charset: String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789") -> String {
        let randomLength = (len == 0)
            ? Int.random(max: 16)
            : len
        let max = charset.count - 1
        
        return (0..<randomLength)
            .map { _ in charset[charset.index(charset.startIndex, offsetBy: Int.random(0, max: max))] }
            .map { String($0) }
            .reduce("", +)
    }
}

extension Int {
    public func toString(_ length: Int) -> String {
        return String(format: "%.\(length)d", self)
    }
    
    public static func random(_ range: Range<Int>) -> Int {
        var offset = 0
        
        // allow negative ranges
        if range.lowerBound < 0 {
            offset = abs(range.lowerBound)
        }
        
        let mini = UInt32(range.lowerBound + offset)
        let maxi = UInt32(range.upperBound + offset)
        
        return Int(mini + arc4random_uniform(maxi - mini)) - offset
    }
    
    public static func random(_ min: Int = 0, max: Int) -> Int {
        return Int(arc4random_uniform(UInt32((max - min) + 1))) + min
    }    
}

extension Int {
    public var years: TimeInterval { return 365 * self.days }
    public var year: TimeInterval { return self.years }
    
    public var days: TimeInterval { return 24 * self.hours }
    public var day: TimeInterval { return self.days }
    
    public var hours: TimeInterval { return 60 * self.minutes }
    public var hour: TimeInterval { return self.hours }
    
    public var minutes: TimeInterval { return 60 * self.seconds }
    public var minute: TimeInterval { return self.minutes }
    
    public var seconds: TimeInterval { return TimeInterval(self) }
    public var second: TimeInterval { return self.seconds }
}

extension UIView {
    public class func nib() -> UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    func visible(_ isVisible: Bool) {
        self.alpha = isVisible ? 1 : 0
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else {
            return UIView()
        }
        return view
    }
    
    @IBInspectable var viewBorderColor: UIColor? {
        get {
            return layer.borderColor.map { UIColor(cgColor: $0) }
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable var viewBorderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var viewCornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
}

extension UIApplication {
    var topViewController: UIViewController? {
        if var topViewController = UIApplication.shared.keyWindow?.rootViewController {
            while topViewController.presentedViewController != nil {
                topViewController = topViewController.presentedViewController!
            }
            return topViewController
        } else {
            return nil
        }
    }
}

extension UIViewController {
    public class func vc() -> Self {
        return self.init(nibName: String(describing: self), bundle: nil)
    }
    
    var appDelegate: AppDelegate? {
        return UIApplication.shared.delegate as? AppDelegate
    }
    
    class func instantiate<T: UIViewController>(_: T.Type, storyboard: String) -> T {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: String(describing: T.self)) as? T else {
            fatalError("Can not instantiate viewcontroller from storyboard \(storyboard)")
        }
        return viewController
    }
}

extension UIColor {
    func alpha(_ alpha: CGFloat) -> UIColor {
        return withAlphaComponent(alpha)
    }
}

extension Date {
    var displayText: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: self)
    }
}
