//
//  AddressListTableCell.swift
//  anyouliang
//
//  Created by 永芯 on 2020/7/17.
//  Copyright © 2020 永芯. All rights reserved.
//

import UIKit

class AddressListTableCell: UITableViewCell {

    @IBOutlet var buttons: [UIButton]!
    
    var dataDict: [String: String]!
    
//    var provinceList: [String]?//省模型
//    var cityList: [String]?//市模型
//    var areaList: [String]?
//
//    var provinceStr = ""//省
//    var cityStr = ""//市
//    var area = ""//区
        
    
    @IBAction func querenAction(_ sender: Any) {
        
        if let shen = buttons[0].currentTitle, let shi = buttons[1].currentTitle, let xian = buttons[2].currentTitle {
//            if !shen.isChinese() {
//                MBProgressHUD.showText("请输入省份")
//                return
//            }
//            if !shi.isChinese() {
//                MBProgressHUD.showText("请输入市")
//                return
//            }
//            if !xian.isChinese() {
//                MBProgressHUD.showText("请输入县")
//                return
//            }
            MBProgressHUD.showText("保存中", afterDelay: 1)
            let dict = ["shen":shen,"shi":shi,"xian":xian]
            UserDefaults.standard.set(dict, forKey: "address")
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) { () -> Void in
                for tf in self.buttons {
                    tf.isEnabled = false
                }
                self.viewController()?.navigationController?.popViewController(animated: true)
            }
        }

    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func clickProvince(_ sender: UIButton) {
        let pickerView = PickerView.init(self, .address)
        pickerView.pickerViewShow()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension AddressListTableCell: PickerDelegate {
    func selectedAddress(_ pickerView: PickerView, _ procince: AddressModel, _ city: AddressModel, _ area: AddressModel) {
        buttons[0].setTitle(procince.region_name, for: .normal)
        buttons[1].setTitle(city.region_name, for: .normal)
        buttons[2].setTitle(area.region_name, for: .normal)
    }
    
    func selectedDate(_ pickerView: PickerView, _ dateStr: Date) {
        
    }
    
    func selectedGender(_ pickerView: PickerView, _ genderStr: String) {
        
    }
    

}
