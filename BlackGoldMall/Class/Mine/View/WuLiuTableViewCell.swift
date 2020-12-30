//
//  WuLiuTableViewCell.swift
//  BlackGoldMall
//
//  Created by 永芯 on 2020/8/31.
//  Copyright © 2020 黑金商城. All rights reserved.
//

import UIKit

class WuLiuTableViewCell: UITableViewCell {
    @IBOutlet weak var imgV: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var mLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var bottomline: UIView!
    @IBOutlet weak var topLine: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
