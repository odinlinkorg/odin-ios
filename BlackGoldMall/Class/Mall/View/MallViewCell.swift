//
//  MallViewCell.swift
//  BlackGoldMall
//
//  Created by 永芯 on 2020/8/21.
//  Copyright © 2020 黑金商城. All rights reserved.
//

import UIKit

class MallViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var shangpinImage: UIImageView!
    @IBOutlet weak var suanliLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    @IBOutlet weak var sales: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setModel(_ model : HomeGoodsModelItem){
        
            nameLabel.text = model.goodsName
           shangpinImage.kf.setImage(with: URL.init(string: model.image), placeholder: nil, options:[.forceRefresh])
           suanliLabel.text = String(format: "%d",model.givePower)  + " 算力"
           bottomLabel.text =  String(format: "%.2lf", model.odinPrice) + " ODIN/" +   String(format: "%.2lf",model.shopPrice) + " BGC"
           sales.text =  "已售" + String(model.sales)
       }

    
}
