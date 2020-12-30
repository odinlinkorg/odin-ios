//
//  ShopCurrentPriceModel.swift
//  BlackGoldMall
//
//  Created by odin on 2020/10/9.
//  Copyright © 2020 黑金商城. All rights reserved.
//

import Foundation


class ShopCurrentPriceModel : NSObject,Codable, NSCoding{
    
    var power : Int!
    var shopPrice : Int!
    var odinPrice : Int!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){

        power = dictionary["power"] as? Int
        shopPrice = dictionary["shopPrice"] as? Int
        odinPrice = dictionary["odinPrice"] as? Int
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if power != nil{
            dictionary["power"] = power
        }
        if shopPrice != nil{
            dictionary["shopPrice"] = shopPrice
        }
        if odinPrice != nil{
            dictionary["odinPrice"] = odinPrice
        }
        
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        power = aDecoder.decodeObject(forKey: "power") as? Int
        shopPrice = aDecoder.decodeObject(forKey: "shopPrice") as? Int
        odinPrice = aDecoder.decodeObject(forKey: "odinPrice") as? Int
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if power != nil{
            aCoder.encode(power, forKey: "power")
        }
        if shopPrice != nil{
            aCoder.encode(shopPrice, forKey: "shopPrice")
        }
        if odinPrice != nil{
            aCoder.encode(odinPrice, forKey: "odinPrice")
        }
    }
    
}
