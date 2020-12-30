//
//  OrderDetailsAddressCell.swift
//  BlackGoldMall
//
//  Created by 永芯 on 2020/8/24.
//  Copyright © 2020 黑金商城. All rights reserved.
//

import UIKit

class OrderDetailsAddressCell: UITableViewCell {
    @IBOutlet weak var namel: UILabel!
    
    @IBOutlet weak var phonel: UILabel!
    @IBOutlet weak var addressl: UILabel!
    @IBOutlet weak var addBgview: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func model (_ model: MyOrderListModel){
        namel.text = model.userName
        phonel.text = model.userPhone
        addressl.text = model.userAddress
    }
    
}
