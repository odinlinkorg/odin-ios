//
//  TransferRecordController.swift
//  BlackGoldMall
//
//  Created by 永芯 on 2020/8/24.
//  Copyright © 2020 黑金商城. All rights reserved.
//

import UIKit

class TransferRecordController: BaseViewController,HSTableViewProtocol {

    @IBOutlet weak var tableView: UITableView!
    var dataList = [RecordTransModel]()
    var operateType = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        tableView.rowHeight = 80.0
        
        registerNibCell(tableView, TransferRecordCell.self)
        addRefresh(refreshView: tableView)
        setupMyEmptyView(tableView: tableView)
    }
    
    
    override func sendNetRequest(){
       
          
            NetworkManager<BaseModel>().requestModel(API.recordTrans(operateType:operateType,pageSize:"10", page: String.init(format: "%ld", self.curPage)), completion: { (response) in
                  self.endRefresh(refreshView: self.tableView)
                     
                     if self.curPage == 1 {
                        self.dataList.removeAll()
                     }
                     if let list = response?.dataArr {
                        
                        for item in list{
                            let model = RecordTransModel.init(fromDictionary: item as! [String : Any])
                            self.dataList.append(model)
                        }
                        
                         self.curPage += 1
                         self.mjFooterData(refreshView: self.tableView, listCount: list.count)
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

extension TransferRecordController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:TransferRecordCell = cellWithTableView(tableView)
        
        
        let model = self.dataList[indexPath.row]
              cell.timeLabel.text =  model.createTime
       
        switch model.type {
        case 1:
            cell.numberLabel.text = String.init(model.symbol) + String.init(format: "%.2lf", model.num) + "BGC"
        default:
            cell.numberLabel.text = String.init(model.symbol) + String.init(format: "%.2lf",model.num) + "ODIN"
        }
        
        
              switch  model.operateType {
              case "0":
                  cell.typeLabel.text = "转账"
                  cell.coinImg.image = UIImage.init(named: "type_zhuanzhang_icon")
              case "2":
                  cell.typeLabel.text = "算力空投"
                 cell.coinImg.image = UIImage.init(named: "type_suanli")
              case "1":
                  cell.typeLabel.text = "提币"
                 cell.coinImg.image = UIImage.init(named: "type_tibi")
              case "3":
                  cell.typeLabel.text = "活动赠送"
                 cell.coinImg.image = UIImage.init(named: "type_suanli")
              case "4":
                cell.typeLabel.text = "购买商品"
                 cell.coinImg.image = UIImage.init(named: "type_goumai")
              case "5":
                  cell.typeLabel.text = "充币"
                 cell.coinImg.image = UIImage.init(named: "type_chongbi")
              default:
                  cell.typeLabel.text = ""
                 cell.coinImg.image = UIImage.init(named: "")
              }
              
              switch  model.status {
                    case "0":
                        cell.stateLabel.text = "待审核"
                    case "1":
                        cell.stateLabel.text = "已审核"
                    case "2":
                        cell.stateLabel.text = "已转出(待检查）"
                   case "3":
                        cell.stateLabel.text = "已完成"
                    case "4":
                        cell.stateLabel.text = "转出失败"
                    case "5":
                        cell.stateLabel.text = "审核失败"
                    case "9":
                        cell.stateLabel.text = "收益"
                    default:
                        cell.stateLabel.text = ""
                    }
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = TransferDetailsController.init()
        let model = self.dataList[indexPath.row]
        vc.setModel(model)
        navigationController?.pushViewController(vc, animated: true)
    }
}
