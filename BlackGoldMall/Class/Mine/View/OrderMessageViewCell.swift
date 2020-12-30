//
//  OrderMessageViewCell.swift
//  BlackGoldMall
//
//  Created by 永芯 on 2020/8/31.
//  Copyright © 2020 黑金商城. All rights reserved.
//

import UIKit

class OrderMessageViewCell: UITableViewCell {

    @IBOutlet weak var goodsName: UILabel!
    @IBOutlet weak var imageV: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func asetMyOrderModel(_ aMyOrderListModel:MyOrderListModel){
     
        goodsName.text = aMyOrderListModel.goodsName

        imageV.kf.setImage(with: URL.init(string: aMyOrderListModel.image), placeholder: nil, options: [.forceRefresh])
             
    }
    
}
