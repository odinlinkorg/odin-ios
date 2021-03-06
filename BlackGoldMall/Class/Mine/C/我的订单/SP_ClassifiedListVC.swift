//
//  SP_ClassifiedListVC.swift
//  BlackGoldMall
//
//  Created by 永芯 on 2020/8/21.
//  Copyright © 2020 黑金商城. All rights reserved.
//

import UIKit
import JXSegmentedView

class SP_ClassifiedListVC: BaseViewController, HSTableViewProtocol {

    var tableView : UITableView!
    var classText = ""
    var sectionView = UIView()
    var dataList = [MyOrderListModel]()
   
    var status = 100
    override func viewDidLoad() {
        super.viewDidLoad()
//        title = classText
        title = "订单详情"
        tableView = tableViewConfig(CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight-kLiuHaiH - 44.0), self, self, .plain)
//        tableView.rowHeight = 246.0
        tableView.sectionHeaderHeight = 15.0
        tableView.backgroundColor = .clear
        view.addSubview(tableView)
        registerNibCell(tableView, MyOrderCell.self)
        addRefresh(refreshView: tableView)
        sendNetRequest()
        setupMyEmptyView(tableView: tableView)
    }
    

    
        override func sendNetRequest(){
            NetworkManager<MyOrderListModel>().requestListModel(API.orderRecordMyOrderList(page: curPage, pageSize: 20, status: status,orderNum : ""), completion: { (response) in
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
    
    
  
    func orderCancel(_ orderId :String){
        
        
        let alert = UIAlertController.init(title: "取消订单", message: "订单一旦取消，无法恢复", preferredStyle: .alert)
                 
        
        alert.addAction(title: "确定取消", color:UIColor.init(hex: 0xDD1524), style: .default) { (action) in
         
            NetworkManager<BaseModel>().requestModel(API.orderCancel(orderId: orderId), completion: { (response) in
                       MBProgressHUD.showText("订单已取消")
                      self.headerRefresh()
                    }) { (error) in
                    if let msg = error.message {
                        MBProgressHUD.showText(msg)
                    }
                    }
            
        }
        alert.addAction(title: "暂不取消",color:UIColor.init(hex: 0x999999))
        alert.show()
    }
    
    func orderReceipt(_ orderId :String)  {
         NetworkManager<BaseModel>().requestModel(API.orderReceipt(orderId: orderId), completion: { (response) in
            MBProgressHUD.showText("订单已确认收货")
           self.headerRefresh()
         }) { (error) in
         if let msg = error.message {
             MBProgressHUD.showText(msg)
         }
         }
    }
    
    func orderPay(_ password:String,_ orderId:String){
        NetworkManager<BaseModel>().requestModel(API.orderPay(insidePayPassword: password, orderId: orderId), completion: { (response) in
           MBProgressHUD.showText("订单已提交")
            self.headerRefresh()
      }) { (error) in
      if let msg = error.message {
          MBProgressHUD.showText(msg)
      }
      }
    }
    func pushPassword(_ orderId:String){
           let vc = InputPasswordVC.init()
           vc.view.backgroundColor = vcBoxBlack
           vc.modalPresentationStyle = .overCurrentContext;
           vc.modalTransitionStyle = .crossDissolve;
        
           keyWindow?.rootViewController?.present(vc, animated: true, completion: nil)
               vc.inputFinish = { [weak self] d in
                   self?.orderPay(d,orderId)
               }
       }
    
    func buttonTitleAction(_ buttonTitle:String,_ section : Int){
        let model = dataList[section]
        switch buttonTitle {
        case "取消订单":
            orderCancel(String(model.orderId))
        case "查看物流":
            let vc = WuLiuViewController.init()
            vc.querys = model.logisticsNumber
            navigationController?.pushViewController(vc, animated: true)
        case "立即付款":
            pushPassword(String(model.orderId))
        case "确认收货":
            orderReceipt(String(model.orderId))
        default:
            return
        }
        
       
    }
    
}

extension SP_ClassifiedListVC: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return sectionView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MyOrderCell = cellWithTableView(tableView)
        cell.asetMyOrderModel(dataList[indexPath.section])
        cell.block = {[weak self] buttonTitle in
            self!.buttonTitleAction(buttonTitle,indexPath.section)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let aMyOrderListModel = dataList[indexPath.section]
      
        if aMyOrderListModel.status == 4  || aMyOrderListModel.status == 3 || aMyOrderListModel.status == 99 ||  aMyOrderListModel.status == 1 {
            return 206.0
        }
        
        return 246.0
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = OrderDetailsVController.init()
        vc.model = dataList[indexPath.section]
        navigationController?.pushViewController(vc, animated: true)
    }
}



extension SP_ClassifiedListVC: JXSegmentedListContainerViewListDelegate {
    func listView() -> UIView {
        return view
    }
}
