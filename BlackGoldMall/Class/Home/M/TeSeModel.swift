//
//	TeSeModel.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct TeSeModel : Codable {
    
    /// 分类id
    var cateId : Int!
    
    /// 成本价
    var cost : Double!
    
    /// 创建时间
    var createTime : String!
    
    /// 算力
    var givePower : Int!
    
    
    /// 商品id
    var goodsId : Int!
    
    
    /// 商品简介
    var goodsInfo : String!
    
    
    /// 商品名称
    var goodsName : String!
    
    
    /// 商品图片
    var image : String!
    
    
    /// odin币售价
    var odinPrice : Double!
    
    /// price
    var price : Double!
    
    /// 销量
    var sales : Int!
   
    
    /// 商城币售价
    var shopPrice : Double!
    
    
    /// 轮播图
    var sliderImage : String!
  
    
    /// 库存
    var stock : Int!
    
    
    /// 商户id
    var storeId : Int!
    
    
    /// 商户名称
    var storeName : String!
    
    /// 单位名
    var unitName : String!
    
    
    /// 虚拟销量
    var virtualSales : Int!
    
    
    /// 商品详情
    var description : String!
    
    
    /// 规格集合
    var specList : [SpecListModel]!
}

