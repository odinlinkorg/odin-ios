//
//  OrderDetailsVController.swift
//  BlackGoldMall
//
//  Created by 永芯 on 2020/8/24.
//  Copyright © 2020 黑金商城. All rights reserved.
//

import UIKit

class OrderDetailsVController: BaseViewController,HSTableViewProtocol{

    @IBOutlet weak var tableView: UITableView!
    var model : MyOrderListModel!
     var wuliuList = [WuliuModel]()
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "订单详情"
        tableView.backgroundColor = vcBackLightGrayColor
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        registerNibCell(tableView, OrderDetailsCardCell.self)
        registerNibCell(tableView, OrderDetailsAddressCell.self)
        registerNibCell(tableView, OrderDetailsInformationCell.self)
         registerNibCell(tableView, WuLiuViewCell.self)
        
        registerNibCell(tableView, MyOrderCell.self)
        
        updateButton()
        
        
        var navVCArr : [UIViewController] = navigationController!.viewControllers
        for vc in navVCArr {
            if vc.isKind(of: ConfirmOrderVController.self) {
                navVCArr.remove(vc)
            }
        }
        navigationController?.viewControllers = navVCArr
    }
    
    
    func updateButton (){
        leftButton.addBorder(width: 1, borderColor: UIColor.init(hex: 0xDE1524))
        switch model.status {
               case 0:
                   leftButton.setTitle("取消订单", for: .normal)
                   rightButton.setTitle("立即付款", for: .normal)
                   leftButton.isHidden = false
                   rightButton.isHidden = false
               case 1:
                  
                   leftButton.setTitle("取消订单", for: .normal)
                   rightButton.setTitle("立即付款", for: .normal)
                   leftButton.isHidden = true
                   rightButton.isHidden = true
               case 2:
                   leftButton.setTitle("查看物流", for: .normal)
                   rightButton.setTitle("确认收货", for: .normal)
                   leftButton.isHidden = false
                   rightButton.isHidden = false
               default:
                   leftButton.isHidden = true
                   rightButton.isHidden = true
               }
        
        if self.model.logisticsNumber.length > 0{
            self.wuliu(self.model.logisticsNumber)
        }
    }
    @IBAction func buttonsAction(_ sender: UIButton) {
        
      
        switch sender.titleLabel?.text {
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
    
    
    override func sendNetRequest() {
    
        NetworkManager<BaseModel>().requestModel(API.orderRecordOrderInfo(orderId: String(model.orderId)), completion: { (response) in
            if let data = response?.dataDict{
                self.model = MyOrderListModel.init(fromDictionary: data as! [String : Any])
                
                
                self.tableView.reloadData()
                self.updateButton();
            }
           }) { (error) in
           if let msg = error.message {
               MBProgressHUD.showText(msg)
           }
           }
         
     }
    
    
    
    func wuliu(_ querys:String ) {
              
              let appcode = "cc8327f464b446daa79fb1865e4e243e";//开通服务后 买家中心-查看AppCode
              let host = "https://kdwlcxf.market.alicloudapi.com";
              let path = "/kdwlcx";
              let method = "GET";
      //        let querys = "?no=780098068058&type=zto";
              let urlString = String.init(format: "%@%@?no=%@",  host,  path , querys)
                
      //        let bodys = "";
              
              //默认session配置
              let config = URLSessionConfiguration.default
              let session = URLSession(configuration: config)
              
              let url : NSURL =  NSURL(string: urlString)! as URL as URL as NSURL
              var request = URLRequest(url: url as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 30)
              request.httpMethod = method
              request.addValue(String.init(format:"APPCODE %@" ,  appcode), forHTTPHeaderField: "Authorization")
      //         let session = URLSession.shared
              self.endRefresh(refreshView: self.tableView)
               let dataTask = session.dataTask(with: request) { (data, respons, error) in
                          
                  if data != nil {
                      
                      if let dic = self.dataToDictionary(data: data!){
                           if let status = dic["status"] {
                              switch status as! String {
                              case "0":
                                  DispatchQueue.main.async {
                                  let result = dic["result"] as! Dictionary<String, Any>
                                  let megArr = result["list"] as! Array<Dictionary<String, Any>>
                                  self.wuliuList.removeAll()
                                  for listson in megArr{
                                     let model = WuliuModel.init(fromDictionary: listson)
                                     self.wuliuList.append(model)
                                      
                                  }
                                  self.tableView.reloadData()
                                  }
                              case "210":
                                  MBProgressHUD.showText("快递单号错误")
                              
                              case "203":
                                  MBProgressHUD.showText("快递公司不存在")
                              
                              case "204":
                                  MBProgressHUD.showText("快递公司识别失败")
                              
                              case "205":
                                  MBProgressHUD.showText("没有信息")
                              case "207":
                                  MBProgressHUD.showText("该单号被限制，错误单号")
                              default:
                                  return
                              }

                          }
                      }
                                     
                      let bodyString = String.init(data: data!, encoding: .utf8)
                      //打印应答中的body
//                      print("Response body: %@" , bodyString)
                  }
                 
               }
               dataTask.resume()

          }
          
      func dataToDictionary(data:Data) ->Dictionary<String, Any>?{

      do{
          let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
          let dic = json as! Dictionary<String, Any>
          return dic
      }catch _ {
              print("失败")
      return nil
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
            self.sendNetRequest()
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
     
    
}


extension OrderDetailsVController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 1
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        switch indexPath.section {
//        case 0:
//            return 100
//        case 1:
//            return 72.0
//        case 2:
//            return 190.0
//        default:
//            return 190.0
//        }
//    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let v = UIView.init()
        v.backgroundColor = .clear
        return v
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell:OrderDetailsCardCell = cellWithTableView(tableView)
             cell.model(model)
            return cell
        case 1:
            if wuliuList.count > 0{
                let cell:WuLiuViewCell = cellWithTableView(tableView)
                cell.wuliuMessage.text = wuliuList[0].status
                return cell
            }
            let cell:OrderDetailsAddressCell = cellWithTableView(tableView)
                        
            cell.model(model)
            return cell
        case 2:
            let cell:MyOrderCell = cellWithTableView(tableView)
            cell.asetMyOrderModel(model)
            cell.buttonH.constant = 0.0
            cell.leftButton.isHidden = true
            cell.rightButton.isHidden = true
            return cell
        case 3:
            let cell:OrderDetailsInformationCell = cellWithTableView(tableView)
            cell.model(model);
            return cell
        default:
            let cell:OrderDetailsInformationCell = cellWithTableView(tableView)
            cell.model(model);
            return cell
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 1{
        if wuliuList.count > 0{
           
            let vc = WuLiuViewController.init()
             vc.querys = model.logisticsNumber
             navigationController?.pushViewController(vc, animated: true)
          
            }
            
        }

    }
}
