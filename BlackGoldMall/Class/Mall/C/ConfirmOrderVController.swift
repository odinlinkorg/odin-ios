//
//  ConfirmOrderVController.swift
//  BlackGoldMall
//
//  Created by 永芯 on 2020/8/21.
//  Copyright © 2020 黑金商城. All rights reserved.
//

import UIKit

class ConfirmOrderVController:BaseViewController,HSTableViewProtocol{
    let hView = UIView.init()
    var specModel : SpecListModel!
    var tableView : UITableView!
    var addressModel : AddressdzModel!
    var goodsInfoByGoodsIdModel : TeSeModel!
    var availableOdin :NSNumber!
    var availableBgc :NSNumber!
    var selectRow  = 0
    var confirmOrderBottomView : ConfirmOrderBottomView!
    
    var shopCurrentPriceModel : ShopCurrentPriceModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "确认订单"
        // Do any additional setup after loading the view.
        tableView =  tableViewConfig(CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight-kLiuHaiH - 44.0 - kTabBarHeight), self, self, .plain)
//       tableView.rowHeight = 200
       tableView.sectionHeaderHeight = 0.01
       tableView.sectionFooterHeight = 0.01
       tableView.backgroundColor = .clear
//        tableView.separatorStyle = .none
//        tableView.estimatedRowHeight = 200
       
        registerNibCell(tableView, ConfirmOrderCell.self)
        registerNibCell(tableView, ConfirmOrderAddressCell.self)
        registerNibCell(tableView, ConfirmOrderXinXiCell.self)
        registerNibCell(tableView, ConfirmOrderPayTypeCell.self)
        //
