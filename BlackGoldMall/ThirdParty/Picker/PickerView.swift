//
//  PickerView.swift
//
//  Created by Filipe Alvarenga on 19/05/15.
//  Copyright (c) 2015 Filipe Alvarenga. All rights reserved.
//

import UIKit

/// pickerView类型
///
/// - address//地址:
/// - date//时间:
/// - gender//性别:
public enum PickerViewStyle {
     case address  // 地址
     case date     // 时间
     case gender   // 性别
}

/// PickerDelegate
protocol PickerDelegate {
     
     func selectedAddress(_ pickerView : PickerView,_ procince : AddressModel,_ city : AddressModel,_ area : AddressModel)
     func selectedDate(_ pickerView : PickerView,_ dateStr : Date)
     func selectedGender(_ pickerView : PickerView,_ genderStr : String)
}


class PickerView: UIView {
     
     
    var pickerDelegate : PickerDelegate?
    private var pickerStyle: PickerViewStyle?
    private let pickerH : CGFloat! = 260 * (kScreenHeight/667)
    private var addressPicker : UIPickerView = UIPickerView()
    private var datePicker : UIDatePicker = UIDatePicker()
    private var genderPicker : UIPickerView = UIPickerView()
    private var backgroundButton : UIButton = UIButton()
    private var dataArray = [AddressModel]()
    private var cityArray = [AddressModel]()
    private var districtArray = [AddressModel]()
    private var selectedProvince = AddressModel()
    private var selectedCity = AddressModel()
    private var selectedDistrict = AddressModel()
    private var selectedGender = String()
    var isAddress : Bool?
     
     // MARK: - 初始化UI
    init(_ delegate : PickerDelegate,_ style : PickerViewStyle){
          
        dataArray.removeAll()
        pickerDelegate = delegate
        pickerStyle = style
        self.pickerStyle = style
        let frame = CGRect.init(x: 0, y: kScreenHeight, width: kScreenWidth, height: kScreenHeight)
        super.init(frame: frame)
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
        view.backgroundColor = .init(red: 230, green: 230, blue: 230)
        self.addSubview(view)
          
          // 取消按钮
        let cancelButton = UIButton.init(type: .custom)
        cancelButton.frame = CGRect.init(x: 0, y: 0, width: 60, height: 44)
        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        cancelButton.setTitle("取 消", for: .normal)
        cancelButton.setTitleColor(.init(red: 18, green: 93, blue: 255), for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelButtonClick), for: .touchUpInside)
        self.addSubview(cancelButton)
          
          // 确定按钮
        let doneButton = UIButton.init(type: .custom)
        doneButton.frame = CGRect.init(x: kScreenWidth - 60, y: 0, width: 60, height: 44)
        doneButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        doneButton.setTitle("确 定", for: .normal)
        doneButton.setTitleColor(.init(red: 18, green: 93, blue: 255), for: .normal)
        doneButton.addTarget(self, action: #selector(doneButtonClick), for: .touchUpInside)
        self.addSubview(doneButton)
          
        backgroundButton = UIButton.init(type: .system)
          backgroundButton.frame = CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight)
        backgroundButton.backgroundColor = .init(white: 0, alpha: 0)
        backgroundButton.addTarget(self, action: #selector(cancelButtonClick), for: .touchUpInside)
        switch style {
        case .address:
            addressPicker = UIPickerView.init(frame: CGRect.init(x: 0, y: 44, width: kScreenWidth, height: pickerH - 44))
            addressPicker.delegate = self
            addressPicker.dataSource = self
            addressPicker.backgroundColor = UIColor.white
            isAddress = true
            self.addSubview(addressPicker)
            case .date:
            datePicker = UIDatePicker.init(frame: CGRect.init(x: 0, y: 44, width: kScreenWidth, height: pickerH - 44))
            datePicker.datePickerMode = .date
            datePicker.locale = Locale.init(identifier: "zh_CN")
            datePicker.backgroundColor = UIColor.white
            datePicker.addTarget(self, action: #selector(PickerView.dateSelected(_:)), for: .valueChanged)
            datePicker.setDate(Date(), animated: true)
        self.addSubview(datePicker)
        case .gender:
            genderPicker = UIPickerView.init(frame: CGRect.init(x: 0, y: 44, width: kScreenWidth, height: pickerH - 44))
            genderPicker.delegate = self
            genderPicker.dataSource = self
            genderPicker.backgroundColor = UIColor.white
            isAddress = false
            self.addSubview(genderPicker)
        }
        if pickerStyle != PickerViewStyle.date {
        switch isAddress {
        case true:
            self.getAddressData()
        default:
            var model1 = AddressModel.init()
            model1.region_name = "男"
            var model2 = AddressModel.init()
            model2.region_name = "女"
            dataArray = [model1, model2]
            self.pickerView(genderPicker, didSelectRow: 0, inComponent: 0)
        }
  }
     }
     required init?(coder aDecoder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
     }
     // MARK: - Method
     
     /// 取消按钮点击方法
     @objc func cancelButtonClick(){
          
          self.pickerViewHidden()
     }
     
     /// 确定按钮点击方法
     @objc func doneButtonClick(){
          
          if pickerStyle == .address {
               pickerDelegate?.selectedAddress(self, selectedProvince, selectedCity, selectedDistrict)
          }else if pickerStyle == .date{
               pickerDelegate?.selectedDate(self, datePicker.date)
          }else{
               pickerDelegate?.selectedGender(self, selectedGender)
          }
          self.pickerViewHidden()
     }
     /// 时间选择
     ///
     /// - Parameter datePicker: 时间选择器
     @objc func dateSelected(_ datePicker: UIDatePicker) {
          
          
     }
     
     /// 读取省市区数据
     func getAddressData() {
          
        dataArray.removeAll()
        let path = Bundle.main.path(forResource:"pca", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        do {
            let addressData = try Data(contentsOf: url)
            let provinceArray = try! JSONSerialization.jsonObject(with: addressData, options: JSONSerialization.ReadingOptions.mutableContainers) as! [[String: Any]]
            for dict in provinceArray {
                var provinceM = AddressModel.init()
                provinceM.region_name = dict["region_name"] as? String
                provinceM.region_id = dict["region_id"] as? String
                provinceM.agency_id = dict["agency_id"] as? String
                provinceM.parent_id = dict["parent_id"] as? String
                provinceM.region_type = dict["region_type"] as? String
                provinceM.childs = dict["childs"] as? [[String: Any]]
                self.dataArray.append(provinceM)
            }
            self.pickerView(addressPicker, didSelectRow: 0, inComponent: 0)
        } catch _ {
            print("读取本地数据出现错误!")
        }
     }
    
     /// 展示pickerView
     public func pickerViewShow() {
          
        let keyWindow = UIApplication.shared.keyWindow
        keyWindow?.addSubview(self.backgroundButton)
        keyWindow?.addSubview(self)
        UIView.animate(withDuration: 0.3, animations: {
            self.backgroundButton.backgroundColor = .init(white: 0, alpha: 0.3)
//            self.y = kScreenHeight - self.pickerH
            self.frame.origin.y = kScreenHeight - self.pickerH
        }) { (complete: Bool) in
        }
     }
     /// 隐藏pickerView
     public func pickerViewHidden() {
        UIView.animate(withDuration: 0.3, animations: {
            self.backgroundButton.backgroundColor = .init(white: 0, alpha: 0)
            self.frame.origin.y = kScreenHeight
        }) { (complete:Bool) in
            self.removeFromSuperview()
            self.backgroundButton.removeFromSuperview()
        }
     }

}

extension PickerView: UIPickerViewDelegate, UIPickerViewDataSource {
    
    /// 返回列
    ///
    /// - Parameter pickerView: pickerView
    /// - Returns: 列
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
         switch isAddress {
         case true:
              return 3
         default:
              return 1
         }
    }
    
    /// 返回对应列的行数
    ///
    /// - Parameters:
    ///   - pickerView: pickerView
    ///   - component: 列
    /// - Returns: 行
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
         
         switch isAddress {
         case true:
              if component == 0{
                   return dataArray.count
              }else if component == 1{
                   return cityArray.count
              }else{
                   return districtArray.count
              }
         default:
              return dataArray.count
         }
    }
    
