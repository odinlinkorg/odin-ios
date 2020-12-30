//
//  MyOrderController.swift
//  BlackGoldMall
//
//  Created by 永芯 on 2020/8/24.
//  Copyright © 2020 黑金商城. All rights reserved.
//

import UIKit
import JXSegmentedView
class MyOrderController: BaseViewController{
    var myOrderNavView : MyOrderNavView!
    var tableView : UITableView!
    var segmentedDataSource: JXSegmentedBaseDataSource!
    var collectionView: UICollectionView!
    let segmentedView = JXSegmentedView()
    let titles = ["全部", "待付款", "待发货", "待收货", "已完成"]
    var listContainerView: JXSegmentedListContainerView!
    var status = 100
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        tableView = tableViewConfig(CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight-kLiuHaiH - 44.0 - kTabBarHeight - 38.0), self, self, .plain)
//        tableView.rowHeight = 74.0
//        registerNibCell(tableView, MyOrderCell.self)
        
        MyOrderLayout.layout(myOrderVC: self)
        
        
       
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.setNavBackgroundColor(.clear)
        setNavTintColor(.clear)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        setNavTintColor(.black)
    }
    
    
    
      
        @objc func serchBarButtonAction(){
    //        navigationController?.pushViewController(CXSearchViewController.init(), animated: true)
            
            let vc = CXSearchViewController.init()
            vc.searchOrdeer = true
            vc.view.backgroundColor = vcBoxBlack
            vc.modalPresentationStyle = .overCurrentContext;
            vc.modalTransitionStyle = .crossDissolve;
    //        vc.setDic(addressF.text!, numberF.text!, fee, sjNum)
            keyWindow?.rootViewController?.present(vc, animated: true, completion: nil)
            vc.block = { [weak self] serchText  in
                let vc = SearchOrderEndVController.init()
                vc.serchText = serchText
                self?.navigationController?.pushViewController(vc, animated: true)
            }
        }

    
    
}






extension MyOrderController: JXSegmentedViewDelegate {
    //点击选中或者滚动选中都会调用该方法。适用于只关心选中事件，而不关心具体是点击还是滚动选中的情况。
   func segmentedView(_ segmentedView: JXSegmentedView, didSelectedItemAt index: Int) {
           if let dotDataSource = segmentedDataSource as? JXSegmentedDotDataSource {
               //先更新数据源的数据
               dotDataSource.dotStates[index] = false
               //再调用reloadItem(at: index)
               segmentedView.reloadItem(at: index)
           }

           navigationController?.interactivePopGestureRecognizer?.isEnabled = (segmentedView.selectedIndex == 0)
       }

    // 点击选中的情况才会调用该方法
    func segmentedView(_ segmentedView: JXSegmentedView, didClickSelectedItemAt index: Int) {
        
    }
    // 滚动选中的情况才会调用该方法
    func segmentedView(_ segmentedView: JXSegmentedView, didScrollSelectedItemAt index: Int) {
        
    }
    // 正在滚动中的回调
    func segmentedView(_ segmentedView: JXSegmentedView, scrollingFrom leftIndex: Int, to rightIndex: Int, percent: CGFloat) {
        
    }
}

extension MyOrderController: JXSegmentedListContainerViewDataSource {
    func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
        if let titleDataSource = segmentedView.dataSource as? JXSegmentedBaseDataSource {
            return titleDataSource.dataSource.count
        }
        return 0
    }


    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
        let vc = SP_ClassifiedListVC.init()
        if index == 0{
            vc.status = 100
        }else{
            vc.status = index - 1
        }
        return vc
    }
}





