//
//  ForgetPayPasswordVC.swift
//  BlackGoldMall
//
//  Created by 永芯 on 2020/8/25.
//  Copyright © 2020 黑金商城. All rights reserved.
//

import UIKit

class ForgetPayPasswordVC: BaseViewController {

    @IBOutlet weak var phoneF: UITextField!
    @IBOutlet weak var verifyCodeF: UITextField!
    @IBOutlet weak var newPasswordF: UITextField!
    @IBOutlet weak var newPasswordT: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "忘记支付密码"
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        
        if let model = UserManager.getUserModel(){
            phoneF.text = model.phone
        }
    }
    
    
    @IBAction func sendMessageAction(_ sender: UIButton) {
    
        
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
                     sender.countDown(count: 60,countDownBgColor: .groupTableViewBackground)
                     sender.isEnabled = true
                 }) { (error) in
                     if let msg = error.message {
                         MBProgressHUD.showText(msg)
                         sender.isEnabled = true
                     }
                 }
           
           
       }
       
    


    
    @IBAction func bottomAction(_ sender: Any) {
        if let model = UserManager.getUserModel(){
                if !(verifyCodeF.text?.checkAuthCodeStr() ?? false) {
                   MBProgressHUD.showText("请输入正确的验证码")
                   return
                }
                
               
               if !(newPasswordF.text?.checkPaypass() ?? false){
                   MBProgressHUD.showText("请输入正确的支付密码")
                   return
               }
            
               if !(newPasswordT.text?.checkPaypass() ?? false){
                   MBProgressHUD.showText("请输入正确的支付密码")
                   
                return
                
                }
                
                if (newPasswordT.text != newPasswordF.text){
                    MBProgressHUD.showText("两次密码输入不一致")
                    return
                }
            
            
            
            
            
                 NetworkManager<BaseModel>().requestModel(API.shopUserForgetPayPassword(phone: model.phone, newPassword: newPasswordF.text!, verifyCode: verifyCodeF.text!), completion: { (response) in
                     MBProgressHUD.showText("密码重置成功")
                    self.navigationController?.popViewController(animated: true)
                 }) { (error) in
                     
                     if let msg = error.message {
                         MBProgressHUD.showText(msg)
                     }
                 }
            
            
        }
        
        
           

        
        
        
        
        
    }
}
