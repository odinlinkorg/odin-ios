//
//  AddressPickerViewController.swift
//  XHYKProduct
//
//  Created by luyongpeng on 2020/7/28.
//  Copyright © 2020 Swift. All rights reserved.
//

import UIKit

class AddressPickerViewController: BaseViewController,UIPickerViewDataSource,UIPickerViewDelegate {

    @IBOutlet weak var pickerView: UIPickerView!
    typealias funBlock = (String) -> ()
    var block : funBlock?
    var coinName : String?
    lazy  var items = ["ODIN","BGC"]
    override func viewDidLoad() {
        super.viewDidLoad()

       // Do any additional setup after loading the view.
     
       //设置PickerView默认值
       pickerView.selectRow(0, inComponent: 0, animated: true)
       coinName = items[0]
    }

    @IBAction func determineAction(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
        block!(coinName!)
    }
    
    @IBAction func closeAction(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
       
          

    //设置PickerView列数(dataSourse协议)
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    //设置PickerView行数(dataSourse协议)
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 2
    }
    //设置PickerView选项内容(delegate协议)
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return items[row]
    }
    //设置列宽
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        
            return kScreenWidth
    }


//设置行高
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50
    }
    
    //检测响应选项的选择状态
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(String(row)+"-"+String(component))
        coinName = items[row]
    }
    
}
