//
//  MyAssetsController.swift
//  BlackGoldMall
//
//  Created by 永芯 on 2020/8/24.
//  Copyright © 2020 黑金商城. All rights reserved.
//

import UIKit

class MyAssetsController: BaseViewController,HSTableViewProtocol{
    
    var tableView: UITableView!
    var topView: MyAssetsHeadView!
    var sectionHeaderView: UIView!
    var mineHeaderView: MineHeaderView!
    var dataList = [RecordTransModel]()
    var operateType = "6"
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "我的资产"
        tableView = tableViewConfig(CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight-kLiuHaiH - 44.0 - kTabBarHeight - 38.0), self, self, .plain)
//        tableView.rowHeight = 74.0
         registerNibCell(tableView, MyAssetsCell.self)
         registerNibCell(tableView, NoDataViewCell.self)
        
        MyAssetsLayout.layout(mineVC: self)
    
//       setupMyEmptyView(tableView: tableView)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        walletBalance()
         addRefresh(refreshView: tableView)
        
         headerRefresh()
        
    }
    
    @objc func buttonAction(_ sender: UIButton){
        switch sender {
        case mineHeaderView.allButton:
            operateType = "6"
            
        case mineHeaderView.tibiButton:
            operateType = "1"
        default:
            operateType = "5"
        }
        
        headerRefresh()
    }
    
    
    func walletBalance()  {
       
        NetworkManager<BaseModel>().requestModel(API.userWalletBalance, completion: { (response) in
           if let dict = response?.dataDict {
            let  availableOdin = dict["availableOdin"] as! NSNumber
            self.topView.availableOdin.text = String.init(format: "%@",availableOdin)
            
            
            let  availableBgc = dict["availableBgc"] as! NSNumber
            self.topView.availableBgc.text = String.init(format: "%@",availableBgc)
            
            let freezeBgc = dict["freezeBgc"] as! NSNumber
            self.topView.freezeBgc.text = String.init(format: "%@",freezeBgc)
            
            let freezeOdin = dict["freezeOdin"] as! NSNumber
            self.topView.freezeOdin.text = String.init(format: "%@",freezeOdin)
            
            }
        }) { (error) in
            if let msg = error.message {
                MBProgressHUD.showText(msg)
            }
        }
    }
    
    override func sendNetRequest(){
//        RecordTransModel
        
        NetworkManager<BaseModel>().requestModel(API.recordTrans(operateType:operateType,pageSize:"10", page: String.init(format: "%ld", self.curPage)), completion: { (response) in
                  self.endRefresh(refreshView: self.tableView)
                     if self.curPage == 1 {
                        self.dataList.removeAll()
                     }
                     
            if let list = response?.dataArr {
                for item in list {
                    let model = RecordTransModel.init(fromDictionary: item as! [String : Any])
                    self.dataList.append(model)
                }
                self.curPage += 1
                self.mjFooterData(refreshView: self.tableView, listCount: list.count)
                     
            }
//            self.hide_showEmptyView(self.tableView, self.dataList.count)
            self.tableView.reloadData()
                }) { (error) in
                  self.endRefresh(refreshView: self.tableView)
                    if let msg = error.message {
                        MBProgressHUD.showText(msg)
                    }
                }
    }
    
    
    @IBAction func chongbiAction(_ sender: Any) {
        navigationController?.pushViewController(ChongBiController.init(), animated: true)
    }
    
    @IBAction func tiBiAction(_ sender: Any) {
        navigationController?.pushViewController(TiBiViewController.init(), animated: true)
    }
    
    
}
extension MyAssetsController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.dataList.count == 0{
            return 1
        }
        return self.dataList.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.dataList.count == 0{
                 
            return kScreenWidth
            
        }
        return 74.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        
        return 108.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return sectionHeaderView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if(dataList.count == 0){
            let cell:NoDataViewCell = cellWithTableView(tableView)
            
            return cell
        }
        
        let cell:MyAssetsCell = cellWithTableView(tableView)
         
         let model = self.dataList[indexPath.row]
        
        cell.createTimeLabel.text =  model.createTime
      
        
        switch model.type {
                  case 1:
                      cell.numLabel.text  = String.init(model.symbol) + String.init(model.num) + "BGC"
                  default:
                     cell.numLabel.text  = String.init(model.symbol) + String.init(model.num) + "ODIN"
                  }
  
        switch  model.operateType {
        case "1":
            cell.operateTypeLabel.text = "提币"
        case "5":
            cell.operateTypeLabel.text = "充币"
        default:
            cell.operateTypeLabel.text = "提币"
        }
        
        switch  model.status {
              case "0":
                  cell.statusLabel.text = "待审核"
              case "1":
                  cell.statusLabel.text = "已审核"
              case "2":
                  cell.statusLabel.text = "已转出(待检查）"
             case "3":
                  cell.statusLabel.text = "已完成"
              case "4":
                  cell.statusLabel.text = "转出失败"
              case "5":
                  cell.statusLabel.text = "审核失败"
             case "9":
                   cell.statusLabel.text = "收益"
              default:
                  cell.statusLabel.text = ""
              }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.dataList.count == 0{
            return
        }
        let vc = TransferDetailsController.init()
        let model = self.dataList[indexPath.row]
        vc.setModel(model)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
