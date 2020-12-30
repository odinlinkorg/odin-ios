//
//  PersonalDataVController.swift
//  BlackGoldMall
//
//  Created by 永芯 on 2020/8/25.
//  Copyright © 2020 黑金商城. All rights reserved.
//

import UIKit

class PersonalDataVController: BaseViewController,HSTableViewProtocol {
    var userModel:UserModel!
    @IBOutlet weak var tableView: UITableView!
//    let arrTitle = ["当前手机号","头像","昵称","性别","生日","个性签名"]
    let arrTitle = ["当前手机号","头像","昵称","性别","个性签名"]
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "个人资料"
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        registerNibCell(tableView, SetCenterCell.self)
        view.backgroundColor = .white
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        userModel = UserManager.getUserModel()
        updateUser()
        tableView.reloadData()
    }
    
    func updateUser(){
        NetworkManager<UserModel>().requestModel(API.shopUserUpdateUserName(avatar: userModel.avatar, remake: userModel.remake, userName: userModel.userName, sex: userModel.sex), completion: { (response) in
            
           
            UserManager.saveUserInfo(model: self.userModel)
            
            self.tableView.reloadData()
             
              
        }) { (error) in
               if let msg = error.message {
                   MBProgressHUD.showText(msg)
               }
        }
    }
    

    func qiNiutoken(_ image:UIImage){
        NetworkManager<UserModel>().requestModel(API.shopCommonGetqiniuToken, completion: { (response) in
            if let dic = response?.dataDict{
                let token = dic["ossToken"] as! String
                QiniuManager.init().uploadFile(token, image: image) { (path) in
                    self.userModel.avatar = path
                    self.updateUser()
                }
            }
        }) { (error) in
               
            if let msg = error.message {
            
                MBProgressHUD.showText(msg)
               
            }
        }
    }


}

extension PersonalDataVController: UITableViewDelegate, UITableViewDataSource {

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
        
        switch arrTitle[indexPath.row] {
        case "当前手机号":
            cell.rightTLabel.isHidden = false
            cell.headImage.isHidden = true
            cell.qjImage.isHidden = true
            var phone = userModel.phone
            cell.rightTLabel.text = phone!.phoneNoAddAsterisk()
        case "头像":
            cell.headImage.isHidden = false
            cell.qjImage.isHidden = true
            cell.rightTLabel.isHidden = true
//            cell.qjImage.radiusBounds = cell.qjImage.width/2
            cell.headImage.kf.setImage(with: URL.init(string: userModel.avatar), placeholder: UIImage.init(named: "mine_touxiang"),options: [.forceRefresh])
        case "昵称":
            cell.rightTLabel.isHidden = false
            cell.headImage.isHidden = true
            cell.rightTLabel.text =  userModel.userName.length == 0 ? "请输入昵称" : userModel.userName
            cell.rightLayoutC.constant = 32.5
        case "性别":
            cell.rightTLabel.isHidden = false
            cell.headImage.isHidden = true
            switch userModel.sex {
            case "0":
                cell.rightTLabel.text = "男"
            case "1":
                cell.rightTLabel.text = "女"
            default:
                cell.rightTLabel.text = "保密"
            }
           
            cell.rightLayoutC.constant = 32.5
//        case "生日":
//            cell.rightTLabel.isHidden = false
//            cell.headImage.isHidden = true
//            cell.rightTLabel.text =  userModel.userName.length == 0 ? "设置生日" : userModel.userName
//            cell.rightLayoutC.constant = 32.5
        case "个性签名":
            cell.rightTLabel.isHidden = false
            cell.headImage.isHidden = true
            cell.qjImage.isHidden = true
            cell.rightTLabel.text = userModel.remake.length == 0 ? "这个人很懒，什么都没留下" : userModel.remake
            default:
            cell.rightTLabel.text = "这个人很懒，什么都没留下"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell:SetCenterCell = tableView.cellForRow(at: indexPath) as! SetCenterCell
        switch cell.nrlabel.text {
        case "昵称":
            let vc = ModifyNicknameVController.init()
            vc.title = "修改昵称"
            navigationController?.pushViewController(vc, animated: true)
        case "性别":
               let vc = GenderViewController.init()
                vc.tableVisHidden = false
                vc.view.backgroundColor = vcBoxBlack
                vc.modalPresentationStyle = .overCurrentContext;
                vc.modalTransitionStyle = .crossDissolve;
                keyWindow?.rootViewController?.present(vc, animated: true, completion: nil)
               vc.block = {[weak self] sex in
                self!.userModel.sex = sex
                self!.updateUser()
            }
//        case "生日":
//            let vc = GenderViewController.init()
//                vc.tableVisHidden = true
//                vc.view.backgroundColor = vcBoxBlack
//                vc.modalPresentationStyle = .overCurrentContext;
//                vc.modalTransitionStyle = .crossDissolve;
//                keyWindow?.rootViewController?.present(vc, animated: true, completion: nil)

        case "个性签名":
            let vc = ModifyNicknameVController.init()
            vc.title = "个性签名"
            navigationController?.pushViewController(vc, animated: true)
            
        case "头像":
            Unitilty.selectPicture(self, allowsEditing:true)
            
        default:
            return
        }
    }
}

extension PersonalDataVController : UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image : UIImage = info[UIImagePickerController.InfoKey.editedImage] as! UIImage
        picker.dismiss(animated: true) {
            self.qiNiutoken(image)
        }

    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
