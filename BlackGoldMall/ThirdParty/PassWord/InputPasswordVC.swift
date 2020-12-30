//
//  InputPasswordVC.swift
//  HSEther
//
//  Created by 永芯 on 2019/9/23.
//  Copyright © 2019 com.houshuai. All rights reserved.
//

import UIKit

class InputPasswordVC: UIViewController {

    @IBOutlet weak var passwordView: PasswordView!
    
    @objc var inputFinish: ((String) -> Void)?

    @objc var isHiddenBtn = false
    @objc var closeBlock: (() -> Void)?

    
    @IBOutlet weak var bgViewH: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.init(white: 0.3, alpha: 0.3)
//        self.modalTransitionStyle = .crossDissolve
        
        passwordView.delegate = self
        passwordView.input()
        // Do any additional setup after loading the view.
    }

    override func viewWillLayoutSubviews() {
//        self.bgViewH.constant = CGFloat(455.0 + SafeArea_BottomHeight)

    }
    
    @IBAction func closeAction(_ sender: UIButton) {
        self.dismiss(animated: true) {
            self.view.backgroundColor = UIColor.init(white: 0.3, alpha: 0);
            if self.closeBlock != nil {
                self.closeBlock!()
            }
        }
    }
    
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension InputPasswordVC: PasswordViewDelegate{
    func entryComplete(password: String) {
        self.inputFinish?(self.passwordView.textField.text ?? "")
        self.dismiss(animated: true, completion: nil)
    }
}
