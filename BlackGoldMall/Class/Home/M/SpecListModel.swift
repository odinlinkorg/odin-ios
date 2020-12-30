//
//	SpecListModel.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


struct SpecListModel : Codable {
    
    /// 成本价
    var cost : Float!
    
    
    /// 创建时间
    var createTime : String!
    
    
    /// 算力
    var givePower : Int!
    
    
    /// 商品id
    var goodsId : Int!
    
    
    /// 商品图片
    var image : String!
    
    
    /// odin币售价
    var odinPrice : Double!
    

    
    /// 销量
    var sales : Int!
    
    
    /// 商城币售价
    var shopPrice : Double!
    
    
    /// 规格id
    var specId : Int!
    
    
    /// 规格名
    var specName : String!
    
    
    /// 库存
    var stock : Int!
    
    
    /// 店铺id
    var storeId : Int!

    
    
    /// 购买数量 -- 自己添加
    var payNum : Int!
    
    
    /// 购买备注 -- 自己添加
    var payRemark : String!
    
}
