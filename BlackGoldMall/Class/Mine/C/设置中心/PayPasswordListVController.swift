//
//  PayPasswordListVController.swift
//  BlackGoldMall
//
//  Created by 永芯 on 2020/8/25.
//  Copyright © 2020 黑金商城. All rights reserved.
//

import UIKit

class PayPasswordListVController: BaseViewController,HSTableViewProtocol{
    let arrTitle = ["修改支付密码","忘记支付密码"]
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "支付密码"
        tableView.separatorStyle = .none
        tableView.rowHeight = 54.0
        registerNibCell(tableView, SetCenterCell.self)
    }

}
extension PayPasswordListVController: UITableViewDelegate, UITableViewDataSource {

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
        let cell: SetCenterCell = cellWithTableView(tableView)
        
        cell.nrlabel.text = arrTitle[indexPath.row]
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell:SetCenterCell = tableView.cellForRow(at: indexPath) as! SetCenterCell
        switch cell.nrlabel.text {
        case "修改支付密码":
            let  vc  = ChangePasswordVController.init()
            vc.isloginPassword = false
            navigationController?.pushViewController(vc, animated: true)
        default:
             let  vc  = ForgetPayPasswordVC.init()                       
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
