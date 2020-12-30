//
//  MyOrderCell.swift
//  BlackGoldMall
//
//  Created by 永芯 on 2020/8/24.
//  Copyright © 2020 黑金商城. All rights reserved.
//

import UIKit

class MyOrderCell: UITableViewCell {

    @IBOutlet weak var imageV: UIImageView!
    @IBOutlet weak var storeName: UILabel!
    @IBOutlet weak var goodsName: UILabel!
    @IBOutlet weak var specName: UILabel!
    @IBOutlet weak var totalNum: UILabel!
    @IBOutlet weak var givePower: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    
    @IBOutlet weak var statusLabel: UILabel!
    var sfkLabel: String = ""
    
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    
    typealias funBlock = (String) -> ()
    var block : funBlock?

    
    @IBOutlet weak var buttonH: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    @IBAction func buttonAction(_ sender: UIButton) {
        
        block!((sender.titleLabel?.text)!)
        
    }
    func asetMyOrderModel(_ aMyOrderListModel:MyOrderListModel){
        storeName.text = aMyOrderListModel.storeName
        goodsName.text = aMyOrderListModel.goodsName
        specName.text = aMyOrderListModel.specName
        totalNum.text = "x" + String(aMyOrderListModel.totalNum)
        givePower.text = "获得：" + String(aMyOrderListModel.givePower) + "算力"
        imageV.kf.setImage(with: URL.init(string: aMyOrderListModel.image), placeholder: nil, options: [.forceRefresh])
        
        leftButton.addBorder(width: 1, borderColor: UIColor.init(hex: 0xDE1524))
        
        var atotalPrice :Double = aMyOrderListModel.payPrice
        
        switch aMyOrderListModel.status {
        case 0:
            statusLabel.text = "待付款"
            statusLabel.textColor = UIColor.init(hex: 0x03A534)
            sfkLabel = "待付款："
            leftButton.setTitle("取消订单", for: .normal)
            rightButton.setTitle("立即付款", for: .normal)
            atotalPrice = aMyOrderListModel.totalPrice
             buttonH.constant = 32.0
            leftButton.isHidden = false
            rightButton.isHidden = false
            givePower.text = "预计获得：" + String(aMyOrderListModel.givePower) + "算力"

        case 1:
            statusLabel.text = "待发货"
            sfkLabel = "实际付款："
            statusLabel.textColor = UIColor.init(hex: 0xFA7F07)
            leftButton.setTitle("取消订单", for: .normal)
            rightButton.setTitle("立即付款", for: .normal)
            leftButton.isHidden = true
            rightButton.isHidden = true
            buttonH.constant = 0.0
            
            
        case 2:
            statusLabel.text = "待收货"
            sfkLabel = "实际付款："
            statusLabel.textColor = UIColor.init(hex: 0xFA7F07)
            leftButton.setTitle("查看物流", for: .normal)
            rightButton.setTitle("确认收货", for: .normal)
            leftButton.isHidden = false
            rightButton.isHidden = false
            buttonH.constant = 32.0
            
            leftButton.addBorder(width: 1, borderColor: UIColor.init(hex: 0xDE1524))
        case 3:
            statusLabel.text = "已收货"
            sfkLabel = "实际付款："
            statusLabel.textColor = UIColor.init(hex: 0x03A534)
            leftButton.isHidden = true
            rightButton.isHidden = true
            buttonH.constant = 0.0
        case 4:
            statusLabel.text = "已完成"
            sfkLabel = "实际付款："
            statusLabel.textColor = UIColor.init(hex: 0x03A534)
            leftButton.isHidden = true
            rightButton.isHidden = true
        case 99:
            statusLabel.text = "已取消"
            atotalPrice = aMyOrderListModel.totalPrice
            leftButton.isHidden = true
            rightButton.isHidden = true
            buttonH.constant = 0.0
            givePower.text = "预计获得：" + String(aMyOrderListModel.givePower) + "算力"
        default:
            statusLabel.text = "已完成"
            sfkLabel = "实际付款："
            statusLabel.textColor = UIColor.init(hex: 0x03A534)
            leftButton.isHidden = true
            rightButton.isHidden = true
            buttonH.constant = 0.0
        }
        
      

        
        
        var payType = "ODIN"
        if aMyOrderListModel.payType != 0 {
            payType = "BGC"
        }
        
        
       
        let number = String(format: "%.2lf", atotalPrice) + " " + payType
        self.totalPrice.text = sfkLabel + number
        let myMutableString = NSMutableAttributedString(string: self.totalPrice.text!)
        myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.init(hex: 0x121212), range: NSRange(location:0,length:sfkLabel.length))
        self.totalPrice.attributedText = myMutableString
    }
    
}
