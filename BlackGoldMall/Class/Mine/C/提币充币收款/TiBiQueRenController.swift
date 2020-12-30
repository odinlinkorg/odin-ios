//
//  TiBiQueRenController.swift
//  BlackGoldMall
//
//  Created by 永芯 on 2020/8/24.
//  Copyright © 2020 黑金商城. All rights reserved.
//

import UIKit

class TiBiQueRenController: BaseViewController {

    @IBOutlet weak var addrsLabel: UILabel!
    
    @IBOutlet weak var numLabel: UILabel!
    
    @IBOutlet weak var serviceChargeLabel: UILabel!
    
    @IBOutlet weak var sjNumLabel: UILabel!
    
    
    typealias funBlock = (Int) -> ()
    var block : funBlock?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func bottomButtonAction(_ sender: Any) {
       self.dismiss(animated: true, completion: nil)
        block!(1)
    }
    
    func setDic(_ address: String,_ num: String,_ serviceCharge : String ,_ sjNum : String){
        addrsLabel.text = address
        numLabel.text = num
        serviceChargeLabel.text = serviceCharge
        sjNumLabel.text = sjNum
    }
    
    
    
   
    
}