    /// 返回对应行的title
    ///
    /// - Parameters:
    ///   - pickerView: pickerView
    ///   - row: 行
    ///   - component: 列
    /// - Returns: title
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       var title = ""
       switch isAddress {
       case true:
           if component == 0{
           let provinceM = dataArray[row]
           title = provinceM.region_name ?? "未知"
           return title
       }else if component == 1{
           let cityModel = cityArray[row]
           title = cityModel.region_name ?? "未知"
           return title
       }else{
           let areaModel = districtArray[row]
           title = areaModel.region_name ?? "未知"
           return title
       }
       default:
           title = dataArray[row].region_name ?? "未知"
           return title
       }
    }
    
    /// 选择列、行
    ///
    /// - Parameters:
    ///   - pickerView: pickerView
    ///   - row: 行
    ///   - component: 列
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
         
         switch isAddress {
         case true:
              if component == 0 {
               let provinceM = dataArray[row]
                   let cityDicArray = provinceM.childs!
                   cityArray.removeAll()
                   for cityDic in cityDicArray {
                        var cityM = AddressModel.init()
                        cityM.region_name = cityDic["region_name"] as? String
                        cityM.region_id = cityDic["region_id"] as? String
                        cityM.agency_id = cityDic["agency_id"] as? String
                        cityM.parent_id = cityDic["parent_id"] as? String
                        cityM.region_type = cityDic["region_type"] as? String
                        cityM.childs = cityDic["childs"] as? [[String: Any]]
                        cityArray.append(cityM)
                   }
                   // 默认选择当前省的第一个城市对应的区县
                   self.pickerView(pickerView, didSelectRow: 0, inComponent: 1)
                   selectedProvince = provinceM
              }else if component == 1 {
                   let cityModel = cityArray[row]
                   let areaArray = cityModel.childs!
                   districtArray.removeAll()
                   for areaDic in areaArray {
                        var areaModel = AddressModel.init()
                        areaModel.region_name = areaDic["region_name"] as? String
                        areaModel.region_id = areaDic["region_id"] as? String
                        areaModel.agency_id = areaDic["agency_id"] as? String
                        areaModel.parent_id = areaDic["parent_id"] as? String
                        areaModel.region_type = areaDic["region_type"] as? String
                        districtArray.append(areaModel)
                   }
                   selectedCity = cityModel
                   self.pickerView(pickerView, didSelectRow: 0, inComponent: 2)
              }else{
                   let areaModel = districtArray[row]
                   selectedDistrict = areaModel
              }
              pickerView.reloadAllComponents()
       default:
           selectedGender = dataArray[row].region_name ?? "未知"
           
       }
    }
}
