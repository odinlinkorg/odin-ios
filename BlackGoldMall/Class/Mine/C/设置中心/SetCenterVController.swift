//
//  SetCenterVController.swift
//  BlackGoldMall
//
//  Created by 永芯 on 2020/8/25.
//  Copyright © 2020 黑金商城. All rights reserved.
//

import UIKit

class SetCenterVController: BaseViewController,HSTableViewProtocol {

    @IBOutlet weak var tableView: UITableView!
    let arrTitle = ["个人资料","修改登录密码","支付密码","隐私协议","意见反馈"]
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "设置"
//        SetCenterCell
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        registerNibCell(tableView, SetCenterCell.self)
        view.backgroundColor = .white
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavTintColor(.black)
    }
    
    
    @IBAction func logoutAction(_ sender: Any) {
        
        let alert = UIAlertController.init(title: "提示", message: "确定要退出登录", preferredStyle: .alert)
                   
        alert.addAction(title: "确认", color:.red, style: .default) { (action) in
            self.userLoginOut()
            
        }
        alert.addAction(title: "取消")
        alert.show()
    }
    
    func userLoginOut(){
        NetworkManager<BaseModel>().requestModel( API.shopUserLogout, completion: { (response) in
               }) { (error) in
                
        }
        UserManager.deleteDefaults()
    }
    

}

extension SetCenterVController: UITableViewDelegate, UITableViewDataSource {

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
        let cell:SetCenterCell = cellWithTableView(tableView)
    
        cell.nrlabel.text = arrTitle[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell:SetCenterCell = tableView.cellForRow(at: indexPath) as! SetCenterCell
        switch cell.nrlabel.text {
        case "个人资料":
            navigationController?.pushViewController(PersonalDataVController.init(), animated: true)
       case "修改登录密码":
            let  vc  = ChangePasswordVController.init()
            vc.isloginPassword = true
            navigationController?.pushViewController(vc, animated: true)
        case "支付密码":
            navigationController?.pushViewController(PayPasswordListVController.init(), animated: true)
        case "隐私协议":
//            self.getPrivacyAgreement()
            let vc = WebViewController.init()
            vc.loadType = .yinsi
            vc.title = title
//            vc.urlStr = textValue
            self.navigationController?.pushViewController(vc, animated: true)
        case "意见反馈":
            navigationController?.pushViewController(FeedbackViewController.init(), animated: true)
        default:
            navigationController?.pushViewController(UIViewController.init(), animated: true)
        }
    }
}
