//
//  TiBiViewController.swift
//  BlackGoldMall
//
//  Created by 永芯 on 2020/8/24.
//  Copyright © 2020 黑金商城. All rights reserved.
//

import UIKit

class TiBiViewController: BaseViewController {
    @IBOutlet weak var typeButton: UIButton!
    
    @IBOutlet weak var addressF: UITextField!
    @IBOutlet weak var numberF: UITextField!
    @IBOutlet weak var feeLabel: UILabel!
    
    @IBOutlet weak var balanceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "提币"
        
        transFee()
        walletBalance()
    }

    @IBAction func tibiAction(_ sender: Any) {
        
        if (self.addressF.text?.length == 0) {
            MBProgressHUD.showText("请输入提币地址")
            return
        }
//
       
       if (self.numberF.text?.length == 0) {
           MBProgressHUD.showText("请输入提币数量")
           return
       }
        
        transFeeNum()
        
        
       
    }
    
    func pushTiBiQueRenController(_ sjNum : String,_ fee : String)  {
         let vc = TiBiQueRenController.init()
         vc.view.backgroundColor = vcBoxBlack
       vc.modalPresentationStyle = .overCurrentContext;
       vc.modalTransitionStyle = .crossDissolve;
        vc.setDic(addressF.text!, numberF.text!, fee, sjNum)
       keyWindow?.rootViewController?.present(vc, animated: true, completion: nil)
       
       vc.block = { [weak self] xh  in
           self!.pushPassword()

       }
    }
    
    func pushPassword(){
        let vc = InputPasswordVC.init()
        vc.view.backgroundColor = vcBoxBlack
        vc.modalPresentationStyle = .overCurrentContext;
        vc.modalTransitionStyle = .crossDissolve;
        keyWindow?.rootViewController?.present(vc, animated: true, completion: nil)
            vc.inputFinish = { [weak self] d in
                self?.userTrans(d)
            }
    }
    
    func transFeeNum(){
           let type = typeButton.titleLabel?.text == "ODIN" ? "2" : "1"
        NetworkManager<BaseModel>().requestModel(API.shopCommonTransFeeNum(num:numberF.text!,type:type), completion: { (response) in
            if let dict = response?.dataDict {
                
                let arriveNum = String.init(format: "%@", dict["arriveNum"] as! CVarArg)
                    let fee = dict["fee"] as! String
                    self.pushTiBiQueRenController(arriveNum,fee)
               }
           }) { (error) in
               
               if let msg = error.message {
                   MBProgressHUD.showText(msg)
               }
           }
       }
    
    func transFee(){
        let type = typeButton.titleLabel?.text == "ODIN" ? "2" : "1"
        NetworkManager<BaseModel>().requestModel(API.shopCommonTransFee(type:type), completion: { (response) in
                 if let dict = response?.dataDict {
                    let fee = dict["fee"] as! String
                    self.feeLabel.text = "手续费："  + fee  + " " + (self.typeButton.titleLabel?.text)!
            }
        }) { (error) in
            
            if let msg = error.message {
                MBProgressHUD.showText(msg)
            }
        }
    }
    
    func userTrans(_ insidePayPassword : String){
        let type = typeButton.titleLabel?.text == "ODIN" ? "2" : "1"
        NetworkManager<BaseModel>().requestModel(API.userTrans(num: numberF.text!, toAddress: addressF.text!, insidePayPassword: insidePayPassword, type: type), completion: { (response) in
          
                MBProgressHUD.showText("提币已提交")
                self.navigationController?.popViewController(animated: true)
            
        }) { (error) in
            
            if let msg = error.message {
                MBProgressHUD.showText(msg)
            }
        }
    }
    
    
    func walletBalance()  {
        NetworkManager<BaseModel>().requestModel(API.userWalletBalance, completion: { (response) in
           if let dict = response?.dataDict {
            let  availableOdin = dict["availableOdin"] as! NSNumber
          
            
            
            let  availableBgc = dict["availableBgc"] as! NSNumber
         
         
            if self.typeButton.titleLabel?.text == "ODIN" {
                self.balanceLabel.text = String(format: "当前可用余额：%@ ODIN", availableOdin)
            }else{
                self.balanceLabel.text = String(format: "当前可用余额：%@ BGC", availableBgc)
            }
            
            }
        }) { (error) in
            if let msg = error.message {
                MBProgressHUD.showText(msg)
            }
        }
    }

    
    @IBAction func changeCoinAction(_ sender: Any) {
        
        
       let vc = AddressPickerViewController.init()
       vc.view.backgroundColor = vcBoxBlack
       vc.modalPresentationStyle = .overCurrentContext;
       vc.modalTransitionStyle = .crossDissolve;
       keyWindow?.rootViewController?.present(vc, animated: true, completion: nil)
       vc.block = { d in
        self.typeButton.setTitle(d, for: .normal)
           self.walletBalance()
           self.transFee()
       }
       navigationController?.pushViewController(AddressPickerViewController.init(), animated: true)
    }
    

}
