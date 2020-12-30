//
//	SystemInformsModel.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class SystemInformsModel : NSObject, Codable ,NSCoding{

	var createBy : String!
	var createTime : String!
	var id : Int!
	var informValue : String!
	var remark : String!
	var searchValue : String!
	var status : String!
	var title : String!
	var type : String!
	var updateBy : String!
	var updateTime : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		createBy = dictionary["createBy"] as? String
		createTime = dictionary["createTime"] as? String
		id = dictionary["id"] as? Int
		informValue = dictionary["informValue"] as? String
		remark = dictionary["remark"] as? String
		searchValue = dictionary["searchValue"] as? String
		status = dictionary["status"] as? String
		title = dictionary["title"] as? String
		type = dictionary["type"] as? String
		updateBy = dictionary["updateBy"] as? String
		updateTime = dictionary["updateTime"] as? String
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if createBy != nil{
			dictionary["createBy"] = createBy
		}
		if createTime != nil{
			dictionary["createTime"] = createTime
		}
		if id != nil{
			dictionary["id"] = id
		}
		if informValue != nil{
			dictionary["informValue"] = informValue
		}
		if remark != nil{
			dictionary["remark"] = remark
		}
		if searchValue != nil{
			dictionary["searchValue"] = searchValue
		}
		if status != nil{
			dictionary["status"] = status
		}
		if title != nil{
			dictionary["title"] = title
		}
		if type != nil{
			dictionary["type"] = type
		}
		if updateBy != nil{
			dictionary["updateBy"] = updateBy
		}
		if updateTime != nil{
			dictionary["updateTime"] = updateTime
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         createBy = aDecoder.decodeObject(forKey: "createBy") as? String
         createTime = aDecoder.decodeObject(forKey: "createTime") as? String
         id = aDecoder.decodeObject(forKey: "id") as? Int
         informValue = aDecoder.decodeObject(forKey: "informValue") as? String
         remark = aDecoder.decodeObject(forKey: "remark") as? String
         searchValue = aDecoder.decodeObject(forKey: "searchValue") as? String
         status = aDecoder.decodeObject(forKey: "status") as? String
         title = aDecoder.decodeObject(forKey: "title") as? String
         type = aDecoder.decodeObject(forKey: "type") as? String
         updateBy = aDecoder.decodeObject(forKey: "updateBy") as? String
         updateTime = aDecoder.decodeObject(forKey: "updateTime") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if createBy != nil{
			aCoder.encode(createBy, forKey: "createBy")
		}
		if createTime != nil{
			aCoder.encode(createTime, forKey: "createTime")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if informValue != nil{
			aCoder.encode(informValue, forKey: "informValue")
		}
		if remark != nil{
			aCoder.encode(remark, forKey: "remark")
		}
		if searchValue != nil{
			aCoder.encode(searchValue, forKey: "searchValue")
		}
		if status != nil{
			aCoder.encode(status, forKey: "status")
		}
		if title != nil{
			aCoder.encode(title, forKey: "title")
		}
		if type != nil{
			aCoder.encode(type, forKey: "type")
		}
		if updateBy != nil{
			aCoder.encode(updateBy, forKey: "updateBy")
		}
		if updateTime != nil{
			aCoder.encode(updateTime, forKey: "updateTime")
		}

	}

}
