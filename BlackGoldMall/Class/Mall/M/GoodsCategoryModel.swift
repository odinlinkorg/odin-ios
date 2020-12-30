//
//	GoodsCategoryModel.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class GoodsCategoryModel : NSObject,Codable, NSCoding{

@objc	var cateName : String!
	var createTime : String!
	var icon : String!
	var id : Int!
	var isDel : Int!
	var pid : Int!
@objc	var sonList : [GoodsCategoryModelSonList]!
	var sort : Int!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		cateName = dictionary["cateName"] as? String
		createTime = dictionary["createTime"] as? String
		icon = dictionary["icon"] as? String
		id = dictionary["id"] as? Int
		isDel = dictionary["isDel"] as? Int
		pid = dictionary["pid"] as? Int
		sonList = [GoodsCategoryModelSonList]()
		if let sonListArray = dictionary["sonList"] as? [[String:Any]]{
			for dic in sonListArray{
				let value = GoodsCategoryModelSonList(fromDictionary: dic)
				sonList.append(value)
			}
		}
		sort = dictionary["sort"] as? Int
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if cateName != nil{
			dictionary["cateName"] = cateName
		}
		if createTime != nil{
			dictionary["createTime"] = createTime
		}
		if icon != nil{
			dictionary["icon"] = icon
		}
		if id != nil{
			dictionary["id"] = id
		}
		if isDel != nil{
			dictionary["isDel"] = isDel
		}
		if pid != nil{
			dictionary["pid"] = pid
		}
		if sonList != nil{
			var dictionaryElements = [[String:Any]]()
			for sonListElement in sonList {
				dictionaryElements.append(sonListElement.toDictionary())
			}
			dictionary["sonList"] = dictionaryElements
		}
		if sort != nil{
			dictionary["sort"] = sort
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         cateName = aDecoder.decodeObject(forKey: "cateName") as? String
         createTime = aDecoder.decodeObject(forKey: "createTime") as? String
         icon = aDecoder.decodeObject(forKey: "icon") as? String
         id = aDecoder.decodeObject(forKey: "id") as? Int
         isDel = aDecoder.decodeObject(forKey: "isDel") as? Int
         pid = aDecoder.decodeObject(forKey: "pid") as? Int
         sonList = aDecoder.decodeObject(forKey :"sonList") as? [GoodsCategoryModelSonList]
         sort = aDecoder.decodeObject(forKey: "sort") as? Int

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if cateName != nil{
			aCoder.encode(cateName, forKey: "cateName")
		}
		if createTime != nil{
			aCoder.encode(createTime, forKey: "createTime")
		}
		if icon != nil{
			aCoder.encode(icon, forKey: "icon")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if isDel != nil{
			aCoder.encode(isDel, forKey: "isDel")
		}
		if pid != nil{
			aCoder.encode(pid, forKey: "pid")
		}
		if sonList != nil{
			aCoder.encode(sonList, forKey: "sonList")
		}
		if sort != nil{
			aCoder.encode(sort, forKey: "sort")
		}

	}

}
