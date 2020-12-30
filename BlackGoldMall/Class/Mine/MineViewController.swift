//
//  MineViewController.swift
//  BlackGoldMall
//
//  Created by 永芯 on 2020/8/20.
//  Copyright © 2020 黑金商城. All rights reserved.
//

import UIKit

class MineViewController:  BaseViewController,HSTableViewProtocol,HSCollectionViewProtocol {
    var tableView: UITableView!
    var collectionView: UICollectionView!
    let tabArr = ["填写邀请码","设置中心","当前版本"]
    let collArr = ["我的资产","收款","转账","我的订单","我的账单","地址管理","邀请好友"]
    var headImg : UIImageView!
    var name_label:UILabel!
    var version :Bool! //版本号
    var update_url:String!
    override func viewDidLoad() {
        super.viewDidLoad()
        addRightNavImgItem("home_xiaoxi_icon")
        tableView = tableViewConfig(CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight), self, self, .grouped)
        registerNibCell(tableView, MineTableCell.self)
        MineVCLayout.layout(mineVC: self)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavBackgroundColor(.white)
        setNavTintColor(.clear)
        if let model = UserManager.getUserModel(){
            headImg.kf.setImage(with: URL.init(string: (model.avatar)!), placeholder: UIImage.init(named:"mine_touxiang"), options: [.forceRefresh])
            name_label.text = model.userName
            versionGets()
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        setNavTintColor(.black)
    }
    
    //事件的代码

    @objc  func tapClick(sender:UIView){
        navigationController?.pushViewController(PersonalDataVController.init(), animated: true)
    }
    override func clickRightItem() {
        navigationController?.pushViewController(MessageCenterVController.init(), animated: true)
    }
    
    
    func versionGets() {
            //获取历史版本
            NetworkManager<BaseModel>().requestModel(API.versionGets, completion: { (response) in
                if let dict = response?.dataDict {
    //                forceUpdate
                    if let versionNo = dict["version"] as? String {
                        let curVersionNo = Bundle.hs_appBuild
                        self.update_url =  dict["update_url"] as? String
                        if versionNo > curVersionNo {
                            self.version = false
                         
                        } else{
                             self.version = true
                        }
                        self.tableView.reloadData()
                        }
                }
            }) { (error) in
                if let msg = error.message {
                    MBProgressHUD.showText(msg)
                }
            }

        }
    
    
    
    

}


extension MineViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tabArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        return 55.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MineTableCell = cellWithTableView(tableView)
        cell.coinImg.image = UIImage.init(named: "mine_" + tabArr[indexPath.row])
        cell.redView.isHidden = true
        cell.coinName.text = tabArr[indexPath.row]
        if indexPath.row == 0 {
            cell.bgView.addRounded(radius: 10, corners:  [UIRectCorner.topRight,UIRectCorner.topLeft])
        }
        if indexPath.row + 1 == tabArr.count  {
            cell.bgView.addRounded(radius: 10, corners:  [UIRectCorner.bottomLeft,UIRectCorner.bottomRight])
        }
        if indexPath.row == 2{

            if self.version != nil {
                cell.redView.isHidden = self.version
            }
            
            cell.coinName.text = "当前版本 " + Bundle.hs_appBuild
       
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell:MineTableCell = tableView.cellForRow(at: indexPath) as! MineTableCell
        if  indexPath.row == 2 {
            if self.version != nil {
                if !self.version && self.update_url != nil {
                    
                    UIApplication.shared.open(URL.init(string: self.update_url!)!, options: [:], completionHandler: nil)
                }else{
                    MBProgressHUD.showText("已是最新版本")
                }
                      
            }
        }
        switch cell.coinName.text {
        case "填写邀请码":
            let vc = InviteCodeBDVController.init()
            vc.title = "邀请码"
            navigationController?.pushViewController(vc, animated: true)
        case "设置中心":
            navigationController?.pushViewController(SetCenterVController.init(), animated: true)
        default:
            return
//            navigationController?.pushViewController(InviteCodeBDVController.init(), animated: true)
        }
        
    }
}



extension MineViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell:MineCollectionCell = cellWithCollectionView(collectionView, indexPath: indexPath)
            cell.backgroundColor = .clear
        cell.icon_img.image = UIImage.init(named: "mine_" + collArr[indexPath.row])
        cell.iconName.text = collArr[indexPath.row]
    
        return cell
            
        
    }

    //    MARK: - item 点击
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell: MineCollectionCell = collectionView.cellForItem(at: indexPath) as! MineCollectionCell
        switch cell.iconName.text  {
        case "我的资产":
            self.navigationController?.pushViewController(MyAssetsController.init(), animated: true)
        case "收款":
            self.navigationController?.pushViewController(PaymentCodeController.init(), animated: true)
        case "转账":
            self.navigationController?.pushViewController(TransferAccountsController.init(), animated: true)
        case "我的账单":
            let vc = TransferRecordController.init()
            vc.title = "我的账单"
            
            self.navigationController?.pushViewController(vc, animated: true)
        
        case "我的订单":
            self.navigationController?.pushViewController(MyOrderController.init(), animated: true)
        case "地址管理":
            self.navigationController?.pushViewController(AddressVController.init(), animated: true)
        case "邀请好友":
            self.navigationController?.pushViewController(InvitationController.init(), animated: true)
        default:
            self.navigationController?.pushViewController(MyAssetsController.init(), animated: true)
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                         
        return CGSize(width: (kScreenWidth - 30.0)/4, height:(160/345)*(kScreenWidth - 30.0)/2)
    }
     
    
    
    //     MARK: - 边框距离
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
          
        return  UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
       
    }
    
    //    MARK: - 行最小间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
       
        return 0.0
    }
    
//      MARK: - 列最小间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    
}


