//
//  SuanLiViewController.swift
//  BlackGoldMall
//
//  Created by 永芯 on 2020/8/20.
//  Copyright © 2020 黑金商城. All rights reserved.
//

import UIKit

class SuanLiViewController: BaseViewController {

    var count = 0
    @IBOutlet weak var timeLabel: UILabel!
    var myTimer: ZJTimer!
    var killTimer:ZJKillTimer!
    @IBOutlet weak var powerLabel: UILabel!
    var killTimerT:ZJKillTimer!
    @IBOutlet weak var totalPowerLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "算力池" 
        addRightNavImgItem("home_xiaoxi_icon")
        djs()
    }
    
    override func clickRightItem() {
        navigationController?.pushViewController(MessageCenterVController.init(), animated: true)
    }

    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           powerTota()
        powerQuery()
           //seconds根据实际计算（活动结束时间减去当前时间得出的秒数）
        
       }
    
    @IBAction func suanliAction(_ sender: Any) {
        navigationController?.pushViewController(SuanLiDetailController.init(), animated: true)
    }
    
    @IBAction func shouyiAction(_ sender: Any) {
        navigationController?.pushViewController(EarningsRecordController.init(), animated: true)
    }
    
    func powerTota()  {
        NetworkManager<BaseModel>().requestModel(API.powerTota, completion: { (response) in
            if let dic = response?.dataDict {
                let totalPower = dic["totalPower"] as! String
                self.totalPowerLabel.text = "全网总算力 " + totalPower
            }
        }) { (error) in
            if let msg = error.message {
                MBProgressHUD.showText(msg)
            }
        }
    }
    
    func powerQuery()  {
        NetworkManager<BaseModel>().requestModel(API.apiPowerQuery, completion: { (response) in
         if let dic = response?.dataDict {
             let power = dic["power"] as! NSNumber
             self.powerLabel.text = "个人算力 " + String(format: "%@", power)
         }
        }) { (error) in
            if let msg = error.message {
                MBProgressHUD.showText(msg)
            }
        }
    }
    
    
    
    
    func djs(){

         if killTimer != nil{
             killTimer.secondsToEnd = 0
               killTimer = nil
         }
         
         
          let curCalendar:NSCalendar = NSCalendar.current as NSCalendar

          let aformatter = DateFormatter()
          aformatter.dateFormat = "yyyy-MM-dd"
          aformatter.timeZone = TimeZone.init(secondsFromGMT: 0)
          let  dates = aformatter.string(from: Date())
          let datesH = dates + " 11:00:00"

          var dateresult = stringConvertDate(string: datesH)
          let datadq =
               stringConvertDate(string: Unitilty.getNowDate())
          // date1 < date2 升序排列
          if dateresult.compare(datadq) == .orderedAscending || dateresult.compare(datadq) == .orderedSame
          {
                print("<")
              dateresult = curCalendar.date(byAdding: NSCalendar.Unit.hour, value:  24, to: dateresult as Date, options: NSCalendar.Options())!

          }
          let gregorian = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
          let result = gregorian!.components(NSCalendar.Unit.second, from: datadq, to:dateresult as Date, options: NSCalendar.Options())
        
        if timeLabel != nil{

            killTimer = ZJKillTimer(seconds:result.second! + 2, callBack: {[weak self] (text) in
               
                   self!.timeLabel.text = text
                if text == "00:00:00"{
                    self!.djs()
                }
            })
        }
     }
     
     
     
    
     
     
     func stringConvertDate(string:String, dateFormat:String="yyyy-MM-dd HH:mm:ss") -> Date {
         let dateFormatter = DateFormatter.init()
         dateFormatter.timeZone = TimeZone.init(secondsFromGMT: 0)
         dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
         let date = dateFormatter.date(from: string)
         return date!
     }
    
    

}
