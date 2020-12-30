//
//  SystemInformsController.swift
//  BlackGoldMall
//
//  Created by 永芯 on 2020/8/30.
//  Copyright © 2020 黑金商城. All rights reserved.
//

import UIKit

class SystemInformsController: BaseViewController,HSTableViewProtocol {

    @IBOutlet weak var tableView: UITableView!
    var dataList = [SystemInformsModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "系统通知"
        // Do any additional setup after loading the view.
        addRefresh(refreshView: tableView)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        registerNibCell(tableView, SystemInformsCell.self)
       
        setupMyEmptyView(tableView: tableView)
    }
     override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            self.setNavBackgroundColor(.white)
        setNavTintColor(UIColor.init(hex: 0x121212))
        }
    override func sendNetRequest() {
        
        NetworkManager<SystemInformsModel>().requestListModel( API.shopCommonGetInform(page: curPage, pageSize: 20), completion: { (response) in
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


extension SystemInformsController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let model = self.dataList[section]
        var sectionHeaderViewLabel : UILabel!
               sectionHeaderViewLabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 50.0))
               
                  sectionHeaderViewLabel.textColor = UIColor.init(hex: 0x999999)
                  sectionHeaderViewLabel.textAlignment = .center
                  sectionHeaderViewLabel.font =  UIFont(name: "PingFang-SC-Medium", size: 12)
        sectionHeaderViewLabel.text = model.createTime
        return sectionHeaderViewLabel
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:SystemInformsCell = cellWithTableView(tableView)
         
         let model = self.dataList[indexPath.section]
        cell.atitleLabel.text =  model.title
        cell.informValue.text = model.informValue
  
      
        
        return cell
    }
    
}
