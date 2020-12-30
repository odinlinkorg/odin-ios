//
//  HomeSmallCollectionVCell.swift
//  BlackGoldMall
//
//  Created by 永芯 on 2020/8/20.
//  Copyright © 2020 黑金商城. All rights reserved.
//

import UIKit

class HomeSmallCollectionVCell: UICollectionViewCell {

    @IBOutlet weak var shangpinImage: UIImageView!
    @IBOutlet weak var suanliLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setModel(_ model : HomeGoodsModelItem){
        shangpinImage.kf.setImage(with: URL.init(string: model.image), placeholder: nil, options:[.forceRefresh])
        suanliLabel.text = String(model.givePower)  + " 算力"
        bottomLabel.text =  String(format: "%.2lf",  model.odinPrice) + " ODIN/" +  String(format: "%.2lf", model.shopPrice) + " BGC"
    }

}
