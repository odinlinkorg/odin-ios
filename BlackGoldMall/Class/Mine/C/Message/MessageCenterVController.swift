//
//  MessageCenterVController.swift
//  BlackGoldMall
//
//  Created by 永芯 on 2020/8/31.
//  Copyright © 2020 黑金商城. All rights reserved.
//

import UIKit

class MessageCenterVController: BaseViewController,HSTableViewProtocol {
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "订单通知"
        // Do any additional setup after loading the view.
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.rowHeight = 120
        registerNibCell(tableView, MessageCenterCell.self)
    }


}
extension MessageCenterVController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        return 0.01
    }
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MessageCenterCell = cellWithTableView(tableView)
        cell.atitLabel.text = indexPath.row == 0 ? "订单通知" : "系统通知"
        cell.imageV.image = UIImage.init(named: indexPath.row == 0 ? "mine_dingdantongzhi" :"mine_xitongtognzhi")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell:MessageCenterCell = tableView.cellForRow(at: indexPath) as! MessageCenterCell
        switch cell.atitLabel.text  {
        case "订单通知":
            navigationController?.pushViewController(OrderMessageViewController.init(), animated: true)
        default:
            navigationController?.pushViewController(SystemInformsController.init(), animated: true)
        }
        
    }
}
