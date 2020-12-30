//
//  MallViewController.swift
//  BlackGoldMall
//
//  Created by 永芯 on 2020/8/20.
//  Copyright © 2020 黑金商城. All rights reserved.
//

import UIKit
import JXSegmentedView

class MallViewController: BaseViewController,HSTableViewProtocol,HSCollectionViewProtocol {

    //segmentedDataSource一定要通过属性强持有，不然会被释放掉
    var segmentedDataSource: JXSegmentedTitleDataSource?
    var tableView: UITableView!
    var tableHeaderView: MailHeaderViewCell!
    var collectionView: UICollectionView!
    let segmentedView = JXSegmentedView()
    let titles :[String] = []
    var dataList = [GoodsCategoryModel]()
    var teSeList = [HomeGoodsModelItem]()
    var dataSeletIndex = 0
    var orderType = 0
    /**0:综合
    1:算力大到小
    2:算力小到大
    3:价格大到小
    4:价格小到大*/
    override func viewDidLoad(){
        super.viewDidLoad()
//        view.backgroundColor = .white
        tableView = tableViewConfig(CGRect(x: 0, y: kLiuHaiH + kNavBarHeight + 48.0, width: kScreenWidth, height: kScreenHeight-kLiuHaiH  - 53.0), self, self, .plain)
        registerNibCell(tableView, MallViewCell.self)
        MailVCLayout.layout(mailVC: self)
        tableView.rowHeight = 153.0
        addRefresh(refreshView: tableView)
        
    }
    
    override func clickRightItem() {
        navigationController?.pushViewController(MessageCenterVController.init(), animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(animated)
          self.setNavBackgroundColor(.clear)
          setNavTintColor(.clear)
          self.tabBarController?.tabBar.isHidden = false
    }
     
    override var preferredStatusBarStyle: UIStatusBarStyle{
    
        return .lightContent
    }
      
      
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.setNavBackgroundColor(.white)
        setNavTintColor(.black)
    }
    
    override func viewDidLayoutSubviews() {
           super.viewDidLayoutSubviews()
       }
    
