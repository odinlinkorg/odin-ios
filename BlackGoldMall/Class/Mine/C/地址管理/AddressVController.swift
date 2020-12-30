//
//  AddressVController.swift
//  BlackGoldMall
//
//  Created by 永芯 on 2020/8/24.
//  Copyright © 2020 黑金商城. All rights reserved.
//

import UIKit
import MJRefresh
class AddressVController: BaseViewController,HSTableViewProtocol{

    @IBOutlet weak var tableView: UITableView!
    typealias funBlock = (AddressdzModel) -> ()
    var block : funBlock?
     var dataList = [AddressdzModel]()
     let v = UIView.init()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "收货地址"
        tableView.separatorStyle = .none
        tableView.rowHeight = 105
        registerNibCell(tableView, OrderDetailsAddressCell.self)
     
       
        
        tableView.mj_header = MJRefreshNormalHeader.init(refreshingTarget: self, refreshingAction: #selector(sendNetRequest))
        tableView.mj_footer?.isHidden = true
//          self.sendNetRequest()
        
        

    }
    override func viewWillAppear(_ animated: Bool) {
//        tableView.mj_header?.beginRefreshing(completionBlock: {
//
//        })
        super.viewWillAppear(animated)
        self.sendNetRequest()
       
    }
    

    
    @objc override func sendNetRequest(){
        
        NetworkManager<AddressdzModel>().requestModel(API.addressQuery, completion: { (response) in
            self.endRefresh(refreshView: self.tableView)
            if let list = response?.dataArr {
                DispatchQueue.main.async {
                    self.dataList.removeAll()
                    
                    for dic in list{
                        let model = AddressdzModel.init(fromDictionary: dic as! [String : Any])
                        self.dataList.append(model)
                    }
                    
                    
                    self.tableView.reloadData()
                }
             }
             
        }) { (error) in
          self.endRefresh(refreshView: self.tableView)
            if let msg = error.message {
                MBProgressHUD.showText(msg)
            }
        }
    }
    
    func addressRemove(_ aid : String)  {
        NetworkManager<BaseModel>().requestModel(API.addressRemove(aid: aid), completion: { (response) in
            
        }) { (error) in
            if let msg = error.message {
                MBProgressHUD.showText(msg)
            }
        }
    }
    



}


extension AddressVController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return dataList.count + 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 1
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       
        return v
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell:OrderDetailsAddressCell = cellWithTableView(tableView)
        cell.addBgview.isHidden = indexPath.section ==  dataList.count ? false : true
        if indexPath.section < dataList.count{
            let model = self.dataList[indexPath.section]
            cell.namel.text = model.shippingName
            cell.phonel.text = model.shippingPhone
            cell.addressl.text = model.shippingAddress
        }
        return cell
      
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if block == nil {
            let vc = AddAddressVController.init()
            if indexPath.section < dataList.count{
            vc.addresMol(self.dataList[indexPath.section])
            }
            navigationController?.pushViewController(vc, animated: true)
           
        }else{
           
            if indexPath.section < dataList.count{
                block!(self.dataList[indexPath.section])
                navigationController?.popViewController(animated: true)
            }else{
                let vc = AddAddressVController.init()
                navigationController?.pushViewController(vc, animated: true)
            }
        }
        
    }
    
    func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: true)
        tableView.setEditing(editing, animated: true)
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
       if indexPath.section < dataList.count{
            return true
        }
         return false
    }

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {

        return .delete
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let model = self.dataList[indexPath.section]
            addressRemove(String(model.id))
            self.dataList.remove(at: indexPath.section)
            tableView.reloadData()

        }
    }
    
    
   
}
