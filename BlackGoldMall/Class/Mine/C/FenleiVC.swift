//
//  FenleiVC.swift
//  Wenyishou
//
//  Created by Shuai Hui on 2020/7/7.
//  Copyright © 2020 Shuai Hui. All rights reserved.
//

import UIKit
import JXSegmentedView

class FenleiVC: BaseViewController {

    var segmentedDataSource: JXSegmentedBaseDataSource?
    let segmentedView = JXSegmentedView()
    lazy var listContainerView: JXSegmentedListContainerView! = {
        return JXSegmentedListContainerView(dataSource: self)
    }()
    let titles = ["美食", "美妆", "日用", "数码", "户外"]

    override func viewDidLoad() {
        super.viewDidLoad()

        //配置数据源
        let dataSource = JXSegmentedTitleDataSource()
        dataSource.isTitleColorGradientEnabled = true
        dataSource.titleNormalColor = .darkGray
//        dataSource.titleSelectedColor = baseRedTextColor
        dataSource.isTitleZoomEnabled = false
//        dataSource.titleSelectedZoomScale = 1.2
        dataSource.isTitleStrokeWidthEnabled = true
        dataSource.isSelectedAnimable = true
        dataSource.titles = titles
        dataSource.titleNormalFont = .systemFont(ofSize: 17)
        segmentedDataSource = dataSource
        
        //配置指示器
         let indicator = JXSegmentedIndicatorLineView()
         indicator.indicatorWidth = 25
         indicator.indicatorHeight = 4
//         indicator.indicatorColor = baseRedTextColor
         
         segmentedView.indicators = [indicator]

         //segmentedViewDataSource一定要通过属性强持有！！！！！！！！！
         segmentedView.dataSource = segmentedDataSource
         segmentedView.delegate = self
         view.addSubview(segmentedView)

         segmentedView.listContainer = listContainerView
         view.addSubview(listContainerView)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        segmentedView.frame = CGRect(x: 0, y: kStatusBarHeight, width: view.bounds.size.width, height: 48)
        listContainerView.frame = CGRect(x: 0, y: segmentedView.bottom, width: view.bounds.size.width, height: view.bounds.size.height - segmentedView.bottom - kTabBarHeight)
    }

}

extension FenleiVC: JXSegmentedViewDelegate {
    func segmentedView(_ segmentedView: JXSegmentedView, didSelectedItemAt index: Int) {
        if let dotDataSource = segmentedDataSource as? JXSegmentedDotDataSource {
            //先更新数据源的数据
            dotDataSource.dotStates[index] = false
            //再调用reloadItem(at: index)
            segmentedView.reloadItem(at: index)
        }
        navigationController?.interactivePopGestureRecognizer?.isEnabled = (segmentedView.selectedIndex == 0)
    }
}

extension FenleiVC: JXSegmentedListContainerViewDataSource {
    func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
        if let titleDataSource = segmentedView.dataSource as? JXSegmentedBaseDataSource {
            return titleDataSource.dataSource.count
        }
        return 0
    }

    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
        let vc = SP_ClassifiedListVC.init()
        vc.classText = titles[index]
        return vc
    }
}
