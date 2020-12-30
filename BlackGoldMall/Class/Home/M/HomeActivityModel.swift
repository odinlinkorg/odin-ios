//
//	HomeActivityModel.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


struct  HomeActivityListModel : Codable {
    
    /// 标题
    var title :String!
    
    
    /// 活动id
    var activityId :Int!
    
    
    /// 图标
    var icon : String!
}



struct  HomeActivityByIdModel : Codable {
    
    /// 商品集合
    var goodsList : [HomeGoodsModelItem]!
    
    
    /// 小活动标题
    var title : String!
}
