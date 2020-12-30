//
//  OrderDetailsInformationCell.swift
//  BlackGoldMall
//
//  Created by 永芯 on 2020/8/24.
//  Copyright © 2020 黑金商城. All rights reserved.
//

import UIKit

class OrderDetailsInformationCell: UITableViewCell {

    @IBOutlet weak var orderId: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var payLabel: UILabel!
    @IBOutlet weak var fahuoTimeLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func model (_ model: MyOrderListModel){
        orderId.text =  "订单编号：" + model.orderNum
        timeLabel.text = "创建时间：" + model.createTime
        payLabel.text = "支付时间：" + model.payTime
        fahuoTimeLabel.text = "发货时间：" + model.shipmentsTime
        messageLabel.text = "备注：" + (model.remark.length == 0 ? "无" : model.remark)
       
       }
}
