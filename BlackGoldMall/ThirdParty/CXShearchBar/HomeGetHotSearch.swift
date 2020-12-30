//
//  HomeGetHotSearch.swift
//  BlackGoldMall
//
//  Created by 永芯 on 2020/8/31.
//  Copyright © 2020 黑金商城. All rights reserved.
//

import UIKit

class HomeGetHotSearch: NSObject {
    typealias funBlock = (Array<Any>) -> ()
 @objc   var block : funBlock?
 @objc     func getHotSearch() {
        
        NetworkManager<BaseModel>().requestModel(API.homeGetHotSearch, completion: { (response) in
            if let arr = response?.dataArr{
                self.block!(arr as! Array<Any>)
            }
        }) { (error) in
            if let msg = error.message {
                MBProgressHUD.showText(msg)
            }
           
        }
    }
}
