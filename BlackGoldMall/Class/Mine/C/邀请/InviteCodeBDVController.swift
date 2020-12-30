//
//  InviteCodeBDVController.swift
//  BlackGoldMall
//
//  Created by 永芯 on 2020/8/25.
//  Copyright © 2020 黑金商城. All rights reserved.
//

import UIKit

class InviteCodeBDVController: BaseViewController {
    var userModel = UserManager.getUserModel()
    @IBOutlet weak var yqCodeF: UITextField!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var bgV: UIView!
    @IBOutlet weak var topView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if userModel?.inviteCode.length != 0 {
//            shopUserGetInviteUseName()
//
//        }else{
//            bgV.isHidden = true
//        }
        
        view.backgroundColor = .white
        shopUserGetInviteUseName()
    }

    func shopUserGetInviteUseName() {
    
        NetworkManager<BaseModel>().requestModel(API.shopUserGetInviteUseName, completion: { (response) in
            if let dic = response?.dataDict{
                var loginName = dic["loginName"] as! String
                self.phoneLabel.text = "账号："  + loginName.phoneNoAddAsterisk()
                
                self.bgV.isHidden = false
                self.topView.isHidden = true
                
            }else{
                self.bgV.isHidden = true
              self.topView.isHidden = true
            }
            
        }) { (error) in
            if let msg = error.message {
                MBProgressHUD.showText(msg)
            }
        }
    }
    
    
    @IBAction func bottomAction(_ sender: Any) {
        if yqCodeF.text?.length == 0{
            MBProgressHUD.showText("请输入邀请码")
            return
        }
        NetworkManager<BaseModel>().requestModel(API.shopUserUpdateUserInviteCode(inviteCode: yqCodeF.text!), completion: { (response) in
            MBProgressHUD.showText("邀请码绑定成功")
         
            self.navigationController?.popViewController(animated: true)
            
        }) { (error) in
            if let msg = error.message {
                MBProgressHUD.showText(msg)
            }
        }
        
    }
    
}
