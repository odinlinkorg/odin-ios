//
//  ChangePasswordVController.swift
//  BlackGoldMall
//
//  Created by 永芯 on 2020/8/25.
//  Copyright © 2020 黑金商城. All rights reserved.
//

import UIKit

class ChangePasswordVController: BaseViewController {

    @IBOutlet weak var ysPassword: UITextField!
    
    @IBOutlet weak var newPassword: UITextField!
    @IBOutlet weak var newPasswordT: UITextField!
    var isloginPassword : Bool!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title =  isloginPassword ? "修改登录密码" : "修改支付密码"
        if !isloginPassword {
            ysPassword.placeholder = "请输入原6位数字密码"
            newPassword.placeholder = "请输入原6位数字密码"
            newPasswordT.placeholder = "请再次输入新密码"
        }
        
    }

    @IBAction func buttonAction(_ sender: Any) {
        let model = UserManager.getUserModel()
        if title == "修改支付密码"{
            
                 
        if !(newPassword.text?.checkPaypass() ?? false){
        MBProgressHUD.showText("请输入正确的支付密码")
        return
        }

        if !(newPasswordT.text?.checkPaypass() ?? false){
        MBProgressHUD.showText("请输入正确的支付密码")

        return

        }

        if (newPasswordT.text != newPassword.text){
        MBProgressHUD.showText("两次密码输入不一致")
        return
        }
            
        NetworkManager<BaseModel>().requestModel(API.shopUserUpdatePayPassword(phone: (model?.phone)!, oldPassword: ysPassword.text!, newPassword: newPassword.text!), completion: { (response) in
            MBProgressHUD.showText("密码修改成功")
        }) { (error) in
            if let msg = error.message {
                MBProgressHUD.showText(msg)
            }
        }
        }
        else{
            
                     
            if !(newPassword.text?.checkPassword() ?? false){
            MBProgressHUD.showText("请输入正确的支付密码")
            return
            }

            if !(newPasswordT.text?.checkPassword() ?? false){
            MBProgressHUD.showText("请输入正确的支付密码")

            return

            }

            if (newPasswordT.text != newPassword.text){
            MBProgressHUD.showText("两次密码输入不一致")
            return
            }
                
            NetworkManager<BaseModel>().requestModel(API.shopUserUpdatePassword(phone: (model?.phone)!, oldPassword: ysPassword.text!, newPassword: newPassword.text!), completion: { (response) in
                MBProgressHUD.showText("密码修改成功")
            }) { (error) in
                if let msg = error.message {
                    MBProgressHUD.showText(msg)
                }
            }
        }
    }
    
}
