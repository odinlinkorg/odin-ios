//
//  ForgotPasswordVC.swift
//  BlackGoldMall
//
//  Created by 永芯 on 2020/8/25.
//  Copyright © 2020 黑金商城. All rights reserved.
//

import UIKit

class ForgotPasswordVC: BaseViewController {

    @IBOutlet weak var phoneF: UITextField!
    @IBOutlet weak var newPasswordF: UITextField!
    @IBOutlet weak var newPasswordTF: UITextField!
    @IBOutlet weak var verifyCodeF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }

    @IBAction func sendMessageAction(_ sender: UIButton) {
        if !(self.phoneF.text?.valiMobile() ?? false) {
            MBProgressHUD.showText("请输入正确的手机号码")
            return
        }
        
        
        
                let vc = WaterproofWallVC.init()
                vc.view.backgroundColor = vcBoxBlack
                vc.modalPresentationStyle = .overCurrentContext;
                vc.modalTransitionStyle = .crossDissolve;
                vc.returnTextBlock = {[weak self] token in
                    self!.shopUserSendMessage(token, sender)
                }
                keyWindow?.rootViewController?.present(vc, animated: true, completion: nil)
        
        
       
               
    }
    
    
    
    
    
    
    
       func shopUserSendMessage(_ token:String,_ sender: UIButton)  {
           
      sender.isEnabled = false
              NetworkManager<BaseModel>().requestModel(API.shopUserSendMessage(phone: phoneF.text!,vaptchaToken:token), completion: { (response) in
                  MBProgressHUD.showText("验证码已发送")
                   sender.countDown(count: 60,countDownBgColor: UIColor.init(hex: 0xF1F1F1))
                  sender.isEnabled = true
              }) { (error) in
                  if let msg = error.message {
                      MBProgressHUD.showText(msg)
                      sender.isEnabled = true
                  }
              }
           
           
       }
    
    @IBAction func forgetPasswordAction(_ sender: Any) {
        if !(self.phoneF.text?.valiMobile() ?? false) {
            MBProgressHUD.showText("请输入正确的手机号码")
            return
        }
        if !(verifyCodeF.text?.checkAuthCodeStr() ?? false) {
           MBProgressHUD.showText("请输入正确的验证码")
           return
        }
        if !(newPasswordF.text?.checkPassword() ?? false){
            MBProgressHUD.showText("请输入正确密码")
            return
        }
        if !(newPasswordTF.text?.checkPassword() ?? false){
            MBProgressHUD.showText("请输入正确密码")
            return
        }
        if (newPasswordF.text != newPasswordTF.text) {
            MBProgressHUD.showText("两次输入不一致")
            return
        }
       
        NetworkManager<BaseModel>().requestModel( API.shopUserForgetPassword(phone: phoneF.text!, newPassword: newPasswordF.text!, verifyCode: verifyCodeF.text!), completion: { (response) in
            MBProgressHUD.showText("密码重置成功")
            self.navigationController?.popViewController(animated: true)
        }) { (error) in
            if let msg = error.message {
                MBProgressHUD.showText(msg)
               
            }
        }
    
        
    }
}
