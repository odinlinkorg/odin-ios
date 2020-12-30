//
//  WuLiuViewController.swift
//  BlackGoldMall
//
//  Created by 永芯 on 2020/8/31.
//  Copyright © 2020 黑金商城. All rights reserved.
//

import UIKit

class WuLiuViewController: BaseViewController,HSTableViewProtocol{

    @IBOutlet weak var tableView: UITableView!
    var querys = ""
    var dataList = [WuliuModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "物流信息"
        addRefresh(refreshView: tableView)
        tableView.separatorStyle = .none
        tableView.rowHeight =  UITableView.automaticDimension
        registerNibCell(tableView, WuLiuTableViewCell.self)
        tableView.mj_footer?.isHidden = true
    }
    
    override func sendNetRequest() {
        
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
                            self.dataList.removeAll()
                            for listson in megArr{
                               let model = WuliuModel.init(fromDictionary: listson)
                               self.dataList.append(model)
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
                print("Response body: %@" , bodyString)
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
}


extension WuLiuViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataList.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        return 0.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = self.dataList[indexPath.row]
        let cell:WuLiuTableViewCell = cellWithTableView(tableView)
        cell.statusLabel.text = model.status
        let array : Array = model.time.components(separatedBy: " ")
        cell.mLabel.text = array[0]
        cell.timeLabel.text = array[1]
        return cell
    }
    
}
