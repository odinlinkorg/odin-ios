//
//  LoginInVController.swift
//  BlackGoldMall
//
//  Created by 永芯 on 2020/8/20.
//  Copyright © 2020 黑金商城. All rights reserved.
//

import UIKit

class LoginInVController: BaseViewController {

    @IBOutlet weak var loginNameF: UITextField!
    @IBOutlet weak var passwordF: UITextField!
    @IBOutlet weak var loginType: UIButton!
    @IBOutlet weak var yzmLayout: NSLayoutConstraint!
    
    var passwordLogin = true
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
    }
    
    
    @IBAction func loginButtonAction(_ sender: UIButton) {
         
        if !passwordLogin{
            //短信验证登录
            if !(loginNameF.text?.valiMobile() ?? false) {
                MBProgressHUD.showText("请输入正确的手机号码")
                return
            }
            if !(passwordF.text?.checkAuthCodeStr() ?? false) {
                MBProgressHUD.showText("请输入正确的验证码")
                return
            }
            NetworkManager<UserModel>().requestModel(API.shopUserMsgLogin(phone: loginNameF.text!, verifyCode: passwordF.text!), completion: { (response) in
               sender.isEnabled = true
                if let userModel = response?.data {
                                   
                    UserManager.saveUserInfo(model: userModel)
                    
                    self.navigationController?.dismiss(animated: true, completion: nil)
                    
                }
               
            }) { (error) in
                if let msg = error.message {
                    MBProgressHUD.showText(msg)
                    sender.isEnabled = true
                }
            }
            
           
        }else{
            //账号密码登录
            if !(loginNameF.text?.valiMobile() ?? false) {
               MBProgressHUD.showText("请输入正确的手机号码")
               return
            }
            if !(passwordF.text?.checkPassword() ?? false){
                MBProgressHUD.showText("请输入正确密码")
                return
            }
            NetworkManager<UserModel>().requestModel(API.shopUserLogin(loginName: loginNameF.text!, password: passwordF.text!), completion: { (response) in
               sender.isEnabled = true
                if let userModel = response?.jsonpData {
                    UserManager.saveUserInfo(model: userModel)
                    let myAppdelegate = UIApplication.shared.delegate as! AppDelegate
                    myAppdelegate.setFirstTabbar()
                }
               
            }) { (error) in
                if let msg = error.message {
                    MBProgressHUD.showText(msg)
                    sender.isEnabled = true
                }
            }
          
        }
    }
    
    
    
    
    @IBAction func sendMessageAction(_ sender: UIButton) {
        if !(self.loginNameF.text?.valiMobile() ?? false) {
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
        NetworkManager<BaseModel>().requestModel(API.shopUserSendMessage(phone: loginNameF.text!,vaptchaToken:token), completion: { (response) in
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
    
    @IBAction func registerAction(_ sender: Any) {
        navigationController?.pushViewController(RegisteredViewController.init(), animated: true)
    }
    
    @IBAction func forgetPasswordAction(_ sender: Any) {
        navigationController?.pushViewController(ForgotPasswordVC.init(), animated: true)
    }

    @IBAction func loginTypeAction(_ sender: Any) {
        passwordLogin = !passwordLogin
        if !passwordLogin{
            loginType.setTitle("账号密码登录", for: .normal)
            yzmLayout.constant = 90.0
            passwordF.placeholder = "请输入验证码"
            passwordF.isSecureTextEntry = false
        }else{
            loginType.setTitle("短信验证登录", for: .normal)
            yzmLayout.constant = 0.0
            passwordF.placeholder = "请输入密码"
            passwordF.isSecureTextEntry = true
        }
    }
}
