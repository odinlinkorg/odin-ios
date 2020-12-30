//
//  MaiGuiGelController.swift
//  BlackGoldMall
//
//  Created by 永芯 on 2020/8/20.
//  Copyright © 2020 黑金商城. All rights reserved.
//

import UIKit

class MaiGuiGelController: BaseViewController,HSCollectionViewProtocol{
//    var SpecListArr:[SpecListModel]!
    var goodsInfoByGoodsIdModel : TeSeModel!
    @IBOutlet weak var numberF: UITextField!
    typealias funBlock = (SpecListModel) -> ()
    var block : funBlock?
    var selectRow:Int!
    @IBOutlet weak var collectionView: UICollectionView!
   
    @IBOutlet weak var storeName: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var imageV: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
       
    
        let flowLayout = UICollectionViewFlowLayout()
       flowLayout.minimumInteritemSpacing = 10;
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
       flowLayout.scrollDirection = .horizontal
//===== CELL 约束自适应 必备条件 1 =====
      if #available(iOS 10.0, *) {
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
      } else {
        flowLayout.estimatedItemSize = CGSize(width: 15, height: 40.0)
      }
         collectionView.collectionViewLayout = flowLayout
         collectionView.register(UINib.init(nibName: "MailGuiGeDetailsCollectionCell", bundle: nil), forCellWithReuseIdentifier: "MailGuiGeDetailsCollectionCell")
         collectionView.backgroundColor = .clear
         collectionView.delegate = self
         collectionView.dataSource = self
         collectionView.showsHorizontalScrollIndicator = false
       
        collectionView.collectionViewLayout.invalidateLayout()
         collectionView.reloadData()
    }
    
    func setSpecListArr( agoodsInfoByGoodsIdModel: TeSeModel){
       
        goodsInfoByGoodsIdModel = agoodsInfoByGoodsIdModel
      
        if((goodsInfoByGoodsIdModel) != nil){
                 
            imageV.kf.setImage(with: URL.init(string: goodsInfoByGoodsIdModel.image), placeholder: nil, options: [.forceRefresh])
            storeName.text = goodsInfoByGoodsIdModel.storeName
            priceLabel.text =  String(format: "%.2lf ODIN/", goodsInfoByGoodsIdModel.odinPrice) + String(format: "%.2lf BGC", goodsInfoByGoodsIdModel.shopPrice)
        }
        collectionView.reloadData()
    }
    
    
    @IBAction func jianButtonAction(_ sender: Any) {
        let myNumberInt = Int(numberF.text!)
        var num : Int = myNumberInt! - 1
        
        if num <= 1{
            num = 1
        }
        
        numberF.text = String(num)
    }
    
    @IBAction func jiaButtonAction(_ sender: Any) {
        let myNumberInt = Int(numberF.text!)
        let num = myNumberInt! + 1
        numberF.text = String(num)
    }
    
    @IBAction func buttonAction(_ sender: Any) {
       
        if (selectRow != nil) {
            var model = goodsInfoByGoodsIdModel.specList[selectRow]
            model.payNum = Int(numberF.text!)
                   block!(model)
             self.dismiss(animated: true, completion: nil)
        }else{
            MBProgressHUD.showText("请选择商品规格")
        }
       
    }
    
    @IBAction func touchBackAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
     override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
     }

    
}

extension MaiGuiGelController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        if self.goodsInfoByGoodsIdModel != nil{
            return self.goodsInfoByGoodsIdModel.specList.count
        }
        return 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
     
        
        let cell:MailGuiGeDetailsCollectionCell = cellWithCollectionView(collectionView, indexPath: indexPath)
        cell.backgroundColor = .white
        cell.gsLabel.text = self.goodsInfoByGoodsIdModel.specList[indexPath.row].specName
        if selectRow != nil{
            if selectRow == indexPath.row {
                cell.bgV.backgroundColor = UIColor.init(hex: 0xFFD0D4)
                cell.gsLabel.textColor = UIColor.init(hex: 0xDD1523)
            }else{
                cell.bgV.backgroundColor = UIColor.init(hex: 0xF1F1F1)
                cell.gsLabel.textColor = UIColor.init(hex:0x333333 )
            }
        }
        return cell
            
        
    }

    //    MARK: - item 点击
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       let model = self.goodsInfoByGoodsIdModel.specList[indexPath.row]
        imageV.kf.setImage(with: URL.init(string: model.image), placeholder: nil, options: [.forceRefresh])
               
        priceLabel.text =  String(format: "%.2lf ODIN/", model.odinPrice) + String(format: "%.2lf BGC", model.shopPrice)
        selectRow = indexPath.row
        collectionView.reloadData()
       
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      
        return CGSize(width: 0.01, height: 40.0)

     }
    

   
    
}

