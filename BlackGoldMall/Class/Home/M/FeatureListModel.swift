//
//	FeatureListModel.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class FeatureListModel : NSObject, Codable,NSCoding{

	var goodsId : Int!
	var homeImgId : Int!
	var imgType : Int!
	var imgUrl : String!
	var type : Int!
	var url : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		goodsId = dictionary["goodsId"] as? Int
		homeImgId = dictionary["homeImgId"] as? Int
		imgType = dictionary["imgType"] as? Int
		imgUrl = dictionary["imgUrl"] as? String
		type = dictionary["type"] as? Int
		url = dictionary["url"] as? String
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if goodsId != nil{
			dictionary["goodsId"] = goodsId
		}
		if homeImgId != nil{
			dictionary["homeImgId"] = homeImgId
		}
		if imgType != nil{
			dictionary["imgType"] = imgType
		}
		if imgUrl != nil{
			dictionary["imgUrl"] = imgUrl
		}
		if type != nil{
			dictionary["type"] = type
		}
		if url != nil{
			dictionary["url"] = url
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         goodsId = aDecoder.decodeObject(forKey: "goodsId") as? Int
         homeImgId = aDecoder.decodeObject(forKey: "homeImgId") as? Int
         imgType = aDecoder.decodeObject(forKey: "imgType") as? Int
         imgUrl = aDecoder.decodeObject(forKey: "imgUrl") as? String
         type = aDecoder.decodeObject(forKey: "type") as? Int
         url = aDecoder.decodeObject(forKey: "url") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if goodsId != nil{
			aCoder.encode(goodsId, forKey: "goodsId")
		}
		if homeImgId != nil{
			aCoder.encode(homeImgId, forKey: "homeImgId")
		}
		if imgType != nil{
			aCoder.encode(imgType, forKey: "imgType")
		}
		if imgUrl != nil{
			aCoder.encode(imgUrl, forKey: "imgUrl")
		}
		if type != nil{
			aCoder.encode(type, forKey: "type")
		}
		if url != nil{
			aCoder.encode(url, forKey: "url")
		}

	}

}
