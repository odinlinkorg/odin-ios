//
//  EarningsRecordController.swift
//  BlackGoldMall
//
//  Created by 永芯 on 2020/8/21.
//  Copyright © 2020 黑金商城. All rights reserved.
//

import UIKit

class EarningsRecordController: BaseViewController,HSTableViewProtocol {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profitTotalLabel: UILabel!
     var dataList = [RecordProfitModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "收益记录"

        tableView.sectionHeaderHeight = 0.01
        tableView.sectionFooterHeight = 0.01
        tableView.rowHeight = 44.0
        tableView.separatorStyle = .none
        registerNibCell(tableView, EarningsCell.self)
        tableView.backgroundColor = .clear
                
        recordProfitTotal()
        
        addRefresh(refreshView: tableView)
        tableView.mj_footer?.isHidden = true
        setupMyEmptyView(tableView: tableView)
    }

    func recordProfitTotal()  {
      NetworkManager<BaseModel>().requestModel(API.recordProfitTotal, completion: { (response) in
       if let dic = response?.dataDict {
        let power = dic["profitTotal"]
        if power is String{
            self.profitTotalLabel.text = (power as! String) + "BGC"
        }
        else if power is NSNumber{
            self.profitTotalLabel.text = String.init(format: "%@BGC", power as! NSNumber)
        }
       }
      }) { (error) in
          if let msg = error.message {
              MBProgressHUD.showText(msg)
          }
      }
  }
    
    
        override func sendNetRequest(){
             
              NetworkManager<RecordProfitModel>().requestModel(API.recordProfit, completion: { (response) in
                self.endRefresh(refreshView: self.tableView)
                   if self.curPage == 1 {
                      self.dataList.removeAll()
                   }
                   if let arr = response?.dataArr {
                    for item in arr {
                        let model = RecordProfitModel.init(fromDictionary: item as! [String : Any])
                        self.dataList.append(model)
                    }
                    self.curPage += 1
                    self.mjFooterData(refreshView: self.tableView, listCount: arr.count)
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

        
}


extension EarningsRecordController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
       return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
        let cell:EarningsCell = cellWithTableView(tableView)
        cell.model(dataList[indexPath.row])
        cell.createTime.text = dataList[indexPath.row].symbol + " " + String(dataList[indexPath.row].num)
        cell.num.text = dataList[indexPath.row].createTime
        return cell
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
    }
    
  
}
