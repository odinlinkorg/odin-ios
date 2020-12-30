//
//  OrderDetailsCardCell.swift
//  BlackGoldMall
//
//  Created by 永芯 on 2020/8/24.
//  Copyright © 2020 黑金商城. All rights reserved.
//

import UIKit

class OrderDetailsCardCell: UITableViewCell {

    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var typeImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func model (_ model: MyOrderListModel){
        switch model.status {
        case 0:
           typeLabel.text = "待付款"
           typeImg.image = UIImage.init(named: "mine_daifukuan")
        case 1:
           typeLabel.text = "待发货"
          typeImg.image = UIImage.init(named: "mine_daifahuo")
           
        case 2:
           typeLabel.text = "待收货"
         typeImg.image = UIImage.init(named: "mine_daishouhuo")
        case 3:
           typeLabel.text = "已收货"
            typeImg.image = UIImage.init(named: "mine_daishouhuo")
        case 4:
           typeLabel.text = "已完成"
            typeImg.image = UIImage.init(named: "mine_daishouhuo")

        case 99:
           typeLabel.text = "已取消"
            typeImg.image = UIImage.init(named: "mine_quxiao")

        default:
           typeLabel.text = "已完成"
            typeImg.image = UIImage.init(named: "mine_daishouhuo")

        }
    }
    
}
