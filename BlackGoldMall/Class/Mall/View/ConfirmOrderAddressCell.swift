//
//  ConfirmOrderAddressCell.swift
//  BlackGoldMall
//
//  Created by 永芯 on 2020/8/21.
//  Copyright © 2020 黑金商城. All rights reserved.
//

import UIKit

class ConfirmOrderAddressCell: UITableViewCell {
    @IBOutlet weak var namel: UILabel!
    
    @IBOutlet weak var phonel: UILabel!
    @IBOutlet weak var addressl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
