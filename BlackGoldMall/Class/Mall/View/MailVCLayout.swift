//
//  MailVCLayout.swift
//  BlackGoldMall
//
//  Created by 永芯 on 2020/8/21.
//  Copyright © 2020 黑金商城. All rights reserved.
//

import UIKit
import JXSegmentedView
class MailVCLayout: NSObject {
    
    static func layout(mailVC vc:MallViewController){
        
//        let headBgImage = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: (324/375) * kScreenWidth))
             
        let headBgImage = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kNavBarHeight + kLiuHaiH + 50.0))
        headBgImage.image = UIImage.init(named: "mail_bg_top")
//        headBgImage.backgroundColor = .red
        vc.view.addSubview(headBgImage)
        
    
//        let navView = HomeNavView.loadFromNib()
//        navView.frame = CGRect.init(x: 0, y: iskLiuHaiH, width: kScreenWidth, height: 44.0)
//        navView.msgButton.setImage(UIImage.init(named: "mail_msg_icon"), for: .normal)
//        vc.view.addSubview(navView)



        let arr1 = Bundle.main.loadNibNamed("MailHeaderViewCell", owner: nil, options: nil)
        let tableHeaderView:MailHeaderViewCell = arr1![0]  as! MailHeaderViewCell
        tableHeaderView.frame = CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 57.0)
        vc.tableHeaderView = tableHeaderView
        
        let navView = UIView.init(frame:  CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 40.0))
       navView.backgroundColor = .clear
       let  serchBview = UIView(frame: CGRect(x: 0, y: 4, width: kScreenWidth - 65, height: 32.0))
       serchBview.backgroundColor = UIColor.init(hex: 0xF1F1F1)
       serchBview.radius = 16.0
       navView.addSubview(serchBview)
        let btnSer = UIButton.init(frame: CGRect.init(x: 15.0, y: 0, width: serchBview.width - 65.0, height: serchBview.height))
        btnSer.backgroundColor = .clear
        btnSer.addTarget(vc, action: #selector(vc.serchBarButtonAction), for: .touchUpInside)
        serchBview.addSubview(btnSer)
       
       let xinxiBtn = UIButton.init(frame: CGRect.init(x: serchBview.right + 10, y: 8.5, width: 22.5, height: 22.5))
       xinxiBtn.setImage(UIImage.init(named: "mail_msg_icon"), for: .normal)
       xinxiBtn.addTarget(vc, action: #selector(vc.clickRightItem), for: .touchUpInside)
       navView.addSubview(xinxiBtn)
       
       vc.navigationItem.titleView = navView
       
       let serchImage = UIImageView.init(frame: CGRect.init(x: 13.5, y: 10, width: 12, height: 12))
       serchImage.image = UIImage.init(named: "home_sousuo_icon")
       serchBview.addSubview(serchImage)
       
       let serchLabel = UILabel.init(frame: CGRect.init(x: 35.0, y: 0, width: 60, height: 32.0))
       serchLabel.text = "搜索商品"
       serchLabel.textColor = UIColor.init(hex: 0x999999)
       serchLabel.font = UIFont(name: "PingFang-SC-Regular", size: 13)
       serchBview.addSubview(serchLabel)
        
        
        
       
             
        let headView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: (250.0/375.0)*kScreenWidth))
//        vc.view.backgroundColor = .yellow
        
        
        let headViewImage = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: headView.height))
                headViewImage.image = UIImage.init(named: "mail_bg_bot")
        
        headView.addSubview(headViewImage)
         //配置数据源
        let dataSource = JXSegmentedTitleDataSource()
        dataSource.isTitleColorGradientEnabled = true
        dataSource.titleNormalColor = .white
        dataSource.titleSelectedColor = .white
        dataSource.isTitleZoomEnabled = true
//        dataSource.titleSelectedZoomScale = 1.2
//        dataSource.isTitleStrokeWidthEnabled = true
        dataSource.isSelectedAnimable = true
        dataSource.isItemSpacingAverageEnabled = false
        dataSource.titles = vc.titles
        dataSource.titleNormalFont = .systemFont(ofSize: 17)
        vc.segmentedDataSource = dataSource
        vc.segmentedView.frame = CGRect(x: 0, y:kLiuHaiH + kNavBarHeight, width: kScreenWidth - 63, height: 48)
        

        
        //配置指示器
         let indicator = JXSegmentedIndicatorLineView()
         indicator.indicatorWidth = 25
         indicator.indicatorHeight = 4
        indicator.indicatorColor = .white
         
        vc.segmentedView.indicators = [indicator]

         //segmentedViewDataSource一定要通过属性强持有！！！！！！！！！
        vc.segmentedView.dataSource = vc.segmentedDataSource
        vc.segmentedView.delegate = vc
        vc.view.addSubview(vc.segmentedView)
//        headView.addSubview(vc.segmentedView)
        
        
        //        mail_liebiao  kScreenWidth -  37.0
        let leibiaoButton = UIButton.init(frame: CGRect.init(x: vc.segmentedView.right + 10, y:kLiuHaiH + kNavBarHeight, width: 37.0, height: 48.0))
        leibiaoButton.setImage(UIImage.init(named: "mail_liebiao"), for: .normal)
        leibiaoButton.addTarget(vc, action: #selector(vc.leibiaoAction), for: .touchUpInside)
        vc.view.addSubview(leibiaoButton)
        
        let collbgView = UIView.init(frame: CGRect.init(x: 15.0, y: 8.0, width: kScreenWidth - 30.0, height: (209/345)*(kScreenWidth - 30.0)))
        collbgView.backgroundColor = .white
        collbgView.radius = 10.0
        headView.addSubview(collbgView)
        
        vc.tableView.backgroundColor = .clear
        vc.tableView.tableHeaderView = headView
        vc.tableView.rowHeight = 130.0
        vc.view.addSubview(vc.tableView)
        
        
        
        
     
        let collectionLayout = UICollectionViewFlowLayout.init()
        let rect = CGRect(x: 0, y: 0, width: collbgView.width, height: collbgView.height)
        let collectionView = UICollectionView(frame: rect, collectionViewLayout: collectionLayout)
        vc.collectionView = collectionView
     
        collectionView.register(UINib.init(nibName: "MailCollectionCell", bundle: nil), forCellWithReuseIdentifier: "MailCollectionCell")
      
                
        collbgView.addSubview(collectionView)
        //        collectionView.backgroundColor =  UIColor.init(hex: 0xF1F1F1)
        collectionView.backgroundColor =  .clear
        collectionView.delegate = vc
        collectionView.dataSource = vc
    }
}
