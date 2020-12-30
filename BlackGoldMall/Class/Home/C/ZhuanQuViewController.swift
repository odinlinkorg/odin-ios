//
//  ZhuanQuViewController.swift
//  BlackGoldMall
//
//  Created by 永芯 on 2020/8/20.
//  Copyright © 2020 黑金商城. All rights reserved.
//

import UIKit

class ZhuanQuViewController: BaseViewController,HSCollectionViewProtocol{


    var collectionViewTop: UICollectionView!
    var collectionView: UICollectionView!

    var dataList = [HomeActivityByIdModel]()
    var homeActivityModel : HomeActivityListModel!
    var aindexSelect :Int!
    
   
//    var  dataList : Array<Array<TeSeModel>>  = []
    override func viewDidLoad() {
        super.viewDidLoad()
//        title = "9.9专区"
        
        ZhuanQuLayout.layout(zhuanquVC: self)
        addRefresh(refreshView: collectionView)
        collectionView.mj_footer?.isHidden = true
        sendNetRequest()
        setupMyEmptyView(tableView: collectionView)
    }
    
    func setModel (_ huodongModel: HomeActivityListModel){
        homeActivityModel = huodongModel
    }

    override func sendNetRequest(){
//      HomeActivityByIdModel
        NetworkManager<HomeActivityByIdModel>().requestListModel(  API.homeGetHomeActivityInfo(activityId: String(homeActivityModel.activityId)), completion: { (response) in
            self.endRefresh(refreshView: self.collectionView)
         
            if let list = response?.list{
                
                self.dataList.removeAll()
                
                self.dataList.append(contentsOf: list)


                if self.dataList.count !=  0{
                     self.aindexSelect = 0
                }
                    
                self.collectionViewTop.reloadData()
                self.collectionView.reloadData()
                self.hide_showEmptyView(self.collectionView, self.dataList.count)
            }
            }) { (error) in
                self.endRefresh(refreshView: self.collectionView)
                if let msg = error.message {
                MBProgressHUD.showText(msg)
                }
            
        }
    }
}


extension ZhuanQuViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionViewTop {
            return self.dataList.count
        }
        if (aindexSelect != nil) {
           
            return self.dataList[aindexSelect].goodsList.count
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionViewTop{
        
            let cell:TopLeiBieViewCell = cellWithCollectionView(collectionView, indexPath: indexPath)
            if indexPath.row == aindexSelect {
                cell.titlabel.textColor = .white
                cell.bgView.backgroundColor =  UIColor.init(hex: 0xDD1524)
            }else{
                cell.titlabel.textColor =  UIColor.init(hex: 0x121212)
                cell.bgView.backgroundColor =  UIColor.init(hex:0xF1F1F1 )
            }
            if self.dataList.count > 0 {
                 cell.titlabel.text = self.dataList[aindexSelect].title
            }
           
            cell.backgroundColor = .white
                   
            return cell
        }
        let cell:HomeBigCollectionCell = cellWithCollectionView(collectionView, indexPath: indexPath)
            cell.backgroundColor = .white
        if self.dataList.count > 0 {
            cell.setModel(self.dataList[aindexSelect].goodsList[indexPath.row])
        }
        
        return cell
            
        
    }

    //    MARK: - item 点击
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        if collectionView == collectionViewTop{
            aindexSelect = indexPath.row
            collectionViewTop.reloadData()
            self.collectionView.reloadData()
            return
        }
        let vc = MailDetailsController.init()
        let goodsId = String(self.dataList[aindexSelect].goodsList[indexPath.row].goodsId)
        vc.setgoodsId(goodsId)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView ==  collectionViewTop {
            return CGSize(width: kScreenWidth/3, height: 67.0)
        }
        let ls_w =  screenWidth / 375.0
        
        
        let itemW = (screenWidth - 45.0)/2
        return CGSize(width: itemW, height: 269.5 * ls_w)
        
     }
    
    
    //     MARK: - 边框距离
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
           if collectionView ==  collectionViewTop {
            return  UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
           }
        return  UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
       
    }
    
    //    MARK: - 行最小间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView  ==  collectionViewTop {
            return 0.0
        }
        return 14.0
    }
    
//      MARK: - 列最小间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}