    @objc func leibiaoAction(){
        let vc = TestViewController.init()
        vc.titleArr = dataList
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    override func sendNetRequest(){
//        goodsGetGoodsByOrderType
        goodsGetGoodsCategory()
    }
    
    
        @objc func serchBarButtonAction(){
    //        navigationController?.pushViewController(CXSearchViewController.init(), animated: true)
            
            let vc = CXSearchViewController.init()
            vc.view.backgroundColor = vcBoxBlack
            vc.modalPresentationStyle = .overCurrentContext;
            vc.modalTransitionStyle = .crossDissolve;
    //        vc.setDic(addressF.text!, numberF.text!, fee, sjNum)
            keyWindow?.rootViewController?.present(vc, animated: true, completion: nil)
            vc.block = { [weak self] serchText  in
                let vc = SearchResultsViewController.init()
                vc.serchText = serchText
                self?.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
    
//    获取分类下产品
    func goodsGetGoodsByOrderType(){
        let model = self.dataList[dataSeletIndex]
        let cateId = String(model.id)
        let parentCateId = String(model.pid)

        NetworkManager<HomeGoodsModelItem>().requestListModel(API.goodsGetGoodsByOrderType(cateId: cateId, parentCateId: parentCateId, goodsName: "", page: String(curPage), pageSize: "20", orderType: String(orderType)), completion: { (response) in
             self.endRefresh(refreshView: self.tableView)
            if self.curPage == 1 {
               self.teSeList.removeAll()
            }
            if let list = response?.list {
               self.teSeList.append(contentsOf: list)
               self.curPage += 1
               self.mjFooterData(refreshView: self.tableView, listCount: list.count)
           }
            


            self.tableView.reloadData()
        }) { (error) in
             self.endRefresh(refreshView: self.tableView)
            if let msg = error.message {
                MBProgressHUD.showText(msg)
            }
        }
    }
    
//    获取分类列表
    func goodsGetGoodsCategory(){
    NetworkManager<BaseModel>().requestModel(API.goodsGetGoodsCategory, completion: { (response) in
        
        self.dataList.removeAll()
        var titleArr :[String] = []
        if let arr = response?.dataArr{
            
            for item in arr {
                let model = GoodsCategoryModel.init(fromDictionary: item as! [String : Any] )
                 self.dataList.append(model)
                  titleArr.append(model.cateName)
            }
        
        }
       
        if titleArr.count > 0{
            self.goodsGetGoodsByOrderType()
        }
        self.segmentedDataSource!.titles = titleArr
        self.segmentedView.reloadData()
        self.collectionView.reloadData()
        
        
      }) { (error) in
        
          if let msg = error.message {
              MBProgressHUD.showText(msg)
          }
      }
    }
}



extension MallViewController: JXSegmentedViewDelegate {
//    func segmentedView(_ segmentedView: JXSegmentedView, didSelectedItemAt index: Int) {
//        if let dotDataSource = segmentedDataSource as? JXSegmentedDotDataSource {
//            //先更新数据源的数据
//            dotDataSource.dotStates[index] = false
//            //再调用reloadItem(at: index)
//            segmentedView.reloadItem(at: index)
//        }
//
//        navigationController?.interactivePopGestureRecognizer?.isEnabled = (segmentedView.selectedIndex == 0)
//    }
    
    
    //点击选中或者滚动选中都会调用该方法。适用于只关心选中事件，而不关心具体是点击还是滚动选中的情况。
    func segmentedView(_ segmentedView: JXSegmentedView, didSelectedItemAt index: Int) {
        dataSeletIndex = index
        collectionView.reloadData()
        self.sendNetRequest()
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



extension MallViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
      return teSeList.count
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        
        return 67.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let v = UIView.init()
//        v.backgroundColor = .red
        /**0:综合
           1:算力大到小
           2:算力小到大
           3:价格大到小
           4:价格小到大*/
        tableHeaderView.block = {[weak self] buttonTitle in
            switch buttonTitle {
            case "综合":
                self!.orderType = 0
               
            case "算力":
                if (self!.orderType == 1){
                    self!.orderType = 2
                    
                }
                else {
                    self!.orderType = 1
                }
                
            default:
                if (self!.orderType == 4){
                   self!.orderType = 3
                   
                }
                else{
                   self!.orderType = 4
                }
                
            }
            self!.tableHeaderView.asetType(self!.orderType)
            self!.goodsGetGoodsByOrderType()
        }
        
        return tableHeaderView
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:MallViewCell = cellWithTableView(tableView)
        cell.setModel(teSeList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        let model = teSeList[indexPath.row]
        let vc = MailDetailsController.init()
        vc.setgoodsId(String(model.goodsId))
        navigationController?.pushViewController(vc, animated: true)
    }

}



extension MallViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if dataList.count == 0 {
            return 0
        }
        let model = self.dataList[dataSeletIndex]
        
        if model.sonList.count >= 8{
           return 8
        }
        return model.sonList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell:MailCollectionCell = cellWithCollectionView(collectionView, indexPath: indexPath)
            cell.backgroundColor = .clear
        let model = self.dataList[dataSeletIndex]
        let sonmodel = model.sonList[indexPath.row]
        if indexPath.row == 7 {
            cell.cateName.text = "更多"
            cell.imgView.image = UIImage.init(named: "mail_gengduo")
        }else{
            cell.cateName.text = sonmodel.cateName
            cell.imgView.kf.setImage(with: URL.init(string: sonmodel.icon), placeholder: nil, options: [.forceRefresh])
        }
       
        return cell
    }

    //    MARK: - item 点击
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if  indexPath.row == 7{
            self.leibiaoAction()
            return;
        }
        
    let vc = SearchResultsViewController.init()
        let model = self.dataList[dataSeletIndex]
        let sonmodel = model.sonList[indexPath.row]
        vc.cateId = String(sonmodel.id)
        vc.parentCateId = String(sonmodel.pid)
        vc.mailDisText = sonmodel.cateName;
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                         
        return CGSize(width: (kScreenWidth - 30.0)/4, height:(209/345)*(kScreenWidth - 30.0)/2)
    }
     
    
    
    //     MARK: - 边框距离
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
          
        return  UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
       
    }
    
    //    MARK: - 行最小间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
       
        return 0.0
    }
    
//      MARK: - 列最小间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
}