//        registerNibCell(tableView, OrderDetailsAddressCell.self)
        
        
        walletBalance()
        view.addSubview(tableView)
        
        tableView.reloadData()
        
        confirmOrderBottomView = ConfirmOrderBottomView.loadFromNib()
        confirmOrderBottomView.frame = CGRect.init(x: 0, y: kScreenHeight-kTabBarHeight - kNavBarHeight, width: kScreenWidth, height: kTabBarHeight)
        confirmOrderBottomView.payButton.addTarget(self, action: #selector(payButtonAction(_:)), for: .touchUpInside)
        
        let buttonGZ = UIButton.init(frame: CGRect.init(x: kScreenWidth - 106 - 15, y: kScreenHeight-kTabBarHeight - kNavBarHeight - kLiuHaiH, width: 106, height: kTabBarHeight))
//        buttonGZ.backgroundColor = UIColor.init(hex: 0xDE1524)
        buttonGZ.backgroundColor = .clear
        buttonGZ.addTarget(self, action: #selector(payButtonAction(_:)), for: .touchUpInside)
        view.addSubview(confirmOrderBottomView)
        view.addSubview(buttonGZ)
        
        
        
    
    }
    
//    去付款
    @objc func payButtonAction(_ sender:Any){
        if  specModel.payRemark == nil {
            specModel.payRemark  = ""
        }
        if addressModel == nil{
            MBProgressHUD.showText("请选择收货地址")
            return
        }
        
        
        NetworkManager<BaseModel>().requestModel(API.orderSubmit(goodsId: String(specModel.goodsId), storeId: String(specModel.storeId), specId: String(specModel.specId), userName: addressModel.shippingName, userPhone: addressModel.shippingPhone, userAddress: String(addressModel.shippingAddress + addressModel!.shippingAddressDetail), totalNum: String(specModel.payNum), payType: String(selectRow), remark: specModel.payRemark), completion: { (response) in
            
            if let dic = response?.dataDict{
                let orderId = dic["orderId"] as!NSNumber
                self.pushPassword(String(format: "%@", orderId))
            }
          
        }) { (error) in
        if let msg = error.message {
            MBProgressHUD.showText(msg)
        }
        }
    }
    
    func updatePayNum(){
        if selectRow == 0 {
            let  ODIN =  String(format: "%.2lf ODIN",  Double(self.specModel.odinPrice)  * Double(specModel.payNum))
            self.confirmOrderBottomView.numLabel.text = ODIN
        }else{
            let  BGC = String(format: "%.2lf BGC",  Double(self.specModel.shopPrice) * Double(specModel.payNum))
            self.confirmOrderBottomView.numLabel.text = BGC
        }
    }
    
    func setaSpecListModel(_ specListModellx: SpecListModel,_ goodsInfoByGoodsIdModells :  TeSeModel){
        specModel = specListModellx
        goodsInfoByGoodsIdModel = goodsInfoByGoodsIdModells
        self.shopCurrentPrice(String(goodsInfoByGoodsIdModells.cost), String(goodsInfoByGoodsIdModells.price), String(goodsInfoByGoodsIdModells.goodsId))
    }
    
    
    func walletBalance()  {
          NetworkManager<BaseModel>().requestModel(API.userWalletBalance, completion: { (response) in
             if let dict = response?.dataDict {
                self.availableOdin = (dict["availableOdin"] as! NSNumber)
                self.availableBgc = (dict["availableBgc"] as! NSNumber)
                self.tableView.reloadSections([2], with: .none)
              }
          }) { (error) in
              if let msg = error.message {
                  MBProgressHUD.showText(msg)
              }
          }
      }
    
    func pushPassword(_ orderId:String){
        let vc = InputPasswordVC.init()
        vc.view.backgroundColor = vcBoxBlack
        vc.modalPresentationStyle = .overCurrentContext;
        vc.modalTransitionStyle = .crossDissolve;
        keyWindow?.rootViewController?.present(vc, animated: true, completion: nil)
        vc.inputFinish = { [weak self] d in
            self?.orderPay(d,orderId)
        }
    }
    
    //获取实时币价
    func shopCurrentPrice(_ cost:String,_ price:String,_ goodsId:String){
        NetworkManager<BaseModel>().requestModel(API.shopCommonCurrentPrice(cost: cost, price: price, goodsId: goodsId), completion: { (response) in
            
            if let data = response?.dataDict{
//                self.shopCurrentPriceModel.power = data["power"] as? Int
//                self.shopCurrentPriceModel.shopPrice = data["shopPrice"] as? Int
//                self.shopCurrentPriceModel.odinPrice = data["odinPrice"] as? Int
            }
        }) { (error) in
            if let msg = error.message {
                MBProgressHUD.showText(msg)
            }
        }
    }

    
    func orderPay(_ password:String,_ orderId:String){
        NetworkManager<BaseModel>().requestModel(API.orderPay(insidePayPassword: password, orderId: orderId), completion: { (response) in
//           MBProgressHUD.showText("订单已提交")
            if let data = response?.dataDict{
                let vc = OrderDetailsVController.init()
                vc.model = MyOrderListModel.init(fromDictionary: data as! [String : Any])
                self.navigationController?.pushViewController(vc, animated: true)
            }
      }) { (error) in
      if let msg = error.message {
          MBProgressHUD.showText(msg)
      }
      }
    }
    
    
}

extension ConfirmOrderVController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
       return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        
        return 15.0 * (375.0 / screenWidth)
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 200.0
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            if addressModel != nil {
                let cell:ConfirmOrderAddressCell = cellWithTableView(tableView)
                cell.namel.text = addressModel.shippingName
                cell.phonel.text = addressModel.shippingPhone
                cell.addressl.text = addressModel.shippingAddress + addressModel.shippingAddressDetail
                 return cell
            }
            let cell:ConfirmOrderCell = cellWithTableView(tableView)
           
            return cell
        }
        else if indexPath.section == 1 {
            let cell:ConfirmOrderXinXiCell = cellWithTableView(tableView)
            if goodsInfoByGoodsIdModel != nil {
                 cell.setaGoodsInfoByGoodsIdModel(goodsInfoByGoodsIdModel,specModel)
            }
            cell.block = {[weak self] model in
                self?.specModel = model
                self!.updatePayNum()
            }
            return cell
        }
       
           
        let cell:ConfirmOrderPayTypeCell = cellWithTableView(tableView)
        if availableOdin != nil {
            cell.setodinLabelAndbgcLabel(availableOdin.stringValue, availableBgc.stringValue)
            self.updatePayNum()
        }
        
        cell.block = {[weak self] select in
            self?.selectRow = select
            self!.updatePayNum()
        }
  
        return cell
        
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return hView
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            //选择收获地址
            let vc =  AddressVController.init()
            vc.block = { [weak self] d in
                self!.addressModel = d
                self!.tableView.reloadData()
            }
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

