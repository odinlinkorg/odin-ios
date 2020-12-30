//
//  TransferAccountsController.swift
//  BlackGoldMall
//
//  Created by 永芯 on 2020/8/24.
//  Copyright © 2020 黑金商城. All rights reserved.
//

import UIKit

class TransferAccountsController: BaseViewController {

    @IBOutlet weak var iphoneF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "转账"
        view.backgroundColor = UIColor.white
        addRightNavImgItem("mine_saoyisao")
    }

    @IBAction func buttonAction(_ sender: Any) {
        
        if !(iphoneF.text?.valiMobile() ?? false) {
          MBProgressHUD.showText("请输入正确的手机号码")
          return
       }
        
        shopUserGetUserNameByPhone()
    }
    
        override func clickRightItem() {
            let saovc = ScannerVC.init()
                    saovc.setupScanner(Localized("扫一扫"), .green, .default, Localized("将二维码/条码放入框内，即可自动扫描")) { (code) in
//                        vc.navigationController?.popViewController(animated: true)
                        let dict = code.getDictionaryFromJSONString()
                        if dict.count == 2 {
                        let typeStr = dict["type"] as? String
                        let type = dict["type"] as? Int
                        if typeStr == "1" || type == 1 {

                        if let accountStr = dict["data"] {
        
                            self.iphoneF.text =  (accountStr as! String)
                            return
                        }
                    
                    }
                }
            }
            self.navigationController?.present(saovc, animated: true, completion: nil)
        }
    
    func shopUserGetUserNameByPhone(){
        NetworkManager<BaseModel>().requestModel(API.shopUserGetUserNameByPhone(phone: iphoneF.text!), completion: { (response) in
            if let dic = response?.dataDict{
                 let vc = TransferCoinNumController.init(nibName: "TransferCoinNumController", bundle: nil)
                  
                let avatar = dic["avatar"] as! String
                let userName = dic["userName"] as! String
                vc.setphoneF(self.iphoneF.text!,avatar,userName)
                 self.navigationController?.pushViewController(vc, animated: true)
                
            }

        }) { (error) in
           
           if let msg = error.message {
               MBProgressHUD.showText(msg)
           }
        }
    }
    
    

}


