//
//  MyAssetsLayout.swift
//  BlackGoldMall
//
//  Created by 永芯 on 2020/8/24.
//  Copyright © 2020 黑金商城. All rights reserved.
//

import UIKit

class MyAssetsLayout: NSObject {
    static func layout(mineVC vc: MyAssetsController){
        vc.topView = MyAssetsHeadView.loadFromNib()
        vc.topView.frame = CGRect.init(x: 0, y: 0, width: kScreenWidth, height: (178/375.0)*kScreenWidth)
        vc.tableView.tableHeaderView = vc.topView
        vc.tableView.backgroundColor = vcBackLightGrayColor
        vc.view.addSubview(vc.tableView)
        
        
        vc.sectionHeaderView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 108.0))
        vc.sectionHeaderView.backgroundColor = vcBackLightGrayColor
        let sectionLabel = UILabel.init(frame: CGRect.init(x: 15.0, y: 25.0, width: kScreenWidth - 35.0, height: 20.0))
        sectionLabel.text = "交易记录"
        sectionLabel.textColor = blackColor1
        sectionLabel.font = UIFont(name: "PingFang-SC-Bold", size: 18)
        vc.sectionHeaderView.addSubview(sectionLabel)
        
        vc.mineHeaderView = MineHeaderView.loadFromNib()
        vc.mineHeaderView.frame = CGRect.init(x: 0, y: sectionLabel.bottom + 15.0, width: kScreenWidth, height: 50.0)
        vc.sectionHeaderView.addSubview(vc.mineHeaderView)
        
        
        vc.mineHeaderView.allButton.addTarget(vc, action: #selector(vc.buttonAction(_:)), for: .touchUpInside)
        vc.mineHeaderView.chongbiButton.addTarget(vc, action: #selector(vc.buttonAction(_:)), for: .touchUpInside)
        vc.mineHeaderView.tibiButton.addTarget(vc, action: #selector(vc.buttonAction(_:)), for: .touchUpInside)
        
    }
}
