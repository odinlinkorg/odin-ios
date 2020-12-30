//
//	SuanLiDetail.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class SuanLiDetail : NSObject,Codable, NSCoding{

	var address : String!
	var createBy : String!
	var createTime : String!
	var ahash : String!
	var hashResult : String!
	var operateType : String!
	var power : Int!
	var remark : String!
	var searchValue : String!
	var updateBy : String!
	var updateTime : String!
	var userId : Int!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		address = dictionary["address"] as? String
		createBy = dictionary["createBy"] as? String
		createTime = dictionary["createTime"] as? String
		ahash = dictionary["hash"] as? String
		hashResult = dictionary["hashResult"] as? String
		operateType = dictionary["operateType"] as? String
		power = dictionary["power"] as? Int
		remark = dictionary["remark"] as? String
		searchValue = dictionary["searchValue"] as? String
		updateBy = dictionary["updateBy"] as? String
		updateTime = dictionary["updateTime"] as? String
		userId = dictionary["userId"] as? Int
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if address != nil{
			dictionary["address"] = address
		}
		if createBy != nil{
			dictionary["createBy"] = createBy
		}
		if createTime != nil{
			dictionary["createTime"] = createTime
		}
		if ahash != nil{
			dictionary["hash"] = ahash
		}
		if hashResult != nil{
			dictionary["hashResult"] = hashResult
		}
		if operateType != nil{
			dictionary["operateType"] = operateType
		}
		if power != nil{
			dictionary["power"] = power
		}
		if remark != nil{
			dictionary["remark"] = remark
		}
		if searchValue != nil{
			dictionary["searchValue"] = searchValue
		}
		if updateBy != nil{
			dictionary["updateBy"] = updateBy
		}
		if updateTime != nil{
			dictionary["updateTime"] = updateTime
		}
		if userId != nil{
			dictionary["userId"] = userId
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         address = aDecoder.decodeObject(forKey: "address") as? String
         createBy = aDecoder.decodeObject(forKey: "createBy") as? String
         createTime = aDecoder.decodeObject(forKey: "createTime") as? String
         ahash = aDecoder.decodeObject(forKey: "hash") as? String
         hashResult = aDecoder.decodeObject(forKey: "hashResult") as? String
         operateType = aDecoder.decodeObject(forKey: "operateType") as? String
         power = aDecoder.decodeObject(forKey: "power") as? Int
         remark = aDecoder.decodeObject(forKey: "remark") as? String
         searchValue = aDecoder.decodeObject(forKey: "searchValue") as? String
         updateBy = aDecoder.decodeObject(forKey: "updateBy") as? String
         updateTime = aDecoder.decodeObject(forKey: "updateTime") as? String
         userId = aDecoder.decodeObject(forKey: "userId") as? Int

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if address != nil{
			aCoder.encode(address, forKey: "address")
		}
		if createBy != nil{
			aCoder.encode(createBy, forKey: "createBy")
		}
		if createTime != nil{
			aCoder.encode(createTime, forKey: "createTime")
		}
		if ahash != nil{
			aCoder.encode(ahash, forKey: "hash")
		}
		if hashResult != nil{
			aCoder.encode(hashResult, forKey: "hashResult")
		}
		if operateType != nil{
			aCoder.encode(operateType, forKey: "operateType")
		}
		if power != nil{
			aCoder.encode(power, forKey: "power")
		}
		if remark != nil{
			aCoder.encode(remark, forKey: "remark")
		}
		if searchValue != nil{
			aCoder.encode(searchValue, forKey: "searchValue")
		}
		if updateBy != nil{
			aCoder.encode(updateBy, forKey: "updateBy")
		}
		if updateTime != nil{
			aCoder.encode(updateTime, forKey: "updateTime")
		}
		if userId != nil{
			aCoder.encode(userId, forKey: "userId")
		}

	}

}
