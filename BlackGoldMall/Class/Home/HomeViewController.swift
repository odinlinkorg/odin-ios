//
//  HomeViewController.swift
//  BlackGoldMall
//
//  Created by 永芯 on 2020/8/20.
//  Copyright © 2020 黑金商城. All rights reserved.
//

import UIKit
import LLCycleScrollView

class HomeViewController: BaseViewController,HSCollectionViewProtocol{

//    lazy var items = ["9块9","限时秒杀","高算热销","吃喝玩乐","猜你喜欢"]
    var bannerView: LLCycleScrollView!
    var collectionView : UICollectionView!

    //首页轮播
    var slideshowList = Array<FeatureListModel>.init()
    //特色轮播
    var featureList =  Array<FeatureListModel>.init()
    //首页活动
    var homeActivityList = [HomeActivityListModel]()
    //特色商品列表
    var teSeList = [HomeGoodsModelItem]()
    var tuiJianList = [HomeGoodsModelItem]()
    override func viewDidLoad() {
        super.viewDidLoad()
        HomeVCLayout.layout(homeVC: self)
        collectionView.reloadData()
       
        addRefresh(refreshView: collectionView)
        collectionView.mj_footer?.isHidden = true
    }

    override func clickRightItem() {
        navigationController?.pushViewController(MessageCenterVController.init(), animated: true)
    }
    
    @objc func serchBarButtonAction(){
        let vc = CXSearchViewController.init()
        vc.view.backgroundColor = vcBoxBlack
        vc.modalPresentationStyle = .overCurrentContext;
        vc.modalTransitionStyle = .crossDissolve;
        keyWindow?.rootViewController?.present(vc, animated: true, completion: nil)
        vc.block = { [weak self] serchText  in
            let vc = SearchResultsViewController.init()
            vc.serchText = serchText
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavBackgroundColor(.white)
        setNavTintColor(.clear)
        self.tabBarController?.tabBar.isHidden = false
          self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        setNavTintColor(.black)
    }
    override func sendNetRequest() {
         getHomeImg()
         homeGetHomeActivity()
         homeGetHomeGoods()
    }
    
    func getHomeImg()  {
        NetworkManager<BaseModel>().requestModel(API.homeGetHomeImg, completion: { (response) in
            self.endRefresh(refreshView: self.collectionView)
            if let dic = response?.dataDict{
           let slideshowList : Array<Dictionary<String, Any>>
                        = dic["slideshowList"] as! Array<Dictionary<String, Any>>
                
          let featureList : Array<Dictionary<String, Any>>
                = dic["featureList"] as! Array<Dictionary<String, Any>>
        
               
                var slideshowListPath = Array<String>.init()
                self.slideshowList.removeAll()
                for dicA in slideshowList{
                    let model =  FeatureListModel.init(fromDictionary: dicA)
                    slideshowListPath.append(model.imgUrl)
                    self.slideshowList.append(model)
                }
                
                self.bannerView.imagePaths = slideshowListPath
                self.featureList.removeAll()
                for dicA in featureList{
                    let model =  FeatureListModel.init(fromDictionary: dicA)
                    self.featureList.append(model)
                }
                self.collectionView.reloadData()
            }
        }) { (error) in
            self.endRefresh(refreshView: self.collectionView)
            if let msg = error.message {
                MBProgressHUD.showText(msg)
            }
        }
    }
//    获取首页活动
    func homeGetHomeActivity() {
        NetworkManager<HomeActivityListModel>().requestListModel(API.homeGetHomeActivity, completion: { (response) in
            self.homeActivityList.removeAll()
            self.endRefresh(refreshView: self.collectionView)
            if let list = response?.list {
                self.homeActivityList.append(contentsOf: list)
            }
            self.collectionView.reloadData()
        }) { (error) in
            self.endRefresh(refreshView: self.collectionView)
        if let msg = error.message {
            MBProgressHUD.showText(msg)
        }
        }
      
    }
    
// 获取首页商品
    func homeGetHomeGoods(){
        NetworkManager<HomeGoodsModel>().requestModel(API.homeGetHomeGoods, completion: { (response) in
            self.endRefresh(refreshView: self.collectionView)
            if  let model = response?.data{
                    self.teSeList.removeAll()
                    self.teSeList.append(contentsOf: model.featureList)
                               
                    self.tuiJianList.removeAll()
                    self.tuiJianList.append(contentsOf: model.recommendList)
                    self.collectionView.reloadData()
                }
            }) { (error) in
                self.endRefresh(refreshView: self.collectionView)
                if let msg = error.message {
                MBProgressHUD.showText(msg)
                }
        }
    }
    
    
    func  didSelectItemAtImag(_ model:FeatureListModel)  {
               switch model.imgType {
               case 1:
                   let vc = MailDetailsController.init()
                   vc.setgoodsId(String(model.goodsId))
                   self.navigationController?.pushViewController(vc, animated: true)
                  
               case 2:
                   let vc = WebViewController.init()
                   vc.urlStr = model.url
                   self.navigationController?.pushViewController(vc, animated: true)
               default:
                   return
               }
    }
}



extension HomeViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if  collectionView.tag != 10000{
            return 1
        }
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if  collectionView.tag != 10000{
            return self.teSeList.count
        }else{
            if section == 0{
                return homeActivityList.count
            }else if section == 5{
                return tuiJianList.count
            }
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print(collectionView.tag)
        if collectionView.tag !=  10000 {
            let cell:HomeSmallCollectionVCell = cellWithCollectionView(collectionView, indexPath: indexPath)
            cell.setModel(teSeList[indexPath.row])
            return cell
            
        }else{
            if indexPath.section == 0{
                let cell:HomeCollectionCell = cellWithCollectionView(collectionView, indexPath: indexPath)
                let model = homeActivityList[indexPath.row]
                cell.iconImage.kf.setImage(with: URL.init(string: model.icon), placeholder: nil, options:[.forceRefresh])
                cell.icon_name.text = model.title
                return cell
            }
        else if indexPath.section == 1 || indexPath.section == 4{

            let cell:HomeHeaderCollectionCell = cellWithCollectionView(collectionView, indexPath: indexPath)
            if indexPath.section == 4 {
                cell.leftLabel.text = "为你推荐"
                cell.rightLabel.text = "Recommend"
            }else{
                cell.leftLabel.text = "特色专区"
                cell.rightLabel.text = "Features Area"
                }
            return cell
        }

        else if indexPath.section == 2 {
            let cell:HomeImageCollectionCell = cellWithCollectionView(collectionView, indexPath: indexPath)
                if featureList.count != 0{
                    let model = featureList[0]
                    cell.imageV.kf.setImage(with: URL.init(string: model.imgUrl), placeholder: nil, options:[.forceRefresh])
                }
            return cell
        }
        
        else if indexPath.section == 3 {
            let cell:HomeTjBgViewCell = cellWithCollectionView(collectionView, indexPath: indexPath)
            cell.collectionView.delegate = self
            cell.collectionView.dataSource = self
            cell.collectionView.register(UINib.init(nibName: "HomeSmallCollectionVCell", bundle: nil), forCellWithReuseIdentifier: "HomeSmallCollectionVCell")
            cell.collectionView.tag = 1001
            cell.collectionView.reloadData()
            return cell
        }
        
            let cell:HomeBigCollectionCell = cellWithCollectionView(collectionView, indexPath: indexPath)
            cell.setModel(tuiJianList[indexPath.row])
            cell.backgroundColor = .white
            return cell
            
        }
    }

