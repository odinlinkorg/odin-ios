//
//  ConfirmOrderXinXiCell.swift
//  BlackGoldMall
//
//  Created by 永芯 on 2020/8/21.
//  Copyright © 2020 黑金商城. All rights reserved.
//

import UIKit

class ConfirmOrderXinXiCell: UITableViewCell {

    @IBOutlet weak var goodsName: UILabel!
    @IBOutlet weak var imageV: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var specName: UILabel!
    @IBOutlet weak var givePower: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    @IBOutlet weak var payRemark: UITextField!
    @IBOutlet weak var numF: UITextField!
    
    typealias funBlock = (SpecListModel) -> ()
    var block : funBlock?
    
    var specModel : SpecListModel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        payRemark.addTarget(self, action: #selector(changeRemaek), for: .editingChanged)
    }
    
    @objc func changeRemaek(){
        specModel.payRemark = payRemark.text
        if block != nil {
                   block!(specModel)
               }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        
    }
    
    @IBAction func jianButtonAction(_ sender: Any) {
         let myNumberInt = Int(numF.text!)
         var num : Int = myNumberInt! - 1
         
         if num <= 1{
             num = 1
         }
        specModel.payNum = num
        updatePriceAndNum()
        
        
     }
     
     @IBAction func jiaButtonAction(_ sender: Any) {
         let myNumberInt = Int(numF.text!)
         let num = myNumberInt! + 1
         
        specModel.payNum = num
        updatePriceAndNum()
     }
    
    func setaGoodsInfoByGoodsIdModel(_ goodsInfoByGoodsIdModel: TeSeModel,_ specModel: SpecListModel){
        self.goodsName.text =  goodsInfoByGoodsIdModel.goodsName
        self.imageV.kf.setImage(with: URL.init(string: specModel.image), placeholder: nil, options: [.forceRefresh])
        self.specName.text = specModel.specName
        self.priceLabel.text =   String(format: "%.2lf ODIN/", specModel.odinPrice) + String(format: "%.2lf BGC", specModel.shopPrice)
        self.numF.text = String(specModel.payNum)
        self.specModel  = specModel
        self.givePower.text = "+ " + String(specModel.givePower * specModel.payNum)
        self.totalPriceLabel.text =  String(format: "%.2lf ODIN/",Double(specModel.odinPrice )  * Double(specModel.payNum)) + String(format: "%.2lf BGC", Double(specModel.shopPrice) * Double(specModel.payNum))
    }
    
    func updatePriceAndNum(){
        self.numF.text = String(specModel.payNum)
        self.givePower.text = "+ " + String(specModel.givePower * specModel.payNum)
        self.totalPriceLabel.text =  String(format: "%.2lf ODIN/", specModel.odinPrice * Double(specModel.payNum)) + String(format: "%.2lf BGC", Double(specModel.shopPrice) * Double(specModel.payNum))
        if block != nil {
            block!(specModel)
        }
    }
    
    
}
