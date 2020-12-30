//
//  PaddingTextField.swift
//  MySwiftDemo
//
//  Created by 永芯 on 2019/12/2.
//  Copyright © 2019 永芯. All rights reserved.
//

import UIKit

class PaddingTextField: UITextField {
    
    @IBInspectable open var insets : UIEdgeInsets = UIEdgeInsets.init(top: 0, left: 15, bottom: 0, right: 0)

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let paddedRect = bounds.inset(by: self.insets)
        if self.rightViewMode == .always || self.rightViewMode == .unlessEditing {
            return self.adjustRectWithWidthRightView(bounds: paddedRect)
        }
        return paddedRect;
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        let paddedRect = bounds.inset(by: self.insets)
        if self.rightViewMode == .always || self.rightViewMode == .unlessEditing {
            return self.adjustRectWithWidthRightView(bounds: paddedRect)
        }
        return paddedRect;
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let paddedRect = bounds.inset(by: self.insets)
        if self.rightViewMode == .always || self.rightViewMode == .unlessEditing {
            return self.adjustRectWithWidthRightView(bounds: paddedRect)
        }
        return paddedRect;
    }
    
    func adjustRectWithWidthRightView(bounds: CGRect) -> CGRect {
        var paddedRect = bounds
        paddedRect.size.width -= self.rightView?.frame.width ?? 15
        return paddedRect;
    }


}
