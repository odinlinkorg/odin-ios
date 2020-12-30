//
//  MineVCLayout.swift
//  BlackGoldMall
//
//  Created by 永芯 on 2020/8/23.
//  Copyright © 2020 黑金商城. All rights reserved.
//

import UIKit

class MineVCLayout: NSObject {

    static func layout(mineVC vc: MineViewController){
        let bgview = UIView.init(frame: CGRect.init(x: 0, y: -200.0, width: kScreenWidth, height: kScreenHeight + 200))
        bgview.backgroundColor = .white
        vc.view.addSubview(bgview)
        
        vc.view.addSubview(vc.tableView)
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kScreenWidth * (300/375.0) ))
        vc.tableView.tableHeaderView = headerView
               
        let topView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: (110.0/375.0)*kScreenWidth))
        headerView.addSubview(topView)
        topView.backgroundColor = .white
        let tap = UITapGestureRecognizer(target:vc.self, action:#selector(vc.tapClick(sender:)))
        topView.isUserInteractionEnabled = true
        topView.addGestureRecognizer(tap)
               
        
//        let buttn_msg = UIButton.init(frame: CGRect.init(x: kScreenWidth - 45.5, y: kLiuHaiH, width: 35.0, height: 35.0))
//        buttn_msg.setImage(UIImage.init(named: "home_xiaoxi_icon"), for: .normal)
//        topView.addSubview(buttn_msg)
        
        let userModel = UserManager.getUserModel()
        let headImg_w = Double(kScreenWidth * (60/375.0))
        vc.headImg = UIImageView.init(frame: CGRect.init(x: 32.5, y: Double(Double(topView.height) - headImg_w) / 2, width: headImg_w, height: headImg_w))
//        headImg.image = UIImage.init(named:"mine_touxiang")
        vc.headImg.kf.setImage(with: URL.init(string: (userModel?.avatar)!), placeholder: UIImage.init(named:"mine_touxiang"), options: [.forceRefresh])
        vc.headImg.radiusBounds = CGFloat(headImg_w)/2
        topView.addSubview(vc.headImg)
        
        vc.name_label = UILabel.init(frame: CGRect.init(x: vc.headImg.x + vc.headImg.width + 22.0, y: vc.headImg.y, width: kScreenWidth - (vc.headImg.x + vc.headImg.width + 30.0) , height: CGFloat(headImg_w)))
        vc.name_label.text = userModel?.userName
        vc.name_label.textColor = blackColor1
        vc.name_label.font = UIFont(name: "PingFang-SC-Bold", size: 18)
        topView.addSubview(vc.name_label)
        
        
        
        let collbgView = UIView.init(frame: CGRect.init(x: 15.0, y:topView.bottom + 20.0, width: kScreenWidth - 30.0, height: (160/345)*(kScreenWidth - 30.0)))
        collbgView.backgroundColor = .white
        collbgView.radius = 10.0
        headerView.addSubview(collbgView)
        
       
        let collectionLayout = UICollectionViewFlowLayout.init()
        let rect = CGRect(x: 0, y: 0, width: collbgView.width, height: collbgView.height)
        let collectionView = UICollectionView(frame: rect, collectionViewLayout: collectionLayout)
        vc.collectionView = collectionView
           
        collectionView.register(UINib.init(nibName: "MineCollectionCell", bundle: nil), forCellWithReuseIdentifier: "MineCollectionCell")
            
                      
        collbgView.addSubview(collectionView)
              //        collectionView.backgroundColor =  UIColor.init(hex: 0xF1F1F1)
        collectionView.backgroundColor =  .clear
        collectionView.delegate = vc
        collectionView.dataSource = vc
        
    }
    
    
}
