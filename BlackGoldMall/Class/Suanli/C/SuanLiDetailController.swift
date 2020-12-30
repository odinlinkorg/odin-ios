//
//  SuanLiDetailController.swift
//  BlackGoldMall
//
//  Created by 永芯 on 2020/8/21.
//  Copyright © 2020 黑金商城. All rights reserved.
//

import UIKit

class SuanLiDetailController: BaseViewController,HSTableViewProtocol {

    @IBOutlet weak var powerLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var dataList = [SuanLiDetail]()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "算力记录"
        tableView.sectionHeaderHeight = 0.01
        tableView.sectionFooterHeight = 0.01
        tableView.rowHeight = 76
        tableView.separatorStyle = .none
        registerNibCell(tableView, SuanLiDetailCell.self)
        tableView.backgroundColor = .clear

        addRefresh(refreshView: tableView)
        tableView.mj_footer?.isHidden = true
        setupMyEmptyView(tableView: tableView)
        powerQuery()
    }
    
    override func sendNetRequest(){
          
          NetworkManager<SuanLiDetail>().requestListModel(API.recordPower, completion: { (response) in
            self.endRefresh(refreshView: self.tableView)
               self.dataList.removeAll()
               if let list = response?.list {
                self.dataList.append(contentsOf: list)
               }
               self.tableView.reloadData()
            self.hide_showEmptyView(self.tableView, self.dataList.count)
          }) { (error) in
            self.endRefresh(refreshView: self.tableView)
              if let msg = error.message {
                  MBProgressHUD.showText(msg)
              }
          }
      }

    
    
    func powerQuery()  {
           NetworkManager<BaseModel>().requestModel(API.apiPowerQuery, completion: { (response) in
            if let dic = response?.dataDict {
                let power = dic["power"] as! NSNumber
                self.powerLabel.text = String(format: "%@", power)
            }
           }) { (error) in
               if let msg = error.message {
                   MBProgressHUD.showText(msg)
               }
           }
       }
}


extension SuanLiDetailController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
       return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
        let cell:SuanLiDetailCell = cellWithTableView(tableView)
        let model = self.dataList[indexPath.row]
        if indexPath.row == 0 {
            cell.lineView.isHidden = true
        }
        switch model.remark {
        case "1":
            cell.remarkLabel.text = "好友邀请"
        case "2":
            cell.remarkLabel.text = "购买商品"
        default:
            cell.remarkLabel.text = "好友购买商品"
        }
        if model.operateType == "add"  {
            cell.powerLabel.text = "+" + String(model.power)
        }else{
            cell.powerLabel.text = "-" + String(model.power)
        }
        cell.createTimeLabel.text = model.createTime
        
        return cell
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
    }
}

