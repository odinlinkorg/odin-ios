//
//  InvitedRecordViewController.swift
//  BlackGoldMall
//
//  Created by 永芯 on 2020/8/25.
//  Copyright © 2020 黑金商城. All rights reserved.
//

import UIKit

class InvitedRecordViewController: BaseViewController,HSTableViewProtocol{

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mineLabel: UILabel!
    @IBOutlet weak var friendLabel: UILabel!
    
    @IBOutlet weak var mySuanLi: UILabel!
    
    @IBOutlet weak var addSuanLi: UILabel!
    var dataList :[InvitedRecordListModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "邀请记录"
        // Do any additional setup after loading the view. EarningsCell
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        registerNibCell(tableView, EarningsCell.self)
        addRefresh(refreshView: tableView)
        setupMyEmptyView(tableView: tableView)
    }

    
//    func powerQuery()  {
//              NetworkManager<BaseModel>().requestModel(API.apiPowerQuery, completion: { (response) in
//               if let dic = response?.dataDict {
//                   let power = dic["power"] as! NSNumber
//                   self.mySuanLi.text = String(format: "%@", power)
//               }
//              }) { (error) in
//                  if let msg = error.message {
//                      MBProgressHUD.showText(msg)
//                  }
//              }
//          }

    
    override func sendNetRequest() {
//        powerQuery()
        NetworkManager<BaseModel>().requestModel( API.shopUserGetInviteLog(page: curPage, pageSize: 20), completion: { (response) in
            self.endRefresh(refreshView: self.tableView)
            if let dic = response?.dataDict{
                let userAddPower = dic["userAddPower"] as! String
                let power = dic["userPower"] as! String
                
                self.addSuanLi.text = String.init(format: "%@", userAddPower)
                self.mySuanLi.text = String(format: "%@", power)
                if self.curPage == 1 {
                   self.dataList.removeAll()
                }
                if let arr = dic["invitedUserPower"] {
                    let arrlx : [Dictionary] = arr as! [Dictionary<String, Any>]
                    for dic in arrlx {
                        let model = InvitedRecordListModel.init(fromDictionary:dic)
                        self.dataList.append(model)
                    }                    
                }
                self.mjFooterData(refreshView: self.tableView, listCount: self.dataList.count)
                self.tableView.reloadData()
               self.hide_showEmptyView(self.tableView, self.dataList.count)
            }
  
          }) { (error) in
            self.endRefresh(refreshView: self.tableView)
              if let msg = error.message {
                  MBProgressHUD.showText(msg)
              }
          }
    }
    
    
 

}

extension InvitedRecordViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      
       
        return 40.0
    }
   

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:EarningsCell = cellWithTableView(tableView)
        let model = dataList[indexPath.row]
//        cell.operateType.text = model.loginName.phoneNoAddAsterisk()
        cell.operateType.text = "***********"
        cell.createTime.text = model.createTime
        cell.num.text = model.power
        return cell
            
        
    }
}
