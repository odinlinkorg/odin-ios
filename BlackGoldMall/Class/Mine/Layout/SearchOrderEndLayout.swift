//
//  SearchOrderEndLayout.swift
//  BlackGoldMall
//
//  Created by 永芯 on 2020/9/1.
//  Copyright © 2020 黑金商城. All rights reserved.
//

import UIKit

class SearchOrderEndLayout: NSObject {
    static func layout(SearchVC vc: SearchOrderEndVController){
        let navView = UIView.init(frame:  CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 40.0))
           navView.backgroundColor = .clear
           let  serchBview = UIView(frame: CGRect(x: 0, y: 5, width: kScreenWidth - 65, height: 30.0))
           let btnSer = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: serchBview.width - 65.0, height: serchBview.height))
           btnSer.backgroundColor = .clear
           btnSer.addTarget(vc, action: #selector(vc.serchBarButtonAction), for: .touchUpInside)
           serchBview.addSubview(btnSer)

           serchBview.backgroundColor = UIColor.init(hex: 0xF1F1F1)
           serchBview.radius = 16.0
           navView.addSubview(serchBview)
           vc.navigationItem.titleView = navView
           
           let serchImage = UIImageView.init(frame: CGRect.init(x: 13.5, y: 9, width: 12, height: 12))
           serchImage.image = UIImage.init(named: "home_sousuo_icon")
           serchBview.addSubview(serchImage)
           
           let serchLabel = UILabel.init(frame: CGRect.init(x: 35.0, y: 0, width:kScreenWidth - 110 , height: 30.0))
           serchLabel.text = "搜索订单号"
           serchLabel.textColor = UIColor.init(hex: 0x999999)
           serchLabel.font = UIFont(name: "PingFang-SC-Regular", size: 13)
           serchBview.addSubview(serchLabel)
        vc.serchLabel = serchLabel
                
            
        }
    }
