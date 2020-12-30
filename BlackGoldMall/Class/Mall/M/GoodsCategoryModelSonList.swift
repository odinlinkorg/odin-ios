//
//	GoodsCategoryModelSonList.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class GoodsCategoryModelSonList : NSObject,Codable, NSCoding{

@objc	var cateName : String!
	var createBy : String!
	var createTime : String!
@objc	var icon : String!
  	var id : Int!
	var isDel : Int!
    
@objc var lsID : String!
	
@objc	var pid : String!
	var remark : String!
	var searchValue : String!
	var sort : Int!
	var updateBy : String!
	var updateTime : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		cateName = dictionary["cateName"] as? String
		createBy = dictionary["createBy"] as? String
		createTime = dictionary["createTime"] as? String
		icon = dictionary["icon"] as? String
		id = dictionary["id"] as? Int
		isDel = dictionary["isDel"] as? Int
		let pidlx = dictionary["pid"] as? Int
        pid = String(format: "%d", pidlx!)
		remark = dictionary["remark"] as? String
		searchValue = dictionary["searchValue"] as? String
		sort = dictionary["sort"] as? Int
		updateBy = dictionary["updateBy"] as? String
		updateTime = dictionary["updateTime"] as? String
         
        lsID = String(format: "%d", id!)
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
		if createBy != nil{
			dictionary["createBy"] = createBy
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
        
        if lsID != nil{
            dictionary["lsID"] = lsID
        }
        
		if isDel != nil{
			dictionary["isDel"] = isDel
		}
		
		if pid != nil{
            
			dictionary["pid"] = pid
            
		}
        
        
		if remark != nil{
			dictionary["remark"] = remark
		}
		if searchValue != nil{
			dictionary["searchValue"] = searchValue
		}
		if sort != nil{
			dictionary["sort"] = sort
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
         cateName = aDecoder.decodeObject(forKey: "cateName") as? String
         createBy = aDecoder.decodeObject(forKey: "createBy") as? String
         createTime = aDecoder.decodeObject(forKey: "createTime") as? String
         icon = aDecoder.decodeObject(forKey: "icon") as? String
         id = aDecoder.decodeObject(forKey: "id") as? Int
         isDel = aDecoder.decodeObject(forKey: "isDel") as? Int
         
         let pidls = aDecoder.decodeObject(forKey: "pid") as? Int
         pid = String(format: "%d", pidls!)
         remark = aDecoder.decodeObject(forKey: "remark") as? String
         searchValue = aDecoder.decodeObject(forKey: "searchValue") as? String
         sort = aDecoder.decodeObject(forKey: "sort") as? Int
         updateBy = aDecoder.decodeObject(forKey: "updateBy") as? String
         updateTime = aDecoder.decodeObject(forKey: "updateTime") as? String

        
        lsID = aDecoder.decodeObject(forKey: "lsID") as? String
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
		if createBy != nil{
			aCoder.encode(createBy, forKey: "createBy")
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
        
        if lsID != nil{
            aCoder.encode(lsID, forKey: "lsID")
        }
		if isDel != nil{
			aCoder.encode(isDel, forKey: "isDel")
		}
		
        
		if pid != nil{
			aCoder.encode(pid, forKey: "pid")
		}
		if remark != nil{
			aCoder.encode(remark, forKey: "remark")
		}
		if searchValue != nil{
			aCoder.encode(searchValue, forKey: "searchValue")
		}
		if sort != nil{
			aCoder.encode(sort, forKey: "sort")
		}
		if updateBy != nil{
			aCoder.encode(updateBy, forKey: "updateBy")
		}
		if updateTime != nil{
			aCoder.encode(updateTime, forKey: "updateTime")
		}

	}

}
