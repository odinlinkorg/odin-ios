//
//  TransferCoinNumController.swift
//  BlackGoldMall
//
//  Created by 永芯 on 2020/8/24.
//  Copyright © 2020 黑金商城. All rights reserved.
//

import UIKit

class TransferCoinNumController: BaseViewController {
    var phoneText : String!
    var headimgPath : String!
    var name : String!
    @IBOutlet weak var typeButton: UIButton!
    @IBOutlet weak var numberF: UITextField!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var headImg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "转账"
        view.backgroundColor = .white
        addRightNavItem("转账记录")
        phoneLabel.text = phoneText
        headImg.kf.setImage(with: URL.init(string: headimgPath), placeholder: nil, options: [.forceRefresh])
        nameLabel.text = name
    }
    func setphoneF(_ phone :String,_ headimg: String,_ userName:String){
        phoneText = phone
        name = userName
        headimgPath = headimg
        
    }

    
    @IBAction func changeCoinAction(_ sender: Any) {
        
        
       let vc = AddressPickerViewController.init()
       vc.view.backgroundColor = vcBoxBlack
       vc.modalPresentationStyle = .overCurrentContext;
       vc.modalTransitionStyle = .crossDissolve;
       keyWindow?.rootViewController?.present(vc, animated: true, completion: nil)
       vc.block = { d in
        self.typeButton.setTitle(d, for: .normal)
   
       }
       navigationController?.pushViewController(AddressPickerViewController.init(), animated: true)
    }

    
    @IBAction func transferAction(_ sender: Any) {
        if numberF.text?.length == 0 {
            MBProgressHUD.showText("请输入转币数量")
            return
        }
       pushPassword()
    }
    
    func userTransInside(_ insidePayPassword:String){
        let type = typeButton.titleLabel?.text == "ODIN" ? "2" : "1"
        NetworkManager<BaseModel>().requestModel(API.userTransInside(amount: numberF.text!, payeePhone: phoneText, insidePayPassword: insidePayPassword, type: type), completion: { (response) in
         
//               MBProgressHUD.showText("转帐已提交")
            self.successAlert()
               self.navigationController?.popViewController(animated: true)
           
        }) { (error) in
           
           if let msg = error.message {
               MBProgressHUD.showText(msg)
           }
        }
    }
    
    func pushPassword(){
        let vc = InputPasswordVC.init()
        vc.view.backgroundColor = vcBoxBlack
        vc.modalPresentationStyle = .overCurrentContext;
        vc.modalTransitionStyle = .crossDissolve;
        keyWindow?.rootViewController?.present(vc, animated: true, completion: nil)
            vc.inputFinish = { [weak self] d in
                self?.userTransInside(d)
            }
    }
    
    func successAlert(){
    let vc = ZhuanZSuccessVController.init()
      vc.view.backgroundColor = vcBoxBlack
      vc.modalPresentationStyle = .overCurrentContext;
      vc.modalTransitionStyle = .crossDissolve;
      keyWindow?.rootViewController?.present(vc, animated: true, completion: nil)
       
    }
    
    override func clickRightItem() {
        let vc = TransferRecordController.init()
        vc.title = "转账记录"
        vc.operateType = "0"
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension TransferCoinNumController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
           let currentText = textField.text ?? ""
           let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
           return newText.validateMoney(precision: 4)

    }
}
