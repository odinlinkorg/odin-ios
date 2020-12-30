//
//  AddAddressVController.swift
//  BlackGoldMall
//
//  Created by 永芯 on 2020/8/24.
//  Copyright © 2020 黑金商城. All rights reserved.
//

import UIKit
import ContactsUI
class AddAddressVController: BaseViewController {

    @IBOutlet weak var nameF: UITextField!
    @IBOutlet weak var phoneF: UITextField!
    @IBOutlet weak var addressF: UITextField!
    @IBOutlet weak var xxAddress: UITextField!
    var addresM : AddressdzModel!
    var isupdate  = false
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "收货地址"
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        
        if isupdate{
            lodeV()
        }
    }
    
    func addresMol(_ model : AddressdzModel){
        addresM = model
        isupdate = true
    }
    
    func lodeV(){
        nameF.text = addresM.shippingName
        phoneF.text = addresM.shippingPhone
        addressF.text = addresM.shippingAddress
        xxAddress.text = addresM.shippingAddressDetail
    }
    
    
    @IBAction func pushPhoneAction(_ sender: Any) {
        // 1.创建联系人选择的控制器
        let cpvc = CNContactPickerViewController()
              
          // 2.设置代理
          cpvc.delegate = self
          
          // 3.弹出控制器
          present(cpvc, animated: true, completion: nil)
        
    }
    
    @IBAction func pushAddressAction(_ sender: Any) {
        let vc = BTAreaPickViewController.init(dragDismissEnabal: true)
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func addAddressACtion(_ sender: Any) {
        if nameF.text?.length == 0{
            MBProgressHUD.showText("请输入收获人姓名")
            return
        }
        
       
        if !(phoneF.text?.valiMobile() ?? false) {
            MBProgressHUD.showText("请输入正确的手机号码")
            return
         }
         
        
        if addressF.text?.length == 0{
            MBProgressHUD.showText("请选择收获人地址")
            return
        }
        
        if xxAddress.text?.length == 0{
            MBProgressHUD.showText("请输入详细地址")
            return
        }
        
        if isupdate{
            update()
        }else{
            addressAdd()
        }
     
    }
    
    
    func addressAdd()  {
        NetworkManager<BaseModel>().requestModel(API.addressAdd(shippingName: nameF.text!, shippingAddress: addressF.text!, shippingAddressDetail: xxAddress.text!, shippingPhone: phoneF.text!), completion: { (response) in
            
            self.navigationController?.popViewController(animated: true)
        }) { (error) in
            if let msg = error.message {
                MBProgressHUD.showText(msg)
            }
        }
    }
    func update(){
        
        NetworkManager<BaseModel>().requestModel(API.addressUpdate(aid:String(addresM.id),shippingName: nameF.text!, shippingAddress: addressF.text!, shippingAddressDetail: xxAddress.text!, shippingPhone: phoneF.text!), completion: { (response) in
            
            self.navigationController?.popViewController(animated: true)
        }) { (error) in
            if let msg = error.message {
                MBProgressHUD.showText(msg)
            }
        }
    }
    
}
extension AddAddressVController : BTAreaPickViewControllerDelegate {
    func areaPickerView(_ areaPickerView: BTAreaPickViewController, doneAreaModel model: BTAreaPickViewModel) {
        NSLog("doneAreaModel %@",model.description);
        addressF.text = model.description
    }
}


extension AddAddressVController : CNContactPickerDelegate {
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        // 1.获取用户的姓名
        // lastname --> familyName
        // firstname --> givenName
        let lastname = contact.familyName
        let firstname = contact.givenName
        print("姓名:\(firstname) \(lastname)")
        
        // 2.获取用户电话号码(ABMultivalue)
        let phones = contact.phoneNumbers
        for phone in phones {
//            let phoneLabel = phone.label
            let phoneValue = phone.value.stringValue
            phoneF.text = phoneValue.replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
        }
         nameF.text = firstname + lastname
    }
    
//这个方法和上面的方法是一样的,只是它是获取多个联系人的信息
//    func contactPicker(_ picker: CNContactPickerViewController, didSelect contacts: [CNContact]) {
//
//    }
}
