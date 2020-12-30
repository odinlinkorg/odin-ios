//
//  ZhuanQuLayout.swift
//  BlackGoldMall
//
//  Created by 永芯 on 2020/8/28.
//  Copyright © 2020 黑金商城. All rights reserved.
//

import UIKit

import JXSegmentedView
class ZhuanQuLayout: NSObject {
    static func layout(zhuanquVC vc:ZhuanQuViewController){
        
        
        
        let collectionLayout1 = UICollectionViewFlowLayout.init()
        collectionLayout1.scrollDirection = .horizontal
        let rect1 = CGRect(x: 0, y: 0, width: screenWidth, height:67.0)
        let collectionViewtop = UICollectionView(frame: rect1, collectionViewLayout: collectionLayout1)
        collectionViewtop.backgroundColor = .white

          
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 10;
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        flowLayout.scrollDirection = .horizontal
        //===== CELL 约束自适应 必备条件 1 =====
        flowLayout.estimatedItemSize = CGSize(width: 15, height: 67.0)
        
        collectionViewtop.collectionViewLayout = flowLayout
        collectionViewtop.register(UINib.init(nibName: "TopLeiBieViewCell", bundle: nil), forCellWithReuseIdentifier: "TopLeiBieViewCell")
        collectionViewtop.delegate = vc
        collectionViewtop.dataSource = vc
        collectionViewtop.showsHorizontalScrollIndicator = false

        collectionViewtop.collectionViewLayout.invalidateLayout()
        collectionViewtop.reloadData()
        vc.collectionViewTop = collectionViewtop
        vc.view.addSubview(vc.collectionViewTop)
        
        
        

     
        let collectionLayout = UICollectionViewFlowLayout.init()
        //collectionLayout.scrollDirection = .horizontal
              
        let rect = CGRect(x: 0, y: 67.0, width: screenWidth, height: screenHeight - kTabBarHeight - kLiuHaiH - 44.0 - 67.0)
        
        let collectionView = UICollectionView(frame: rect, collectionViewLayout: collectionLayout)
         collectionView.register(UINib.init(nibName: "HomeBigCollectionCell", bundle: nil), forCellWithReuseIdentifier: "HomeBigCollectionCell")
        collectionView.backgroundColor = .clear
        collectionView.delegate = vc
        collectionView.dataSource = vc
        vc.collectionView = collectionView
        vc.view.addSubview(vc.collectionView)
        
        collectionView.mj_footer?.isHidden = true
        
        
        //配置数据源
        let dataSource = JXSegmentedTitleDataSource()
        dataSource.isTitleColorGradientEnabled = true
        dataSource.titleNormalColor = .red
        dataSource.titleSelectedColor = .red
        
    }
}
