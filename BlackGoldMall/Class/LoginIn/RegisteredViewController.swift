//
//  RegisteredViewController.swift
//  BlackGoldMall
//
//  Created by 永芯 on 2020/8/25.
//  Copyright © 2020 黑金商城. All rights reserved.
//

import UIKit

class RegisteredViewController: BaseViewController {

    @IBOutlet weak var iphoneF: UITextField!
    
    @IBOutlet weak var verifyCode: UITextField!
    @IBOutlet weak var inviteCode: UITextField!
    @IBOutlet weak var passwordF: UITextField!
    
    @IBOutlet weak var insidePasswordF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
    }
    
    @IBAction func xieyiButtonAction(_ sender: Any) {
         let vc = WebViewController.init()
        vc.loadType = .yinsi
        vc.title = title
        //            vc.urlStr = textValue
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func shopUserRegisterAction(_ sender: Any) {
      
        if !(iphoneF.text?.valiMobile() ?? false) {
            MBProgressHUD.showText("请输入正确的手机号码")
            return
         }
        
         if !(verifyCode.text?.checkAuthCodeStr() ?? false) {
            MBProgressHUD.showText("请输入正确的验证码")
            return
         }
         if !(passwordF.text?.checkPassword() ?? false){
             MBProgressHUD.showText("请输入正确密码")
             return
         }
        
        if !(insidePasswordF.text?.checkPaypass() ?? false){
            MBProgressHUD.showText("请输入正确的支付密码")
            return
        }
    
        NetworkManager<UserModel>().requestModel( API.shopUserRegister(phone: iphoneF.text!, password: passwordF.text!, verifyCode: verifyCode.text!, insidePassword: insidePasswordF.text!, inviteCode: inviteCode.text!), completion: { (response) in
                    if let userModel = response?.jsonpData {
//                       UserManager.saveUserInfo(model: userModel)
//                       self.navigationController?.dismiss(animated: true, completion: nil)
                        UserManager.saveUserInfo(model: userModel)
                        let myAppdelegate = UIApplication.shared.delegate as! AppDelegate
                        myAppdelegate.setFirstTabbar()
                   }
           
//            MBProgressHUD.showText("注册成功请登录")
//            self.navigationController?.popViewController(animated: true)
               
               }) { (error) in
                  if let msg = error.message {
                      MBProgressHUD.showText(msg)
                  }
               }
    }
    
    @IBAction func msgloginAction(_ sender: UIButton) {
        if !(self.iphoneF.text?.valiMobile() ?? false) {
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
           NetworkManager<BaseModel>().requestModel(API.shopUserSendMessage(phone: iphoneF.text!,vaptchaToken:token), completion: { (response) in
               MBProgressHUD.showText("验证码已发送")
               sender.countDown(count: 60,countDownBgColor: UIColor.init(hex: 0xF1F1F1))
               sender.isEnabled = true

              }) { (error) in
                sender.isEnabled = true
                 if let msg = error.message {
                     MBProgressHUD.showText(msg)
                 }
              }
        
        
    }
}
