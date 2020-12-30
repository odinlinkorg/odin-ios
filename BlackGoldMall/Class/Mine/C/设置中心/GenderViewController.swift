//
//  GenderViewController.swift
//  BlackGoldMall
//
//  Created by 永芯 on 2020/8/25.
//  Copyright © 2020 黑金商城. All rights reserved.
//

import UIKit

class GenderViewController: BaseViewController,HSTableViewProtocol{

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topView: UIView!
    let arrTitle = ["保密","男","女","取消"]
    var tableVisHidden : Bool!
    
    typealias funBlock = (String) -> ()
    var block : funBlock?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.isHidden = tableVisHidden
        datePicker.isHidden = !tableVisHidden
        topView.isHidden = !tableVisHidden
        if tableVisHidden{
            datePicker.locale = NSLocale(localeIdentifier: "zh_CN") as Locale
            datePicker.addTarget(self, action: #selector(ChangeDate),for: UIControl.Event.valueChanged)
        }else{
            tableView.separatorStyle = .none
            tableView.rowHeight = 54.0
            registerNibCell(tableView, GenderViewCell.self)
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    @IBAction func quedAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func backBtnAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    //日期选择器响应方法
    @objc func ChangeDate(datePicker : UIDatePicker){
        //更新提醒时间文本框
        let formatter = DateFormatter()
        //日期样式
        formatter.dateFormat = "yyyy年MM月dd日"
        print(formatter.string(from: datePicker.date))
        
//        GenderViewController
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


extension GenderViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrTitle.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54.0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: GenderViewCell = cellWithTableView(tableView)
        
        cell.genderLabel.text = arrTitle[indexPath.row]
        if indexPath.row == arrTitle.count-1 {
            cell.genderLabel.textColor = UIColor.init(hex: 0xDE1524)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell:GenderViewCell = tableView.cellForRow(at: indexPath) as! GenderViewCell
        switch cell.genderLabel.text {
        case "男":
            block!("0")
        case "女":
            block!("1")
        case "取消":
            return;
        default:
             block!("2")
        }
        self.dismiss(animated: true, completion: nil)
    }
    
}
