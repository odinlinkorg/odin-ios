//
//  ConfirmOrderPayTypeCell.swift
//  BlackGoldMall
//
//  Created by 永芯 on 2020/8/21.
//  Copyright © 2020 黑金商城. All rights reserved.
//

import UIKit

class ConfirmOrderPayTypeCell: UITableViewCell {

    @IBOutlet weak var odinLabel: UILabel!
    @IBOutlet weak var bgcLabel: UILabel!
 
    @IBOutlet weak var odinButton: UIButton!
    @IBOutlet weak var bgcButton: UIButton!
    
    typealias funBlock = (Int) -> ()
    var block : funBlock?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func odinButtonAction(_ sender: UIButton) {
    
        if sender == odinButton {
            odinButton.setImage(UIImage.init(named: "xuanzhong"), for: .normal)
            bgcButton.setImage(UIImage.init(named: "weixuan_icon"), for: .normal)
            block!(0)
        }
        else{
            odinButton.setImage(UIImage.init(named: "weixuan_icon"), for: .normal)
            bgcButton.setImage(UIImage.init(named: "xuanzhong"), for: .normal)
            block!(1)
        }
        
        
    }
    
    
    
    func setodinLabelAndbgcLabel(_ odin:String,_ bgc:String){
        self.odinLabel.text = "您当前账户可用 " + odin + " ODIN"
        self.bgcLabel.text = "您当前账户可用 " +  bgc + " BGC"
    }
    
}
