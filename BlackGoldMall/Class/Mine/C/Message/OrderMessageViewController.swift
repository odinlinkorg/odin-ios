//
//  OrderMessageViewController.swift
//  BlackGoldMall
//
//  Created by 永芯 on 2020/8/31.
//  Copyright © 2020 黑金商城. All rights reserved.
//

import UIKit

class OrderMessageViewController: BaseViewController,HSTableViewProtocol {
    var dataList = [MyOrderListModel]()

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "订单通知"
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.rowHeight = 130
        registerNibCell(tableView, OrderMessageViewCell.self)
        addRefresh(refreshView: tableView)
        setupMyEmptyView(tableView: tableView)
    }
    
    
    
    
    
      override func sendNetRequest(){
        NetworkManager<MyOrderListModel>().requestListModel(API.orderRecordMyOrderList(page: curPage, pageSize: 20, status: 3,orderNum:""), completion: { (response) in
            self.endRefresh(refreshView: self.tableView)
            if self.curPage == 1 {
                self.dataList.removeAll()
            }
            if let list = response?.list {
                self.dataList.append(contentsOf: list)
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

    extension OrderMessageViewController: UITableViewDelegate, UITableViewDataSource {

        func numberOfSections(in tableView: UITableView) -> Int {
            return dataList.count
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
        }
        
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell:OrderMessageViewCell = cellWithTableView(tableView)
            cell.asetMyOrderModel(dataList[indexPath.section])
            
            return cell
        }
   
        
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            navigationController?.pushViewController(OrderDetailsVController.init(), animated: true)
        }
   
}






