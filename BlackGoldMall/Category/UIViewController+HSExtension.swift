//
//  UIViewController+HSExtension.swift
//  GMG
//
//  Created by 永芯 on 2020/1/8.
//  Copyright © 2020 永芯. All rights reserved.
//  form TimedSilver
 
import UIKit

public extension UIViewController {

    /// UIViewController init from a nib with same name of the class.
    /// Use:    let viewController = HHViewController.hs_initFromNib() as! HHViewController
    class func hs_initFromNib() -> UIViewController {
        let hasNib: Bool = Bundle.main.path(forResource: self.hs_className, ofType: "nib") != nil
        guard hasNib else {
            assert(!hasNib, "Invalid parameter") // here
            return UIViewController()
        }
        return self.init(nibName: self.hs_className, bundle: nil)
    }
    
    static var topViewController: UIViewController? {
        var presentedVC = UIApplication.shared.keyWindow?.rootViewController
        while let pVC = presentedVC?.presentedViewController {
            presentedVC = pVC
        }
        
        if presentedVC == nil {
            print("Error: You don't have any views set. You may be calling them in viewDidLoad. Try viewDidAppear instead.")
        }
        return presentedVC
    }
    
}
