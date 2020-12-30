//
//  SetCenterCell.swift
//  BlackGoldMall
//
//  Created by 永芯 on 2020/8/25.
//  Copyright © 2020 黑金商城. All rights reserved.
//

import UIKit

class SetCenterCell: UITableViewCell {

    @IBOutlet weak var nrlabel: UILabel!
    @IBOutlet weak var headImage: UIImageView!
    @IBOutlet weak var rightTLabel: UILabel!
    @IBOutlet weak var qjImage: UIImageView!
    

    @IBOutlet weak var rightLayoutC: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
