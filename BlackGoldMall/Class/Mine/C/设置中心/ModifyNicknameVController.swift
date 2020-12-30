//
//  ModifyNicknameVController.swift
//  BlackGoldMall
//
//  Created by 永芯 on 2020/8/25.
//  Copyright © 2020 黑金商城. All rights reserved.
//

import UIKit

class ModifyNicknameVController: BaseViewController {
    var userModel:UserModel!
    
    @IBOutlet weak var gxqmView: UIView!
    @IBOutlet weak var nameF: UITextField!
    @IBOutlet weak var remakeF: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if title == "个性签名" {
            gxqmView.isHidden = false
        }
        addRightNavItem("保存")
        view.backgroundColor = .white
        userModel = UserManager.getUserModel()
    }
    
    override func clickRightItem() {
        updateUser()
    }
    
    func updateUser(){
        if title == "个性签名" {
            gxqmView.isHidden = false

            userModel.remake = remakeF.text ?? ""
        }else{
            userModel.userName = nameF.text ?? ""
        }
        NetworkManager<UserModel>().requestModel(API.shopUserUpdateUserName(avatar: userModel.avatar, remake: userModel.remake, userName: userModel.userName, sex: userModel.sex), completion: { (response) in
            
            
            UserManager.saveUserInfo(model: self.userModel)
              
            self.navigationController?.popViewController(animated: true)
              
        }) { (error) in
               if let msg = error.message {
                   MBProgressHUD.showText(msg)
               }
        }
    }
}

