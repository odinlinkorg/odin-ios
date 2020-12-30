//
//  HomeVCLayout.swift
//  BlackGoldMall
//
//  Created by 永芯 on 2020/8/20.
//  Copyright © 2020 黑金商城. All rights reserved.
//

import UIKit
import LLCycleScrollView

class HomeVCLayout: NSObject {
    static func layout(homeVC vc:HomeViewController){
        
        var gradientLayer: CAGradientLayer!
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = vc.view.bounds
        //设置渐变的主颜色
        gradientLayer.colors = [UIColor.white.cgColor,UIColor.init(hex: 0xF1F1F1).cgColor]
        //将gradientLayer作为子layer添加到主layer上
        vc.view.layer.addSublayer(gradientLayer)
        
        
        let navView = UIView.init(frame:  CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 40.0))
        navView.backgroundColor = .clear
        let  serchBview = UIView(frame: CGRect(x: 0, y: 4, width: kScreenWidth - 65, height: 32.0))
        let btnSer = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: serchBview.width, height: serchBview.height))
        btnSer.backgroundColor = .clear
        btnSer.addTarget(vc, action: #selector(vc.serchBarButtonAction), for: .touchUpInside)
        serchBview.addSubview(btnSer)
        
        serchBview.backgroundColor = UIColor.init(hex: 0xF1F1F1)
        serchBview.radius = 16.0
        navView.addSubview(serchBview)
        
        let xinxiBtn = UIButton.init(frame: CGRect.init(x: btnSer.right + 10, y: 8.5, width: 22.5, height: 22.5))    //kScreenWidth - 17.5 - 22.5
        xinxiBtn.setImage(UIImage.init(named: "home_xiaoxi_icon"), for: .normal)
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
        
     
        let collectionLayout = UICollectionViewFlowLayout.init()
       
        let rect = CGRect(x: 0, y:  6.0, width: screenWidth, height: screenHeight - kTabBarHeight - kLiuHaiH - 44.0)
        let collectionView = UICollectionView(frame: rect, collectionViewLayout: collectionLayout)
        vc.collectionView = collectionView
        
        collectionView.register(UINib.init(nibName: "BannerViewCell", bundle: nil), forCellWithReuseIdentifier: "BannerViewCell")
                
        collectionView.register(UINib.init(nibName: "HomeCollectionCell", bundle: nil), forCellWithReuseIdentifier: "HomeCollectionCell")
        collectionView.register(UINib.init(nibName: "HomeHeaderCollectionCell", bundle: nil), forCellWithReuseIdentifier: "HomeHeaderCollectionCell")
        //
        collectionView.register(UINib.init(nibName: "HomeImageCollectionCell", bundle: nil), forCellWithReuseIdentifier: "HomeImageCollectionCell")
                
        collectionView.register(UINib.init(nibName: "HomeTjBgViewCell", bundle: nil), forCellWithReuseIdentifier: "HomeTjBgViewCell")
        collectionView.register(UINib.init(nibName: "HomeBigCollectionCell", bundle: nil), forCellWithReuseIdentifier: "HomeBigCollectionCell")
        
        collectionView.delegate = vc
        collectionView.dataSource = vc

                
        vc.view.addSubview(collectionView)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor =  .clear
        collectionView.delegate = vc
        collectionView.dataSource = vc
        collectionView.tag = 10000
        
        
        //轮播图
        vc.bannerView = LLCycleScrollView.llCycleScrollViewWithFrame(CGRect(x: 15.0 , y: 0, width: kScreenWidth - 30.0, height: (kScreenWidth - 30.0) * (150.0/345.0)))
          vc.bannerView.delegate = vc
          vc.bannerView.radiusBounds = 6
          vc.bannerView.imageViewContentMode = .scaleToFill
          vc.bannerView.backgroundColor = .clear
          collectionView.addSubview(vc.bannerView)
    }
}
