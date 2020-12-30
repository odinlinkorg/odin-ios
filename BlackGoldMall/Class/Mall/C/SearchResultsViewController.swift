//
//  SearchResultsViewController.swift
//  BlackGoldMall
//
//  Created by 永芯 on 2020/8/31.
//  Copyright © 2020 黑金商城. All rights reserved.
//

import UIKit

class SearchResultsViewController: BaseViewController,HSTableViewProtocol,HSCollectionViewProtocol {

    @objc var mailDisText : String?//商城分类点击进来的
    @objc var serchText : String?
     @objc  var cateId :String?
     @objc  var parentCateId:String?
    
    @IBOutlet weak var tableView: UITableView!
   
    @IBOutlet weak var jgButton: UIButton!
    var serchLabel : UILabel!
    @IBOutlet weak var slButton: UIButton!
    @IBOutlet weak var zhButton: UIButton!
    var  orderType = 0
    var teSeList = [HomeGoodsModelItem]()
    override func viewDidLoad() {
        super.viewDidLoad()
        aloadAddView()
//        addLeftNavItem("")


        tableView.separatorStyle = .none
        tableView.rowHeight = 130.0
        registerNibCell(tableView, MallViewCell.self)
        
        addRefresh(refreshView: tableView)
        setupMyEmptyView(tableView: tableView)
    }

    
    
    override func sendNetRequest() {
  
        NetworkManager<HomeGoodsModelItem>().requestListModel(API.goodsGetGoodsByOrderType(cateId: cateId ?? "", parentCateId: parentCateId ?? "", goodsName: serchText ?? "", page: String(curPage), pageSize: "20", orderType: String(orderType)), completion: { (response) in
                self.endRefresh(refreshView: self.tableView)
               if self.curPage == 1 {
                  self.teSeList.removeAll()
               }
            
            if let list = response?.list {
                self.teSeList.append(contentsOf: list)
                self.curPage += 1
                self.mjFooterData(refreshView: self.tableView, listCount: list.count)
            }
          
               self.tableView.reloadData()
             self.hide_showEmptyView(self.tableView, self.teSeList.count)
           }) { (error) in
                self.endRefresh(refreshView: self.tableView)
               if let msg = error.message {
                   MBProgressHUD.showText(msg)
               }
           }
       }

    
    func aloadAddView() {
        let navView = UIView.init(frame:  CGRect.init(x: 0, y: 5.0, width: kScreenWidth, height: 30.0))
        navView.backgroundColor = .clear
        let  serchBview = UIView(frame: CGRect(x: 0.0, y: 0, width: kScreenWidth - 65.0, height: 30.0))
        let btnSer = UIButton.init(frame: CGRect.init(x: 0.0, y: 0, width: serchBview.width - 65.0, height: serchBview.height))
        btnSer.backgroundColor = .clear
        btnSer.addTarget(self, action: #selector(serchBarButtonAction), for: .touchUpInside)
        serchBview.addSubview(btnSer)

        serchBview.backgroundColor = UIColor.init(hex: 0xF1F1F1)
        serchBview.radius = 16.0
        navView.addSubview(serchBview)

//        let backImage = UIImageView.init(frame: CGRect.init(x: 0, y: 6.5, width: 9, height: 17.0))
//        backImage.image = UIImage.init(named: "back_icon")
//        navView.addSubview(backImage)
        navigationItem.titleView = navView

        let serchImage = UIImageView.init(frame: CGRect.init(x: 13.5, y: 10, width: 12, height: 12))
        serchImage.image = UIImage.init(named: "home_sousuo_icon")
        
        serchBview.addSubview(serchImage)

        serchLabel = UILabel.init(frame: CGRect.init(x: 35.0, y: 0, width: 60, height: 32.0))
        serchLabel.text =  serchText
        if (mailDisText ?? "" ).length != 0 {
            serchLabel.text =  mailDisText
        }
        serchLabel.textColor = UIColor.init(hex: 0x999999)
        serchLabel.font = UIFont(name: "PingFang-SC-Regular", size: 13)
        serchBview.addSubview(serchLabel)
    }
    
        @objc func serchBarButtonAction(){

            let vc = CXSearchViewController.init()
            vc.view.backgroundColor = vcBoxBlack
            vc.modalPresentationStyle = .overCurrentContext;
            vc.modalTransitionStyle = .crossDissolve;
            keyWindow?.rootViewController?.present(vc, animated: true, completion: nil)
            vc.block = { [weak self] serchText  in
                self?.serchLabel.text = serchText
                self?.headerRefresh()
            }
    }
    
    
    @IBAction func buttonAction(_ sender: UIButton) {
           switch sender.titleLabel?.text {
           case "综合":
               orderType = 0
               zhButton.setTitleColor(UIColor.init(hex: 0x121212), for: .normal)
               slButton.setTitleColor(UIColor.init(hex: 0x656565), for: .normal)
               jgButton.setTitleColor(UIColor.init(hex: 0x656565), for: .normal)
           case "算力":
               zhButton.setTitleColor(UIColor.init(hex: 0x656565), for: .normal)
               slButton.setTitleColor(UIColor.init(hex: 0x121212), for: .normal)
               jgButton.setTitleColor(UIColor.init(hex: 0x656565), for: .normal)
            if (orderType == 1){
                orderType = 2
            }
            else {
                orderType = 1
            }
           default:
            
            if (orderType == 4){
               orderType = 3
               
            }
            else{
               orderType = 4
            }
               zhButton.setTitleColor(UIColor.init(hex: 0x656565), for: .normal)
               slButton.setTitleColor(UIColor.init(hex: 0x656565), for: .normal)
               jgButton.setTitleColor(UIColor.init(hex: 0x121212), for: .normal)
           }
           asetType(orderType)
        headerRefresh()
       }
       func asetType(_ type : Int){
           /**0:综合
           1:算力大到小 降序
           2:算力小到大 生序
           3:价格大到小 降序
           4:价格小到大 生序
            */
           switch type {
           case 0:
               slButton.setImage(UIImage.init(named: "mail_morenpaixu"), for: .normal)
               jgButton.setImage(UIImage.init(named: "mail_morenpaixu"), for: .normal)
           case 1:
              slButton.setImage(UIImage.init(named: "mail_jiangxu"), for: .normal)
              jgButton.setImage(UIImage.init(named: "mail_morenpaixu"), for: .normal)
           case 2:
              slButton.setImage(UIImage.init(named: "mail_shengxu"), for: .normal)
              jgButton.setImage(UIImage.init(named: "mail_morenpaixu"), for: .normal)
           case 3:
             slButton.setImage(UIImage.init(named: "mail_morenpaixu"), for: .normal)
             jgButton.setImage(UIImage.init(named: "mail_jiangxu"), for: .normal)
           
           case 4:
             slButton.setImage(UIImage.init(named: "mail_morenpaixu"), for: .normal)
             jgButton.setImage(UIImage.init(named: "mail_shengxu"), for: .normal)
           default:
               return
           }
       }
}



extension SearchResultsViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        
        return teSeList.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
       return 1
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        
        return 25.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let v = UIView.init()
        v.backgroundColor = .clear


        return v
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:MallViewCell = cellWithTableView(tableView)
        cell.setModel(teSeList[indexPath.section])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = teSeList[indexPath.section]
        let vc = MailDetailsController.init()
        vc.setgoodsId(String(model.goodsId))
        navigationController?.pushViewController(vc, animated: true)
    }

}
