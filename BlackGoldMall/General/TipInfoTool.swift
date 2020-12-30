//
//  TipInfoTool.swift
//  Wenyishou
//
//  Created by 永芯 on 2020/6/19.
//  Copyright © 2020 永芯. All rights reserved.
//

import UIKit

struct TipInfoModel: Codable {
    var authTip: String?
    var accountTip: String?
    var chartTip: String?
}

class TipInfoTool: NSObject {
    // 认证提示语
    static func getAuthTip() -> String {
        if let dict = getTipInfo() {
            if let authTip = dict["authTip"] {
                return (authTip as! String).replacingOccurrences(of: "&nbsp;", with: " ")
//                return authTip as! String
            }
        }
        return ""
    }
    
    // 账户提示语
    static func getAccountTip() -> String {
        if let dict = getTipInfo() {
            if let authTip = dict["accountTip"] {
                return (authTip as! String).replacingOccurrences(of: "&nbsp;", with: " ")
//                return authTip as! String
            }
        }
        return ""
    }

    // 走势图提示语
    static func getChartTip() -> String {
        if let dict = getTipInfo() {
            if let authTip = dict["chartTip"] {
                return authTip as! String
            }
        }
        return ""
    }
    
    static func oneDayUpdata() {
        let curTime = Unitilty.getNowDate("yyyy-MM-dd")
        if let oldTime = UserDefaults.standard.string(forKey: "TipUpdata") {
            if curTime != oldTime {
                updataTipInfo()
            }
        } else {
            updataTipInfo()
        }
    }
    
    private static func getTipInfo() -> NSDictionary? {
        let filePath = "TipInfo.plist".docDir()
        if let dict = NSDictionary(contentsOfFile: filePath) {
            DebugLog(dict)
            return dict
        }
        updataTipInfo()
        return nil
    }
    
//    static func updataAgreement() {
//        NetworkManager<BaseModel>().requestModel(API.basicSelAll, completion: { (response) in
//            if let dict = response?.dataDict {
//                if let privacy = dict["privacyAgreement"] {
//                    if privacy is NSNull {
//                        return
//                    }
//                    UserDefaults.standard.set(privacy, forKey: "privacyAgreement")
//                }
//                if let user = dict["userAgreement"] {
//                    if user is NSNull {
//                        return
//                    }
//                    UserDefaults.standard.set(user, forKey: "userAgreement")
//                }
//            } else {
//                
//            }
//        }) { (error) in
//            if let msg = error.message {
//                MBProgressHUD.showText(msg)
//            }
//        }
//    }
    
    private static func updataTipInfo() {
        
//        NetworkManager<BaseModel>().requestModel(API.tipInfoGetTipInfo, completion: { (response) in
//            if let dict = response?.dataDict {
//                self.writeData(dict: dict)
//            } else {
//                
//            }
//        }) { (error) in
//            if let msg = error.message {
//                MBProgressHUD.showText(msg)
//            }
//        }
    }
    
    private static func writeData(dict : NSDictionary) {
        let filePath = "TipInfo.plist".docDir()

        if filePath.createDirectory() {
            if dict.write(toFile: filePath, atomically: true) {
                print("写入成功")
                let curTime = Unitilty.getNowDate("yyyy-MM-dd")
                UserDefaults.standard.setValue(curTime, forKey: "TipUpdata")
            } else {
                print("写入失败")
            }

        }
    }
    
//    static func removeRecord() {
//        let filePath = "TipInfo.plist".docDir()
//        if filePath.deleteFile() {
//            print("SearchReceipt.plist remove")
//        }
//    }

}
