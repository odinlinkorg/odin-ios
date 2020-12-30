//
//  PasswordView.swift
//  HSEther
//
//  Created by 永芯 on 2019/9/23.
//  Copyright © 2019 com.houshuai. All rights reserved.
//

import UIKit

protocol PasswordViewDelegate : NSObjectProtocol{
    func entryComplete(password:String)
}

@IBDesignable  class PasswordView: UIView {
    
    @IBInspectable var lenght:Int = 6 {
        didSet{
            updataUI()
        }
    }
    
    @IBInspectable var star: String = "●"
    
    @IBInspectable var starColor: UIColor = UIColor.cyan {
        didSet {
            squareArray.forEach { (label) in
                label.textColor = starColor
            }
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.black {
        didSet {
            squareArray.forEach { (label) in
                label.layer.borderColor = borderColor.cgColor
            }
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 1 {
        didSet {
            squareArray.forEach { (label) in
                label.layer.borderWidth = borderWidth
                label.layer.masksToBounds = borderWidth > 0
            }
            
        }
    }
    
    @IBInspectable var borderRadius: CGFloat = 0 {
        didSet{
            squareArray.forEach { (label) in
                label.layer.cornerRadius = borderRadius
            }
        }
    }
    
    var side:       CGFloat!
    
    var password:   String = ""
    
    var squareArray = [UILabel]()
    
    var space:      CGFloat!
    
    var textField:  UITextField = UITextField()
    
    var tempArrat   = [String]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        updataUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        updataUI()
    }
    
    weak var delegate: PasswordViewDelegate?
    
    override func layoutSubviews() {
//        side  = self.frame.size.height
//        space = (self.frame.size.width - (CGFloat(lenght) * side)) / CGFloat(lenght - 1)
        space = 3.5
        side = (self.frame.size.width - CGFloat(lenght-1) * space) / CGFloat(lenght)
        for (index,square) in squareArray.enumerated() {
            square.frame = CGRect(x: (space + side) * CGFloat(index), y: 0, width: side, height: side)
        }
        textField.frame = CGRect(x: 0, y: side/2, width: width, height: 0)
    }
    func updataUI(){
        
        for view in self.subviews{
            view.removeFromSuperview()
        }
        
        textField.isSecureTextEntry = true
//        side  = self.frame.size.height
//        space = (self.frame.size.width - (CGFloat(lenght) * side)) / CGFloat(lenght - 1)
        squareArray.removeAll()
        for _ in 0..<lenght{
//            let label = UILabel(frame: CGRect(x: (space + side) * CGFloat(index), y: 0, width: side, height: side))
            let label = UILabel.init()
            label.layer.masksToBounds = true
            label.textAlignment = .center
//            label.layer.borderColor = UIColor.gray.cgColor
            label.layer.borderColor = vcBackLightGrayColor.cgColor
            
            label.layer.borderWidth = 1
            squareArray.append(label)
        }
        for square in squareArray {
            self.addSubview(square)
        }
        
        textField.keyboardType = .numberPad
        textField.delegate = self
        self.addSubview(textField)
    }
    
    func input() {
        textField.becomeFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textField.becomeFirstResponder()
    }
    
    deinit {
        self.delegate = nil
    }
}

extension PasswordView:UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
        password = ""
        squareArray.forEach { (label) in
            label.text = ""
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        /// 处理删除逻辑
        if string == "" {
            if password == ""{/// 密码已经为空
                return true
            }else if password.count == 1{
                password = ""
            }else{
                password = String(password[..<password.index(password.endIndex, offsetBy: -1)])
            }
        }else{
            password += string
        }
        
        /// 填充密码框
        for index in 0..<squareArray.count{
            
            if index < password.count {
                squareArray[index].text = "●"
            }else{
                squareArray[index].text = ""
            }
            
        }
        /// 完成输入
        if password.count >= lenght {
            textField.resignFirstResponder()
            textField.text = password
            self.delegate?.entryComplete(password: password)
            self.endEditing(true)
            return false
        }
        
        return true
    }
}
