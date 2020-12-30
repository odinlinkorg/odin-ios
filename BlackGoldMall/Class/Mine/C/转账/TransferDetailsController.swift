//
//  TransferDetailsController.swift
//  BlackGoldMall
//
//  Created by 永芯 on 2020/8/24.
//  Copyright © 2020 黑金商城. All rights reserved.
//

import UIKit

class TransferDetailsController: BaseViewController {
    var model : RecordTransModel!
    @IBOutlet weak var headImg: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var staLebl: UILabel!
    @IBOutlet weak var numLabel: UILabel!
    
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    @IBOutlet weak var createTimeLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var dfzhTitleLabel: UILabel!
    @IBOutlet weak var headerTOP: UIView!
    @IBOutlet weak var headerTH: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "账单详情"
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        updateView()
    }
    
    
    func shopUserGetUserNameByPhone(){
        NetworkManager<BaseModel>().requestModel(API.shopUserGetUserNameByPhone(phone: phoneLabel.text!), completion: { (response) in
            if let dic = response?.dataDict{
             
                  
                let avatar = dic["avatar"] as! String
                let userName = dic["userName"] as! String
               
                self.headImg.kf.setImage(with: URL.init(string: (avatar)), placeholder: UIImage.init(named:"mine_touxiang"), options: [.forceRefresh])
                self.nameLabel.text = userName
                
            }

        }) { (error) in
           
           if let msg = error.message {
               MBProgressHUD.showText(msg)
           }
        }
    }
    


    /*
    // MARK: -
     1.交易类型有：充币、提币、付款、收款、购买商品、算力空投

     2.对方账户：交易类型是付款和收款  账户显示 对方手机号

     交易类型是 充币或提币 显示对方地址

     交易类型是购买商品 显示 商品名称

     交易类型是算力空投 显示 空投账户

     3.交易时间；显示到账时间

     4.订单号：每笔交易都有订单号
    */
    
    func setModel(_ modells:RecordTransModel){
        model = modells
        
    }
    
    func updateView(){
    
      createTimeLabel.text =  model.createTime
    
        switch model.type {
           case 1:
               numLabel.text = String.init(model.symbol) + String.init(model.num) + "BGC"
           default:
               numLabel.text = String.init(model.symbol) + String.init(model.num) + "ODIN"
           }
        
      phoneLabel.text = model.toAddress
      idLabel.text = model.id
      switch  model.operateType {
      case "0":
          typeLabel.text = "内部转账"
          headerTOP.isHidden = false
          headerTH.constant = 105.0
        shopUserGetUserNameByPhone()
          
      case "2":
          typeLabel.text = "空投"
          dfzhTitleLabel.text = "空投账户"
      case "1":
          typeLabel.text = "提币"
      case "3":
          typeLabel.text = "活动赠送"
      case "4":
          typeLabel.text = "购买商品"
          dfzhTitleLabel.text = "商品名称"
      case "5":
          typeLabel.text = "充币"
      default:
          typeLabel.text = "提币"
      }
      
      switch  model.status {
            case "0":
                staLebl.text = "待审核"
            case "1":
                staLebl.text = "已审核"
            case "2":
                staLebl.text = "已转出(待检查）"
           case "3":
                staLebl.text = "已完成"
            case "4":
                staLebl.text = "转出失败"
            case "5":
                staLebl.text = "审核失败"
            case "9":
                staLebl.text = "收益"
            default:
                staLebl.text = ""
            }
    }

}
