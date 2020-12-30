//
//  MyOrderLayout.swift
//  BlackGoldMall
//
//  Created by 永芯 on 2020/8/24.
//  Copyright © 2020 黑金商城. All rights reserved.
//

import UIKit
import JXSegmentedView


class MyOrderLayout: NSObject {

    static func layout(myOrderVC vc:MyOrderController){
    
//        let navView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height:kLiuHaiH + 44.0))
//        navView.backgroundColor = .white
//        vc.view.addSubview(navView)
//
//        vc.navigationItem.titleView = navView
//
//
//        let myOrderNavView = MyOrderNavView.loadFromNib()
//        myOrderNavView.frame = CGRect.init(x: 0, y: kLiuHaiH, width: kScreenWidth, height: 44.0)
//
//        navView.addSubview(myOrderNavView)
//        vc.addLeftNavItem("")
        
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
        
        let serchLabel = UILabel.init(frame: CGRect.init(x: 35.0, y: 0, width: 100, height: 30.0))
        serchLabel.text = "搜索订单号"
        serchLabel.textColor = UIColor.init(hex: 0x999999)
        serchLabel.font = UIFont(name: "PingFang-SC-Regular", size: 13)
        serchBview.addSubview(serchLabel)
        
        
        let headView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 48.0))
        //        vc.view.backgroundColor = .yellow
                 //配置数据源
        let dataSource = JXSegmentedTitleDataSource()
        dataSource.isTitleColorGradientEnabled = true
        dataSource.titleNormalColor =  blackColor2
        dataSource.titleSelectedColor = baseTabTextColor
        dataSource.isTitleZoomEnabled = true
        //        dataSource.titleSelectedZoomScale = 1.2
//                dataSource.isTitleStrokeWidthEnabled = true
        dataSource.isSelectedAnimable = true
        dataSource.titles = vc.titles
        dataSource.titleNormalFont = .systemFont(ofSize: 17)
        vc.segmentedDataSource = dataSource
        vc.segmentedView.frame = CGRect(x: 0, y:0, width: kScreenWidth , height: 48)
                
        
                
        //配置指示器
         let indicator = JXSegmentedIndicatorLineView()
         indicator.indicatorWidth = 25
         indicator.indicatorHeight = 4
        indicator.indicatorColor = baseTabTextColor
         
        vc.segmentedView.indicators = [indicator]

         //segmentedViewDataSource一定要通过属性强持有！！！！！！！！！
        vc.segmentedView.dataSource = vc.segmentedDataSource
        vc.segmentedView.delegate = vc
        
        headView.addSubview(vc.segmentedView)
        vc.view.addSubview(headView)
        
//        vc.listContainerView = JXSegmentedListContainerView(dataSource: vc)
//        vc.view.addSubview(vc.listContainerView)
//        //关联cotentScrollView，关联之后才可以互相联动！！！
//        vc.segmentedView.contentScrollView = vc.listContainerView.scrollView
        vc.listContainerView = JXSegmentedListContainerView(dataSource: vc)
        vc.listContainerView.frame = CGRect(x: 0, y: headView.bottom, width: kScreenWidth, height:kScreenHeight - 48.0 - kNavBarHeight - kLiuHaiH - 15.0 )
        vc.view.addSubview(vc.listContainerView)
        //关联cotentScrollView，关联之后才可以互相联动！！！
        vc.segmentedView.listContainer = vc.listContainerView
        
      
                
        
       
    }
}