    //    MARK: - item 点击
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView.tag != 1001 && indexPath.section == 0{
            let vc = ZhuanQuViewController.init()
            let model = homeActivityList[indexPath.row]
            vc.setModel(model)
            vc.title = model.title
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if collectionView.tag == 1001
        {
            let model = teSeList[indexPath.row]
            let vc = MailDetailsController.init()
            vc.setgoodsId(String(model.goodsId))
            navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.section == 5{
            let model = teSeList[indexPath.row]
            let vc = MailDetailsController.init()
            vc.setgoodsId(String(model.goodsId))
            navigationController?.pushViewController(vc, animated: true)
//             print("se: %ld,row %ld",indexPath.section,indexPath.row)
        }
        
        else if indexPath.section == 2{
            let model = self.featureList[0]
            self.didSelectItemAtImag(model)
        }
       
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let ls_w =  screenWidth / 375.0
        if collectionView.tag !=  10000 {
            let itemW = (screenWidth - 30) / 3
            return CGSize(width: ceil(itemW), height: 165.0 * ls_w)
         
        }else{
        if indexPath.section == 0 {
            let itemW = (screenWidth - 30.0)/CGFloat(homeActivityList.count)
            return CGSize(width: itemW, height: 85.0 * ls_w)
        }
        
        else if indexPath.section == 1 || indexPath.section == 4{
            let itemW = screenWidth - 20.0
            return CGSize(width: itemW, height: 20.0)
       }
        
        else if indexPath.section == 2 {
            let itemW = (screenWidth - 30.0)
            return CGSize(width: itemW, height: 105.0)
        }
        
        else if indexPath.section == 3 {
//            let itemW = (screenWidth - 30.0)/3
//            return CGSize(width: ceil(itemW), height: 165.0)
//            let itemW = (screenWidth - 30)
//            return CGSize(width: itemW, height: 150.0)
            
             let itemW = (screenWidth - 30.0)
            return CGSize(width: itemW, height: 165.0)
        }
        
        
        let itemW = (screenWidth - 45.0)/2
            return CGSize(width: itemW, height: 269.5 * ls_w)
        }
     }
    

    /// MARK: - 边框距离
    
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
           if collectionView.tag !=  10000 {
            return  UIEdgeInsets(top: 35, left: 0, bottom: 0, right: 0)
           }
        if section == 0{
            return  UIEdgeInsets(top: (180/375)*kScreenWidth, left: 0, bottom: 0, right: 0)
        }
        return  UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
       
    }
    

    /// MARK: - 行最小间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView.tag !=  10000 {
            return 0.0
        }
        return 14.0
    }
    
    /// MARK: - 列最小间距
     
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }

    
}




extension HomeViewController: LLCycleScrollViewDelegate {
    func cycleScrollView(_ cycleScrollView: LLCycleScrollView, didSelectItemIndex index: NSInteger) {
        
        let model = self.slideshowList[index]
        self.didSelectItemAtImag(model)
    }
}

