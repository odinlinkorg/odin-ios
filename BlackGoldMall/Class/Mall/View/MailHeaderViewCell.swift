//
//  MailHeaderViewCell.swift
//  BlackGoldMall
//
//  Created by 永芯 on 2020/8/22.
//  Copyright © 2020 黑金商城. All rights reserved.
//

import UIKit

class MailHeaderViewCell: UITableViewCell {

    @IBOutlet weak var zhButton: UIButton!
    @IBOutlet weak var slButton: UIButton!
    @IBOutlet weak var jgButton: UIButton!
    typealias funBlock = (String) -> ()
    var block : funBlock?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func buttonAction(_ sender: UIButton) {
        switch sender.titleLabel?.text {
        case "综合":
            zhButton.setTitleColor(UIColor.init(hex: 0x121212), for: .normal)
            slButton.setTitleColor(UIColor.init(hex: 0x656565), for: .normal)
            jgButton.setTitleColor(UIColor.init(hex: 0x656565), for: .normal)
        case "算力":
            zhButton.setTitleColor(UIColor.init(hex: 0x656565), for: .normal)
            slButton.setTitleColor(UIColor.init(hex: 0x121212), for: .normal)
            jgButton.setTitleColor(UIColor.init(hex: 0x656565), for: .normal)
        default:
            zhButton.setTitleColor(UIColor.init(hex: 0x656565), for: .normal)
            slButton.setTitleColor(UIColor.init(hex: 0x656565), for: .normal)
            jgButton.setTitleColor(UIColor.init(hex: 0x121212), for: .normal)
        }
        block!((sender.titleLabel?.text)!)
    }
    
    func asetType(_ type : Int){
        /**0:综合
        1:算力大到小 降序
        2:算力小到大 生序
        3:价格大到小 降序
        4:价格小到大 生序
         */
        switch type {
        case 0:
            slButton.setImage(UIImage.init(named: "mail_morenpaixu"), for: .normal)
            jgButton.setImage(UIImage.init(named: "mail_morenpaixu"), for: .normal)
        case 1:
           slButton.setImage(UIImage.init(named: "mail_jiangxu"), for: .normal)
           jgButton.setImage(UIImage.init(named: "mail_morenpaixu"), for: .normal)
        case 2:
           slButton.setImage(UIImage.init(named: "mail_shengxu"), for: .normal)
           jgButton.setImage(UIImage.init(named: "mail_morenpaixu"), for: .normal)
        case 3:
          slButton.setImage(UIImage.init(named: "mail_morenpaixu"), for: .normal)
          jgButton.setImage(UIImage.init(named: "mail_jiangxu"), for: .normal)
        
        case 4:
          slButton.setImage(UIImage.init(named: "mail_morenpaixu"), for: .normal)
          jgButton.setImage(UIImage.init(named: "mail_shengxu"), for: .normal)
        default:
            return
        }
    }
}
