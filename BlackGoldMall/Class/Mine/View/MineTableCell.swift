//
//  MineTableCell.swift
//  BlackGoldMall
//
//  Created by 永芯 on 2020/8/23.
//  Copyright © 2020 黑金商城. All rights reserved.
//

import UIKit

class MineTableCell: UITableViewCell {
    @IBOutlet weak var coinImg: UIImageView!
    @IBOutlet weak var redView: UIView!
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var coinName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
