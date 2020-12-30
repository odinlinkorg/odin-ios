//
//  EarningsCell.swift
//  BlackGoldMall
//
//  Created by 永芯 on 2020/8/21.
//  Copyright © 2020 黑金商城. All rights reserved.
//

import UIKit

class EarningsCell: UITableViewCell {

    @IBOutlet weak var num: UILabel!
    @IBOutlet weak var operateType: UILabel!
    @IBOutlet weak var createTime: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func model(_ model: RecordProfitModel) {
        switch model.operateType {
        case "0":
            operateType.text = "内部转账"
        case "1":
            operateType.text = "提币"
        case "2":
            operateType.text = "空投"
        case "3":
            operateType.text = "活动赠送"
        default:
            operateType.text = "购买商品"
        }
        
        num.text = model.symbol + " " + String(model.num)
        createTime.text = model.createTime
    }
    
}
